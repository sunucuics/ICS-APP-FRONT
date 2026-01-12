import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../../../core/models/cart_model.dart';
import '../../cart/providers/cart_provider.dart';
import '../../orders/providers/orders_provider.dart';
import '../../orders/data/orders_repository.dart';
import '../../auth/providers/auth_provider.dart';
import '../../addresses/providers/addresses_provider.dart';
import '../data/paytr_service.dart';
import '../models/paytr_models.dart';

/// PayTR Service Provider
final paytrServiceProvider = Provider<PayTRService>((ref) {
  final dio = ref.read(apiClientProvider);
  return PayTRService(dio);
});

/// Checkout State Notifier
///
/// Yeni Payment Session mimarisi ile checkout akışını yönetir:
/// 1. idle -> merchant_oid üret
/// 2. initializingPayment -> PayTR init al
/// 3. awaitingPayment -> WebView aç, kullanıcı ödeme yapıyor
/// 4. verifyingPayment -> callback sonrası sipariş durumu kontrol et
/// 5. completed / failed
///
/// NOT: Sipariş artık frontend'de oluşturulmuyor!
/// Sipariş, PayTR callback success geldiğinde backend tarafından oluşturuluyor.
class CheckoutNotifier extends StateNotifier<CheckoutState> {
  final OrdersRepository _ordersRepository;
  final PayTRService _paytrService;
  final Ref _ref;

  CheckoutNotifier(this._ordersRepository, this._paytrService, this._ref)
      : super(const CheckoutState());

  /// Benzersiz merchant_oid üret
  /// Format: YYYYMMDDHHmmss + 6 random alfanümerik karakter
  /// Örnek: 20260105143022A1B2C3
  String _generateMerchantOid() {
    final now = DateTime.now();
    final timestamp = '${now.year}'
        '${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}'
        '${now.hour.toString().padLeft(2, '0')}'
        '${now.minute.toString().padLeft(2, '0')}'
        '${now.second.toString().padLeft(2, '0')}';

    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final randomSuffix =
        List.generate(6, (_) => chars[random.nextInt(chars.length)]).join();

    return '$timestamp$randomSuffix';
  }

  /// BIN numarası ile taksit seçeneklerini sorgula
  ///
  /// Kart numarasının ilk 6-8 hanesi girildiğinde çağrılır.
  /// Backend'den peşin ve 3 taksit seçeneklerini alır.
  Future<void> fetchInstallmentQuote({
    required String binNumber,
    required double amountTl,
  }) async {
    if (binNumber.replaceAll(' ', '').length < 6) {
      // BIN henüz yeterli değil
      state = state.copyWith(
        installmentQuote: null,
        binNumber: null,
      );
      return;
    }

    try {
      final quote = await _paytrService.getInstallmentQuote(
        binNumber: binNumber,
        amountTl: amountTl,
      );

      state = state.copyWith(
        installmentQuote: quote,
        binNumber: binNumber.replaceAll(' ', ''),
        // Debit kart ise taksit seçimini sıfırla
        selectedInstallment: quote.isDebitCard ? 0 : state.selectedInstallment,
      );
    } catch (e) {
      // Hata durumunda sadece peşin göster
      state = state.copyWith(
        installmentQuote: null,
        binNumber: binNumber.replaceAll(' ', ''),
        selectedInstallment: 0,
      );
    }
  }

  /// Taksit seçimini güncelle
  /// Sadece 0 (peşin) veya 3 (3 taksit) kabul edilir.
  void selectInstallment(int count) {
    if (count != 0 && count != 3) return;

    // 3 taksit için kredi kartı gerekli
    if (count == 3) {
      final quote = state.installmentQuote;
      if (quote == null || !quote.has3Installment) {
        return; // 3 taksit mevcut değil
      }
    }

    state = state.copyWith(selectedInstallment: count);
  }

