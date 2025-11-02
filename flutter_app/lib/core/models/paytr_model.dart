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

// PayTR Direct API Init Request Model
@freezed
class PayTRDirectInitRequest with _$PayTRDirectInitRequest {
  const factory PayTRDirectInitRequest({
    @JsonKey(name: 'merchant_oid') required String merchantOid,
    required String email,
    @JsonKey(name: 'payment_amount') required double paymentAmount,
    @Default('card') @JsonKey(name: 'payment_type') String paymentType,
    @Default(0) @JsonKey(name: 'installment_count') int installmentCount,
    @Default('TL') String currency,
    @Default(0) @JsonKey(name: 'non_3d') int non3d,
    @Default('tr') @JsonKey(name: 'client_lang') String clientLang,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'user_address') String? userAddress,
    @JsonKey(name: 'user_phone') String? userPhone,
    required List<PayTRBasketItem> basket,
    @JsonKey(name: 'card_type') String? cardType,
    @JsonKey(name: 'user_ip') String? userIp,
    @Default(1) @JsonKey(name: 'debug_on') int debugOn,
  }) = _PayTRDirectInitRequest;

  factory PayTRDirectInitRequest.fromJson(Map<String, dynamic> json) =>
      _$PayTRDirectInitRequestFromJson(json);
}

// PayTR Direct API Init Response Model
@freezed
class PayTRDirectInitResponse with _$PayTRDirectInitResponse {
  const factory PayTRDirectInitResponse({
    required String action,
    required PayTRDirectInitFields fields,
  }) = _PayTRDirectInitResponse;

  factory PayTRDirectInitResponse.fromJson(Map<String, dynamic> json) =>
      _$PayTRDirectInitResponseFromJson(json);
}

// PayTR Direct API Init Fields Model (form fields for POST to PayTR)
@freezed
class PayTRDirectInitFields with _$PayTRDirectInitFields {
  const factory PayTRDirectInitFields({
    @JsonKey(name: 'merchant_id') required String merchantId,
    @JsonKey(name: 'user_ip') required String userIp,
    @JsonKey(name: 'merchant_oid') required String merchantOid,
    required String email,
    @JsonKey(name: 'payment_type') required String paymentType,
    @JsonKey(name: 'payment_amount') required String paymentAmount, // Kuruş string
    required String currency,
    @JsonKey(name: 'test_mode') required String testMode,
    @JsonKey(name: 'non_3d') required String non3d,
    @JsonKey(name: 'client_lang') required String clientLang,
    @JsonKey(name: 'merchant_ok_url') required String merchantOkUrl,
    @JsonKey(name: 'merchant_fail_url') required String merchantFailUrl,
    @JsonKey(name: 'user_name') required String userName,
    @JsonKey(name: 'user_address') required String userAddress,
    @JsonKey(name: 'user_phone') required String userPhone,
    @JsonKey(name: 'user_basket') required String userBasket, // Base64 JSON
    @JsonKey(name: 'installment_count') required String installmentCount,
    @JsonKey(name: 'debug_on') required String debugOn,
    @JsonKey(name: 'paytr_token') required String paytrToken,
    @JsonKey(name: 'card_type') String? cardType,
  }) = _PayTRDirectInitFields;

  factory PayTRDirectInitFields.fromJson(Map<String, dynamic> json) =>
      _$PayTRDirectInitFieldsFromJson(json);
}

// PayTR iFrame Init Request Model (optional)
@freezed
class PayTRIframeInitRequest with _$PayTRIframeInitRequest {
  const factory PayTRIframeInitRequest({
    @JsonKey(name: 'merchant_oid') required String merchantOid,
    required String email,
    @JsonKey(name: 'payment_amount') required double paymentAmount,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'user_address') String? userAddress,
    @JsonKey(name: 'user_phone') String? userPhone,
    required List<PayTRBasketItem> basket,
    @JsonKey(name: 'user_ip') String? userIp,
    @Default(1) @JsonKey(name: 'debug_on') int debugOn,
    @Default(0) @JsonKey(name: 'no_installment') int noInstallment,
    @Default(0) @JsonKey(name: 'max_installment') int maxInstallment,
    @Default('TL') String currency,
  }) = _PayTRIframeInitRequest;

  factory PayTRIframeInitRequest.fromJson(Map<String, dynamic> json) =>
      _$PayTRIframeInitRequestFromJson(json);
}

// PayTR iFrame Init Response Model
@freezed
class PayTRIframeInitResponse with _$PayTRIframeInitResponse {
  const factory PayTRIframeInitResponse({
    required String token,
  }) = _PayTRIframeInitResponse;

  factory PayTRIframeInitResponse.fromJson(Map<String, dynamic> json) =>
      _$PayTRIframeInitResponseFromJson(json);
}

// Legacy PayTR Token Request/Response (deprecated)
@Deprecated('Use PayTRDirectInitRequest instead')
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
    @Default(0) @JsonKey(name: 'no_installment') int noInstallment,
    @Default(0) @JsonKey(name: 'max_installment') int maxInstallment,
    @Default(30) @JsonKey(name: 'timeout_limit') int timeoutLimit,
    @Default('tr') String lang,
    @Default(1) @JsonKey(name: 'debug_on') int debugOn,
  }) = _PayTRTokenRequest;

  factory PayTRTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$PayTRTokenRequestFromJson(json);
}

@Deprecated('Use PayTRIframeInitResponse instead')
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
