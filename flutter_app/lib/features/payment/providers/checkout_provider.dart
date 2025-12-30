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
/// Tüm checkout akışını yönetir:
/// 1. idle -> sipariş oluştur
/// 2. creatingOrder -> PayTR init al
/// 3. initializingPayment -> WebView aç
/// 4. awaitingPayment -> kullanıcı ödeme yapıyor
/// 5. verifyingPayment -> sipariş durumu kontrol et
/// 6. completed / failed
class CheckoutNotifier extends StateNotifier<CheckoutState> {
  final OrdersRepository _ordersRepository;
  final PayTRService _paytrService;
  final Ref _ref;

  CheckoutNotifier(this._ordersRepository, this._paytrService, this._ref)
      : super(const CheckoutState());

  /// Checkout akışını başlat
  ///
  /// 1. Backend'de sipariş oluştur (sepetten otomatik)
  /// 2. PayTR Direct API init çağır
  /// 3. WebView'a yönlendir
  Future<void> startCheckout({
    required Cart cart,
    int installmentCount = 0,
  }) async {
    if (cart.items.isEmpty) {
      state = state.copyWith(
        status: CheckoutStatus.failed,
        errorMessage: 'Sepet boş',
      );
      return;
    }

    try {
      // 1. Sipariş oluştur
      state = state.copyWith(status: CheckoutStatus.creatingOrder);
      final order = await _ordersRepository.createOrder();

      state = state.copyWith(
        status: CheckoutStatus.initializingPayment,
        orderId: order.id,
      );

      // 2. Kullanıcı bilgilerini al
      final authState = _ref.read(authProvider);
      final user = authState.user;
      final currentAddress = _ref.read(currentAddressDataProvider);

      if (user == null) {
        throw Exception('Kullanıcı bilgisi bulunamadı');
      }

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
          if (currentAddress.neighborhood != null) currentAddress.neighborhood!,
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
          price: price, // TL cinsinden (backend kuruşa çevirir)
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
        merchantOid: order.id,
        email: user.email,
        paymentAmount: totalAmount, // TL cinsinden
        installmentCount: installmentCount,
        userName: user.name ?? 'Müşteri',
        userAddress: addressString,
        userPhone: phone,
        basket: basketItems,
      );

      // 4. PayTR Direct API çağır
      final paytrResponse = await _paytrService.initDirectPayment(request);

      state = state.copyWith(
        status: CheckoutStatus.awaitingPayment,
        paytrResponse: paytrResponse,
      );
    } catch (e) {
      state = state.copyWith(
        status: CheckoutStatus.failed,
        errorMessage: e.toString(),
      );
    }
  }

  /// Ödeme başarılı - sipariş durumunu kontrol et
  Future<void> verifyPayment() async {
    if (state.orderId == null) {
      state = state.copyWith(
        status: CheckoutStatus.failed,
        errorMessage: 'Sipariş ID bulunamadı',
      );
      return;
    }

    state = state.copyWith(status: CheckoutStatus.verifyingPayment);

    try {
      // Sipariş durumunu backend'den al (polling)
      // PayTR callback backend'e geldiğinde sipariş güncellenir
      int attempts = 0;
      const maxAttempts = 30; // 30 saniye
      const delay = Duration(seconds: 1);

      while (attempts < maxAttempts) {
        final order = await _ordersRepository.getOrderDetail(state.orderId!);
        final paymentStatus = order.payment?['status'] as String?;

        if (paymentStatus == 'succeeded') {
          // Sepeti temizle
          await _ref.read(cartProvider.notifier).clearCart();

          state = state.copyWith(status: CheckoutStatus.completed);
          return;
        } else if (paymentStatus == 'failed') {
          state = state.copyWith(
            status: CheckoutStatus.failed,
            errorMessage: 'Ödeme başarısız oldu',
          );
          return;
        }

        // Henüz güncellenmedi, bekle ve tekrar dene
        await Future.delayed(delay);
        attempts++;
      }

      // Timeout - ödeme sonucu alınamadı
      state = state.copyWith(
        status: CheckoutStatus.failed,
        errorMessage:
            'Ödeme doğrulaması zaman aşımına uğradı. Siparişlerim sayfasından kontrol edebilirsiniz.',
      );
    } catch (e) {
      state = state.copyWith(
        status: CheckoutStatus.failed,
        errorMessage: e.toString(),
      );
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

  /// Sipariş ID'sini getir (WebView sonrası için)
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

