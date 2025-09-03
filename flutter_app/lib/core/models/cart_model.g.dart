// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddToCartRequestImpl _$$AddToCartRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$AddToCartRequestImpl(
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$AddToCartRequestImplToJson(
        _$AddToCartRequestImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
    };
