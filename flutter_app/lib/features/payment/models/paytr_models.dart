import 'package:freezed_annotation/freezed_annotation.dart';

part 'paytr_models.freezed.dart';
part 'paytr_models.g.dart';

/// Sepet ürün bilgisi - PayTR'ye gönderilecek
@freezed
class BasketItem with _$BasketItem {
  const factory BasketItem({
    required String name,
    required double price, // TL cinsinden (örn: 10.00)
    required int quantity,
  }) = _BasketItem;

  factory BasketItem.fromJson(Map<String, dynamic> json) =>
      _$BasketItemFromJson(json);
}

/// PayTR Direct API init isteği
/// Frontend'den backend'e gönderilen sipariş bilgileri
@freezed
class PayTRInitRequest with _$PayTRInitRequest {
  const factory PayTRInitRequest({
    required String merchantOid, // Sipariş ID (alfanümerik, maks 64)
    required String email,
    required double paymentAmount, // TL cinsinden toplam tutar
    @Default(0) int installmentCount, // 0=peşin, 3=3 taksit (sadece bu değerler geçerli)
    required String userName,
    required String userAddress,
    required String userPhone,
    required List<BasketItem> basket,
    String? binNumber, // 3 taksit için zorunlu - kartın ilk 6-8 hanesi
  }) = _PayTRInitRequest;

  factory PayTRInitRequest.fromJson(Map<String, dynamic> json) =>
      _$PayTRInitRequestFromJson(json);
}

extension PayTRInitRequestJson on PayTRInitRequest {
  /// PayTR Direct API için JSON formatı
  /// 
  /// Dokümana göre zorunlu alanlar:
  /// - merchant_oid: Alfanümerik, benzersiz (^[A-Za-z0-9]+$)
  /// - payment_amount: TL cinsinden (backend basket'tan hesaplar, client tutarına güvenmez)
  /// - installment_count: Sadece 0 (peşin) veya 3 (3 taksit)
  /// - bin_number: 3 taksit için zorunlu
  Map<String, dynamic> toApiJson() {
    final json = <String, dynamic>{
      'merchant_oid': merchantOid,
      'email': email,
      'payment_amount': paymentAmount, // TL cinsinden (örn: 1499.90)
      'payment_type': 'card', // Kart ile ödeme
      'installment_count': installmentCount, // 0 veya 3
      'currency': 'TL',
      'non_3d': 0, // 3D Secure zorunlu
      'client_lang': 'tr',
      'user_name': userName,
      'user_address': userAddress,
      'user_phone': userPhone,
      'basket': basket
          .map((item) => {
                'name': item.name,
                'price': item.price,
                'quantity': item.quantity,
              })
          .toList(),
      'debug_on': 1, // Test modunda debug açık
    };
    // 3 taksit için bin_number zorunlu
    if (binNumber != null && binNumber!.isNotEmpty) {
      json['bin_number'] = binNumber;
    }
    return json;
  }
}

/// PayTR Direct API init yanıtı
/// Backend'den frontend'e dönen form bilgileri
@freezed
class PayTRInitResponse with _$PayTRInitResponse {
  const factory PayTRInitResponse({
    required String action, // https://www.paytr.com/odeme
    required Map<String, String> fields, // Form alanları (hidden inputlar)
  }) = _PayTRInitResponse;

  factory PayTRInitResponse.fromJson(Map<String, dynamic> json) {
    return PayTRInitResponse(
      action: json['action'] as String,
      fields: Map<String, String>.from(json['fields'] as Map),
    );
  }
}

// =====================================================
// BIN Detail & Installment Quote Models (NEW)
// =====================================================

/// BIN detail isteği - kart tipini öğrenmek için
@freezed
class BinDetailRequest with _$BinDetailRequest {
  const factory BinDetailRequest({
    required String binNumber, // Kartın ilk 6 veya 8 hanesi
    @Default(0) int debugOn,
  }) = _BinDetailRequest;