  /// Checkout akışını başlat
  ///
  /// YENİ AKIŞ (Payment Session):
  /// 1. merchant_oid üret (sipariş değil, payment session ID)
  /// 2. PayTR Direct API init çağır
  /// 3. WebView'a yönlendir
  ///
  /// NOT: Sipariş artık burada oluşturulmuyor!
  /// Backend, PayTR callback success geldiğinde siparişi oluşturacak.
  Future<void> startCheckout({
    required Cart cart,
    int? installmentCount,
    String? binNumber,
  }) async {
    if (cart.items.isEmpty) {
      state = state.copyWith(
        status: CheckoutStatus.failed,
        errorMessage: 'Sepet boş',
      );
      return;
    }

    // Taksit sayısını belirle
    final finalInstallment = installmentCount ?? state.selectedInstallment;
    final finalBinNumber = binNumber ?? state.binNumber;

    // 3 taksit için BIN zorunlu
    if (finalInstallment == 3 &&
        (finalBinNumber == null || finalBinNumber.isEmpty)) {
      state = state.copyWith(
        status: CheckoutStatus.failed,
        errorMessage: '3 taksit için kart numarası gereklidir',
      );
      return;
    }

    try {
      state = state.copyWith(status: CheckoutStatus.initializingPayment);

      // 1. Kullanıcı bilgilerini al
      final authState = _ref.read(authProvider);
      final user = authState.user;
      final currentAddress = _ref.read(currentAddressDataProvider);

      if (user == null) {
        throw Exception('Kullanıcı bilgisi bulunamadı');
      }

      // 2. merchant_oid üret (payment session ID)
      final merchantOid = _generateMerchantOid();

      // Adres bilgisini string olarak oluştur
      String addressString = 'Adres bilgisi yok';
      if (currentAddress != null) {
        final parts = <String>[
          if (currentAddress.label != null) currentAddress.label!,
          if (currentAddress.street != null) currentAddress.street!,
          if (currentAddress.buildingNo != null)
            'No: ${currentAddress.buildingNo}',
          if (currentAddress.apartment != null)
            'Daire: ${currentAddress.apartment}',
          if (currentAddress.floor != null) 'Kat: ${currentAddress.floor}',
          if (currentAddress.neighborhood != null)
            currentAddress.neighborhood!,
          if (currentAddress.district != null) currentAddress.district!,
          if (currentAddress.city != null) currentAddress.city!,
        ];
        addressString = parts.join(', ');
      }

      // Telefon numarası - user.phone veya varsayılan
      final phone = user.phone ?? '5000000000';

      // Sepet öğelerini PayTR formatına çevir
      final basketItems = cart.items.map((item) {
        final price = item.finalPrice ?? item.price;
        return BasketItem(
          name: item.title,
          price: price, // TL cinsinden
          quantity: item.qty,
        );
      }).toList();

      // Toplam tutarı hesapla
      final totalAmount = cart.items.fold<double>(0.0, (sum, item) {
        final price = item.finalPrice ?? item.price;
        return sum + (price * item.qty);
      });

      // 3. PayTR init isteği oluştur
      final request = PayTRInitRequest(
        merchantOid: merchantOid,
        email: user.email,
        paymentAmount: totalAmount, // TL cinsinden
        installmentCount: finalInstallment,
        userName: user.name ?? 'Müşteri',
        userAddress: addressString,
        userPhone: phone,
        basket: basketItems,
        binNumber: finalInstallment == 3 ? finalBinNumber : null,
      );

      // 4. PayTR Direct API çağır
      final paytrResponse = await _paytrService.initDirectPayment(request);

      state = state.copyWith(
        status: CheckoutStatus.awaitingPayment,
        merchantOid: merchantOid,
        paytrResponse: paytrResponse,
        selectedInstallment: finalInstallment,
        binNumber: finalBinNumber,
      );
    } catch (e) {
      state = state.copyWith(
        status: CheckoutStatus.failed,
        errorMessage: _parseErrorMessage(e.toString()),
      );
    }
  }

  /// Ödeme sonucunu doğrula
  ///
  /// PayTR redirect sonrası çağrılır.
  /// Backend, callback ile siparişi oluşturur/günceller.
  /// Bu metod sipariş durumunu polling ile kontrol eder.
  Future<void> verifyPayment() async {
    if (state.merchantOid == null) {
      state = state.copyWith(
        status: CheckoutStatus.failed,
        errorMessage: 'Ödeme oturumu bulunamadı',
      );
      return;
    }

    state = state.copyWith(status: CheckoutStatus.verifyingPayment);

    try {
      // Sipariş durumunu backend'den al (polling)
      // PayTR callback backend'e geldiğinde sipariş oluşturulur/güncellenir
      int attempts = 0;
      const maxAttempts = 15; // 15 saniye (local'de daha kısa)
      const delay = Duration(seconds: 1);

      while (attempts < maxAttempts) {
        try {
          // merchant_oid = sipariş ID (callback sonrası oluşuyor)
          final order =
              await _ordersRepository.getOrderDetail(state.merchantOid!);
          final paymentStatus = order.payment?['status'] as String?;

          if (paymentStatus == 'succeeded') {
            // Sepeti temizle
            await _ref.read(cartProvider.notifier).clearCart();

            state = state.copyWith(
              status: CheckoutStatus.completed,
              orderId: order.id,
            );
            return;
          } else if (paymentStatus == 'failed') {
            state = state.copyWith(
              status: CheckoutStatus.failed,
              errorMessage: 'Ödeme başarısız oldu',
            );
            return;
          }
        } catch (e) {
          // Sipariş henüz oluşturulmamış olabilir - devam et
        }

        // Henüz güncellenmedi, bekle ve tekrar dene
        await Future.delayed(delay);
        attempts++;
      }

      // Timeout - ödeme sonucu alınamadı
      // Local geliştirme ortamında PayTR callback localhost'a ulaşamaz
      state = state.copyWith(
        status: CheckoutStatus.failed,
        errorMessage:
            'Ödeme doğrulaması zaman aşımına uğradı.\n\nLocal ortamda test ediyorsanız, PayTR callback localhost\'a ulaşamaz. Production ortamında bu sorun olmayacaktır.\n\nSiparişlerim sayfasından kontrol edebilirsiniz.',
      );
    } catch (e) {
      state = state.copyWith(
        status: CheckoutStatus.failed,
        errorMessage: e.toString(),
      );
    }
  }

