import 'package:freezed_annotation/freezed_annotation.dart';

part 'paytr_model.freezed.dart';
part 'paytr_model.g.dart';

// PayTR Basket Item Model
@freezed
class PayTRBasketItem with _$PayTRBasketItem {
  const factory PayTRBasketItem({
    required String name,
    required double price,
    required int quantity,
  }) = _PayTRBasketItem;

  factory PayTRBasketItem.fromJson(Map<String, dynamic> json) =>
      _$PayTRBasketItemFromJson(json);
}

// PayTR Token Request Model
@freezed
class PayTRTokenRequest with _$PayTRTokenRequest {
  const factory PayTRTokenRequest({
    @JsonKey(name: 'merchant_oid') required String merchantOid,
    required String email,
    @JsonKey(name: 'user_name') required String userName,
    @JsonKey(name: 'user_address') required String userAddress,
    @JsonKey(name: 'user_phone') required String userPhone,
    @JsonKey(name: 'payment_amount') required double paymentAmount,
    required String currency,
    required List<PayTRBasketItem> basket,
    @JsonKey(name: 'user_ip') String? userIp,
    @JsonKey(name: 'no_installment') @Default(0) int noInstallment,
    @JsonKey(name: 'max_installment') @Default(0) int maxInstallment,
    @JsonKey(name: 'timeout_limit') @Default(30) int timeoutLimit,
    @Default('tr') String lang,
    @JsonKey(name: 'debug_on') @Default(1) int debugOn,
  }) = _PayTRTokenRequest;

  factory PayTRTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$PayTRTokenRequestFromJson(json);
}

// PayTR Token Response Model
@freezed
class PayTRTokenResponse with _$PayTRTokenResponse {
  const factory PayTRTokenResponse({
    required String token,
    @JsonKey(name: 'iframe_url') required String iframeUrl,
  }) = _PayTRTokenResponse;

  factory PayTRTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$PayTRTokenResponseFromJson(json);
}

// PayTR Payment Status (for order model integration)
@freezed
class PayTRPaymentInfo with _$PayTRPaymentInfo {
  const factory PayTRPaymentInfo({
    required String provider,
    required String status,
    @JsonKey(name: 'received_total') required double receivedTotal,
    required String currency,
    @JsonKey(name: 'payment_type') required String paymentType,
    @JsonKey(name: 'reported_at') required DateTime reportedAt,
    Map<String, dynamic>? paytr,
  }) = _PayTRPaymentInfo;

  factory PayTRPaymentInfo.fromJson(Map<String, dynamic> json) =>
      _$PayTRPaymentInfoFromJson(json);
}