  factory BinDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$BinDetailRequestFromJson(json);
}

extension BinDetailRequestJson on BinDetailRequest {
  Map<String, dynamic> toApiJson() {
    return {
      'bin_number': binNumber,
      'debug_on': debugOn,
    };
  }
}

/// BIN detail yanıtı - kart tipi ve marka bilgisi
@freezed
class BinDetailResponse with _$BinDetailResponse {
  const factory BinDetailResponse({
    required String status, // "success" veya "failed"
    String? cardType, // "credit" veya "debit"
    String? brand, // "visa", "mastercard", "bonus", "world", vb.
    String? bankName,
    String? cardFamily,
    String? errMsg, // Hata durumunda
    Map<String, dynamic>? raw, // PayTR'den gelen ham veri
  }) = _BinDetailResponse;

  factory BinDetailResponse.fromJson(Map<String, dynamic> json) {
    return BinDetailResponse(
      status: json['status'] as String? ?? 'failed',
      cardType: json['cardType'] as String?,
      brand: json['brand'] as String?,
      bankName: json['bankName'] as String?,
      cardFamily: json['cardFamily'] as String?,
      errMsg: json['err_msg'] as String?,
      raw: json,
    );
  }
}

extension BinDetailResponseX on BinDetailResponse {
  bool get isSuccess => status == 'success';
  bool get isCreditCard => cardType?.toLowerCase() == 'credit';
  bool get isDebitCard => cardType?.toLowerCase() == 'debit';
  bool get canInstallment => isCreditCard && brand != null && brand!.toLowerCase() != 'none';
}

/// Taksit seçeneği - peşin veya 3 taksit
@freezed
class InstallmentOption with _$InstallmentOption {
  const factory InstallmentOption({
    required int installmentCount, // 0=peşin, 3=3 taksit
    required double ratePercent, // Vade farkı yüzdesi (0 veya 15)
    required String totalTl, // Toplam tutar (TL string)
    required String perInstallmentTl, // Taksit başına tutar (TL string)
  }) = _InstallmentOption;

  factory InstallmentOption.fromJson(Map<String, dynamic> json) {
    return InstallmentOption(
      installmentCount: json['installment_count'] as int? ?? 0,
      ratePercent: (json['rate_percent'] as num?)?.toDouble() ?? 0,
      totalTl: json['total_tl'] as String? ?? '0.00',
      perInstallmentTl: json['per_installment_tl'] as String? ?? '0.00',
    );
  }
}

extension InstallmentOptionX on InstallmentOption {
  bool get isPesin => installmentCount == 0;
  bool get is3Taksit => installmentCount == 3;
  double get totalAmount => double.tryParse(totalTl) ?? 0;
  double get perInstallmentAmount => double.tryParse(perInstallmentTl) ?? 0;
}

/// Taksit quote isteği - BIN ve tutar ile taksit seçeneklerini sorgula
@freezed
class InstallmentQuoteRequest with _$InstallmentQuoteRequest {
  const factory InstallmentQuoteRequest({
    required String binNumber, // Kartın ilk 6 veya 8 hanesi
    required double amountTl, // Peşin fiyat (TL)
  }) = _InstallmentQuoteRequest;

  factory InstallmentQuoteRequest.fromJson(Map<String, dynamic> json) =>
      _$InstallmentQuoteRequestFromJson(json);
}

extension InstallmentQuoteRequestJson on InstallmentQuoteRequest {
  Map<String, dynamic> toApiJson() {
    return {
      'bin_number': binNumber,
      'amount_tl': amountTl,
    };
  }
}

