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
    @Default(0) int installmentCount, // 0=tek çekim, 2-12=taksit
    required String userName,
    required String userAddress,
    required String userPhone,
    required List<BasketItem> basket,
  }) = _PayTRInitRequest;

  factory PayTRInitRequest.fromJson(Map<String, dynamic> json) =>
      _$PayTRInitRequestFromJson(json);
}

extension PayTRInitRequestJson on PayTRInitRequest {
  Map<String, dynamic> toApiJson() {
    return {
      'merchant_oid': merchantOid,
      'email': email,
      'payment_amount': paymentAmount,
      'installment_count': installmentCount,
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
    };
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

/// Checkout durumu - state machine için
enum CheckoutStatus {
  idle,
  creatingOrder,
  initializingPayment,
  awaitingPayment,
  verifyingPayment,
  completed,
  failed,
}

/// Checkout state - tüm checkout akışını yönetir
/// NOT: Bu model JSON'a dönüştürülmez, sadece runtime state yönetimi için kullanılır
@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState({
    @Default(CheckoutStatus.idle) CheckoutStatus status,
    String? orderId,
    @JsonKey(includeFromJson: false, includeToJson: false)
    PayTRInitResponse? paytrResponse,
    String? errorMessage,
  }) = _CheckoutState;
}

