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

_$PayTRDirectInitRequestImpl _$$PayTRDirectInitRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PayTRDirectInitRequestImpl(
      merchantOid: json['merchant_oid'] as String,
      email: json['email'] as String,
      paymentAmount: (json['payment_amount'] as num).toDouble(),
      paymentType: json['payment_type'] as String? ?? 'card',
      installmentCount: (json['installment_count'] as num?)?.toInt() ?? 0,
      currency: json['currency'] as String? ?? 'TL',
      non3d: (json['non_3d'] as num?)?.toInt() ?? 0,
      clientLang: json['client_lang'] as String? ?? 'tr',
      userName: json['user_name'] as String?,
      userAddress: json['user_address'] as String?,
      userPhone: json['user_phone'] as String?,
      basket: (json['basket'] as List<dynamic>)
          .map((e) => PayTRBasketItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      cardType: json['card_type'] as String?,
      userIp: json['user_ip'] as String?,
      debugOn: (json['debug_on'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$PayTRDirectInitRequestImplToJson(
        _$PayTRDirectInitRequestImpl instance) =>
    <String, dynamic>{
      'merchant_oid': instance.merchantOid,
      'email': instance.email,
      'payment_amount': instance.paymentAmount,
      'payment_type': instance.paymentType,
      'installment_count': instance.installmentCount,
      'currency': instance.currency,
      'non_3d': instance.non3d,
      'client_lang': instance.clientLang,
      'user_name': instance.userName,
      'user_address': instance.userAddress,
      'user_phone': instance.userPhone,
      'basket': instance.basket,
      'card_type': instance.cardType,
      'user_ip': instance.userIp,
      'debug_on': instance.debugOn,
    };

_$PayTRDirectInitResponseImpl _$$PayTRDirectInitResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PayTRDirectInitResponseImpl(
      action: json['action'] as String,
      fields: PayTRDirectInitFields.fromJson(
          json['fields'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PayTRDirectInitResponseImplToJson(
        _$PayTRDirectInitResponseImpl instance) =>
    <String, dynamic>{
      'action': instance.action,
      'fields': instance.fields,
    };

_$PayTRDirectInitFieldsImpl _$$PayTRDirectInitFieldsImplFromJson(
        Map<String, dynamic> json) =>
    _$PayTRDirectInitFieldsImpl(
      merchantId: json['merchant_id'] as String,
      userIp: json['user_ip'] as String,
      merchantOid: json['merchant_oid'] as String,
      email: json['email'] as String,
      paymentType: json['payment_type'] as String,
      paymentAmount: json['payment_amount'] as String,
      currency: json['currency'] as String,
      testMode: json['test_mode'] as String,
      non3d: json['non_3d'] as String,
      clientLang: json['client_lang'] as String,
      merchantOkUrl: json['merchant_ok_url'] as String,
      merchantFailUrl: json['merchant_fail_url'] as String,
      userName: json['user_name'] as String,
      userAddress: json['user_address'] as String,
      userPhone: json['user_phone'] as String,
      userBasket: json['user_basket'] as String,
      installmentCount: json['installment_count'] as String,
      debugOn: json['debug_on'] as String,
      paytrToken: json['paytr_token'] as String,
      cardType: json['card_type'] as String?,
    );

Map<String, dynamic> _$$PayTRDirectInitFieldsImplToJson(
        _$PayTRDirectInitFieldsImpl instance) =>
    <String, dynamic>{
      'merchant_id': instance.merchantId,
      'user_ip': instance.userIp,
      'merchant_oid': instance.merchantOid,
      'email': instance.email,
      'payment_type': instance.paymentType,
      'payment_amount': instance.paymentAmount,
      'currency': instance.currency,
      'test_mode': instance.testMode,
      'non_3d': instance.non3d,
      'client_lang': instance.clientLang,
      'merchant_ok_url': instance.merchantOkUrl,
      'merchant_fail_url': instance.merchantFailUrl,
      'user_name': instance.userName,
      'user_address': instance.userAddress,
      'user_phone': instance.userPhone,
      'user_basket': instance.userBasket,
      'installment_count': instance.installmentCount,
      'debug_on': instance.debugOn,
      'paytr_token': instance.paytrToken,
      'card_type': instance.cardType,
    };

_$PayTRIframeInitRequestImpl _$$PayTRIframeInitRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PayTRIframeInitRequestImpl(
      merchantOid: json['merchant_oid'] as String,
      email: json['email'] as String,
      paymentAmount: (json['payment_amount'] as num).toDouble(),
      userName: json['user_name'] as String?,
      userAddress: json['user_address'] as String?,
      userPhone: json['user_phone'] as String?,
      basket: (json['basket'] as List<dynamic>)
          .map((e) => PayTRBasketItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      userIp: json['user_ip'] as String?,
      debugOn: (json['debug_on'] as num?)?.toInt() ?? 1,
      noInstallment: (json['no_installment'] as num?)?.toInt() ?? 0,
      maxInstallment: (json['max_installment'] as num?)?.toInt() ?? 0,
      currency: json['currency'] as String? ?? 'TL',
    );

Map<String, dynamic> _$$PayTRIframeInitRequestImplToJson(
        _$PayTRIframeInitRequestImpl instance) =>
    <String, dynamic>{
      'merchant_oid': instance.merchantOid,
      'email': instance.email,
      'payment_amount': instance.paymentAmount,
      'user_name': instance.userName,
      'user_address': instance.userAddress,
      'user_phone': instance.userPhone,
      'basket': instance.basket,
      'user_ip': instance.userIp,
      'debug_on': instance.debugOn,
      'no_installment': instance.noInstallment,
      'max_installment': instance.maxInstallment,
      'currency': instance.currency,
    };

_$PayTRIframeInitResponseImpl _$$PayTRIframeInitResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PayTRIframeInitResponseImpl(
      token: json['token'] as String,
    );

Map<String, dynamic> _$$PayTRIframeInitResponseImplToJson(
        _$PayTRIframeInitResponseImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
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
