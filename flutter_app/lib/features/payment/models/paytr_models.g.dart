// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paytr_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BasketItemImpl _$$BasketItemImplFromJson(Map<String, dynamic> json) =>
    _$BasketItemImpl(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$$BasketItemImplToJson(_$BasketItemImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
    };

_$PayTRInitRequestImpl _$$PayTRInitRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PayTRInitRequestImpl(
      merchantOid: json['merchantOid'] as String,
      email: json['email'] as String,
      paymentAmount: (json['paymentAmount'] as num).toDouble(),
      installmentCount: (json['installmentCount'] as num?)?.toInt() ?? 0,
      userName: json['userName'] as String,
      userAddress: json['userAddress'] as String,
      userPhone: json['userPhone'] as String,
      basket: (json['basket'] as List<dynamic>)
          .map((e) => BasketItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      binNumber: json['binNumber'] as String?,
    );

Map<String, dynamic> _$$PayTRInitRequestImplToJson(
        _$PayTRInitRequestImpl instance) =>
    <String, dynamic>{
      'merchantOid': instance.merchantOid,
      'email': instance.email,
      'paymentAmount': instance.paymentAmount,
      'installmentCount': instance.installmentCount,
      'userName': instance.userName,
      'userAddress': instance.userAddress,
      'userPhone': instance.userPhone,
      'basket': instance.basket,
      'binNumber': instance.binNumber,
    };

_$BinDetailRequestImpl _$$BinDetailRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$BinDetailRequestImpl(
      binNumber: json['binNumber'] as String,
      debugOn: (json['debugOn'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$BinDetailRequestImplToJson(
        _$BinDetailRequestImpl instance) =>
    <String, dynamic>{
      'binNumber': instance.binNumber,
      'debugOn': instance.debugOn,
    };

_$InstallmentQuoteRequestImpl _$$InstallmentQuoteRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$InstallmentQuoteRequestImpl(
      binNumber: json['binNumber'] as String,
      amountTl: (json['amountTl'] as num).toDouble(),
    );

Map<String, dynamic> _$$InstallmentQuoteRequestImplToJson(
        _$InstallmentQuoteRequestImpl instance) =>
    <String, dynamic>{
      'binNumber': instance.binNumber,
      'amountTl': instance.amountTl,
    };

_$RefreshTokenRequestImpl _$$RefreshTokenRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$RefreshTokenRequestImpl(
      merchantOid: json['merchantOid'] as String,
      installmentCount: (json['installmentCount'] as num?)?.toInt() ?? 0,
      binNumber: json['binNumber'] as String?,
    );

Map<String, dynamic> _$$RefreshTokenRequestImplToJson(
        _$RefreshTokenRequestImpl instance) =>
    <String, dynamic>{
      'merchantOid': instance.merchantOid,
      'installmentCount': instance.installmentCount,
      'binNumber': instance.binNumber,
    };