/// Taksit quote yanıtı - peşin ve 3 taksit seçenekleri
@freezed
class InstallmentQuoteResponse with _$InstallmentQuoteResponse {
  const factory InstallmentQuoteResponse({
    required String status, // "success" veya "failed"
    String? brand, // Kart markası (bonus, world, vb.)
    String? cardType, // "credit" veya "debit"
    required List<InstallmentOption> installments, // Taksit seçenekleri
    String? reason, // Başarısızlık nedeni
    Map<String, dynamic>? bin, // BIN detayları
  }) = _InstallmentQuoteResponse;

  factory InstallmentQuoteResponse.fromJson(Map<String, dynamic> json) {
    final installmentsList = (json['installments'] as List<dynamic>?)
            ?.map((e) => InstallmentOption.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    return InstallmentQuoteResponse(
      status: json['status'] as String? ?? 'failed',
      brand: json['brand'] as String?,
      cardType: json['cardType'] as String?,
      installments: installmentsList,
      reason: json['reason'] as String?,
      bin: json['bin'] as Map<String, dynamic>?,
    );
  }
}

extension InstallmentQuoteResponseX on InstallmentQuoteResponse {
  bool get isSuccess => status == 'success';
  bool get isCreditCard => cardType?.toLowerCase() == 'credit';
  bool get isDebitCard => cardType?.toLowerCase() == 'debit';
  
  /// Peşin seçeneği
  InstallmentOption? get pesinOption =>
      installments.where((o) => o.installmentCount == 0).firstOrNull;
  
  /// 3 taksit seçeneği (varsa)
  InstallmentOption? get taksit3Option =>
      installments.where((o) => o.installmentCount == 3).firstOrNull;
  
  /// 3 taksit mevcut mu?
  bool get has3Installment => taksit3Option != null;
}

// =====================================================
// Checkout State Models
// =====================================================

/// Checkout durumu - state machine için
/// Yeni akış: merchant_oid üret -> PayTR init -> WebView -> callback -> sipariş oluşur
enum CheckoutStatus {
  idle,
  initializingPayment, // PayTR init alınıyor
  awaitingPayment, // Kullanıcı ödeme yapıyor (WebView açık)
  verifyingPayment, // Callback sonrası sipariş durumu kontrol ediliyor
  completed, // Ödeme başarılı, sipariş oluştu
  failed, // Ödeme başarısız
}

/// Ödeme yöntemi
enum PaymentMethod {
  creditCard,
  bankTransfer,
}

/// Checkout state - tüm checkout akışını yönetir
/// NOT: Bu model JSON'a dönüştürülmez, sadece runtime state yönetimi için kullanılır
@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState({
    @Default(CheckoutStatus.idle) CheckoutStatus status,
    String? merchantOid, // Payment session ID (sipariş ID değil)
    String? orderId, // Sipariş ID (callback success sonrası oluşur)
    @JsonKey(includeFromJson: false, includeToJson: false)
    PayTRInitResponse? paytrResponse,
    String? errorMessage,
    // Ödeme yöntemi
    @Default(PaymentMethod.creditCard) PaymentMethod paymentMethod,
    // Taksit bilgileri
    @Default(0) int selectedInstallment, // 0=peşin, 3=3 taksit
    String? binNumber, // Kart BIN numarası
    InstallmentQuoteResponse? installmentQuote, // Taksit seçenekleri
  }) = _CheckoutState;
}

/// Refresh token isteği - taksit değişikliği için
@freezed
class RefreshTokenRequest with _$RefreshTokenRequest {
  const factory RefreshTokenRequest({
    required String merchantOid,
    @Default(0) int installmentCount, // 0 veya 3
    String? binNumber, // 3 taksit için zorunlu
  }) = _RefreshTokenRequest;

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);
}

extension RefreshTokenRequestJson on RefreshTokenRequest {
  Map<String, dynamic> toApiJson() {
    final json = <String, dynamic>{
      'merchant_oid': merchantOid,
      'installment_count': installmentCount,
    };
    if (binNumber != null && binNumber!.isNotEmpty) {
      json['bin_number'] = binNumber;
    }
    return json;
  }
}