  /// Taksit değişikliği için token yenile
  ///
  /// WebView açıkken taksit değiştirildiğinde çağrılır.
  Future<PayTRInitResponse?> refreshPaymentToken({
    required int installmentCount,
    String? binNumber,
  }) async {
    if (state.merchantOid == null) return null;

    final finalBinNumber = binNumber ?? state.binNumber;

    // 3 taksit için BIN zorunlu
    if (installmentCount == 3 &&
        (finalBinNumber == null || finalBinNumber.isEmpty)) {
      throw Exception('3 taksit için kart numarası gereklidir');
    }

    try {
      final response = await _paytrService.refreshToken(
        merchantOid: state.merchantOid!,
        installmentCount: installmentCount,
        binNumber: installmentCount == 3 ? finalBinNumber : null,
      );

      state = state.copyWith(
        paytrResponse: response,
        selectedInstallment: installmentCount,
        binNumber: finalBinNumber,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Ödeme başarısız oldu
  void paymentFailed(String? errorMessage) {
    state = state.copyWith(
      status: CheckoutStatus.failed,
      errorMessage: errorMessage ?? 'Ödeme işlemi başarısız oldu',
    );
  }

  /// Durumu sıfırla
  void reset() {
    state = const CheckoutState();
  }

  /// Hata mesajını parse et
  /// 
  /// Backend'den gelen hata kodlarını kullanıcı dostu Türkçe mesajlara çevirir.
  /// Dokümandaki hata kodları:
  /// - 400 user_ip required
  /// - 400 3 taksit için bin_number zorunludur
  /// - 400 Banka kartı (debit) ile 3 taksit yapılamaz
  /// - 400 Bu kart taksit programına uygun değil (brand=none)
  /// - 400 Ödeme tutarı doğrulaması başarısız
  /// - 502 get-token failed
  String _parseErrorMessage(String error) {
    // Backend'den gelen spesifik hata mesajlarını Türkçeleştir
    if (error.contains('bin_number zorunludur')) {
      return '3 taksit için kart numarası gereklidir';
    }
    if (error.contains('Banka kartı') || error.contains('debit')) {
      return 'Banka kartı ile taksitli ödeme yapılamaz';
    }
    if (error.contains('taksit programına uygun değil')) {
      return 'Bu kart ile taksitli ödeme yapılamaz';
    }
    if (error.contains('user_ip required')) {
      return 'Bağlantı hatası, lütfen tekrar deneyin';
    }
    if (error.contains('Ödeme tutarı doğrulaması başarısız') || 
        error.contains('payment_amount')) {
      return 'Ödeme tutarı doğrulanamadı, lütfen tekrar deneyin';
    }
    if (error.contains('get-token failed') || error.contains('502')) {
      return 'Ödeme servisi şu an kullanılamıyor, lütfen daha sonra tekrar deneyin';
    }
    return error.replaceAll('Exception:', '').trim();
  }

  /// Getter'lar
  String? get merchantOid => state.merchantOid;
  String? get orderId => state.orderId;
}

/// Checkout Provider
final checkoutProvider =
    StateNotifierProvider<CheckoutNotifier, CheckoutState>((ref) {
  final ordersRepository = ref.read(ordersRepositoryProvider);
  final paytrService = ref.read(paytrServiceProvider);
  return CheckoutNotifier(ordersRepository, paytrService, ref);
});

/// Checkout durumu provider'ı (kolay erişim için)
final checkoutStatusProvider = Provider<CheckoutStatus>((ref) {
  return ref.watch(checkoutProvider).status;
});

/// Checkout hatası provider'ı
final checkoutErrorProvider = Provider<String?>((ref) {
  return ref.watch(checkoutProvider).errorMessage;
});

/// PayTR response provider'ı
final paytrResponseProvider = Provider<PayTRInitResponse?>((ref) {
  return ref.watch(checkoutProvider).paytrResponse;
});

/// Taksit seçenekleri provider'ı
final installmentQuoteProvider = Provider<InstallmentQuoteResponse?>((ref) {
  return ref.watch(checkoutProvider).installmentQuote;
});

/// Seçili taksit provider'ı
final selectedInstallmentProvider = Provider<int>((ref) {
  return ref.watch(checkoutProvider).selectedInstallment;
});
