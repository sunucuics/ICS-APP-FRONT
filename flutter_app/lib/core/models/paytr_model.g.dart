// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paytr_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PayTRBasketItemImpl _$$PayTRBasketItemImplFromJson(
        Map<String, dynamic> json) =>
    _$PayTRBasketItemImpl(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$$PayTRBasketItemImplToJson(
        _$PayTRBasketItemImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
    };

_$PayTRTokenRequestImpl _$$PayTRTokenRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PayTRTokenRequestImpl(
      merchantOid: json['merchant_oid'] as String,
      email: json['email'] as String,
      userName: json['user_name'] as String,
      userAddress: json['user_address'] as String,
      userPhone: json['user_phone'] as String,
      paymentAmount: (json['payment_amount'] as num).toDouble(),
      currency: json['currency'] as String,
      basket: (json['basket'] as List<dynamic>)
          .map((e) => PayTRBasketItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      userIp: json['user_ip'] as String?,
      noInstallment: (json['no_installment'] as num?)?.toInt() ?? 0,
      maxInstallment: (json['max_installment'] as num?)?.toInt() ?? 0,
      timeoutLimit: (json['timeout_limit'] as num?)?.toInt() ?? 30,
      lang: json['lang'] as String? ?? 'tr',
      debugOn: (json['debug_on'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$PayTRTokenRequestImplToJson(
        _$PayTRTokenRequestImpl instance) =>
    <String, dynamic>{
      'merchant_oid': instance.merchantOid,
      'email': instance.email,
      'user_name': instance.userName,
      'user_address': instance.userAddress,
      'user_phone': instance.userPhone,
      'payment_amount': instance.paymentAmount,
      'currency': instance.currency,
      'basket': instance.basket,
      'user_ip': instance.userIp,
      'no_installment': instance.noInstallment,
      'max_installment': instance.maxInstallment,
      'timeout_limit': instance.timeoutLimit,
      'lang': instance.lang,
      'debug_on': instance.debugOn,
    };

_$PayTRTokenResponseImpl _$$PayTRTokenResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PayTRTokenResponseImpl(
      token: json['token'] as String,
      iframeUrl: json['iframe_url'] as String,
    );

Map<String, dynamic> _$$PayTRTokenResponseImplToJson(
        _$PayTRTokenResponseImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'iframe_url': instance.iframeUrl,
    };

_$PayTRPaymentInfoImpl _$$PayTRPaymentInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$PayTRPaymentInfoImpl(
      provider: json['provider'] as String,
      status: json['status'] as String,
      receivedTotal: (json['received_total'] as num).toDouble(),
      currency: json['currency'] as String,
      paymentType: json['payment_type'] as String,
      reportedAt: DateTime.parse(json['reported_at'] as String),
      paytr: json['paytr'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$PayTRPaymentInfoImplToJson(
        _$PayTRPaymentInfoImpl instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'status': instance.status,
      'received_total': instance.receivedTotal,
      'currency': instance.currency,
      'payment_type': instance.paymentType,
      'reported_at': instance.reportedAt.toIso8601String(),
      'paytr': instance.paytr,
    };
