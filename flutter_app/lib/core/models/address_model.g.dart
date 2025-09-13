// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      label: json['label'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      neighborhood: json['neighborhood'] as String?,
      street: json['street'] as String?,
      buildingNo: json['buildingNo'] as String?,
      apartment: json['apartment'] as String?,
      floor: json['floor'] as String?,
      zipCode: json['zipCode'] as String?,
      note: json['note'] as String?,
      isCurrent: json['is_current'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'label': instance.label,
      'city': instance.city,
      'district': instance.district,
      'neighborhood': instance.neighborhood,
      'street': instance.street,
      'buildingNo': instance.buildingNo,
      'apartment': instance.apartment,
      'floor': instance.floor,
      'zipCode': instance.zipCode,
      'note': instance.note,
      'is_current': instance.isCurrent,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$AddressCreateRequestImpl _$$AddressCreateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$AddressCreateRequestImpl(
      name: json['name'] as String,
      label: json['label'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
      neighborhood: json['neighborhood'] as String,
      street: json['street'] as String,
      buildingNo: json['buildingNo'] as String,
      apartment: json['apartment'] as String?,
      floor: json['floor'] as String?,
      zipCode: json['zipCode'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$AddressCreateRequestImplToJson(
        _$AddressCreateRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'city': instance.city,
      'district': instance.district,
      'neighborhood': instance.neighborhood,
      'street': instance.street,
      'buildingNo': instance.buildingNo,
      'apartment': instance.apartment,
      'floor': instance.floor,
      'zipCode': instance.zipCode,
      'note': instance.note,
    };

_$AddressUpdateRequestImpl _$$AddressUpdateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$AddressUpdateRequestImpl(
      name: json['name'] as String?,
      label: json['label'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      neighborhood: json['neighborhood'] as String?,
      street: json['street'] as String?,
      buildingNo: json['buildingNo'] as String?,
      apartment: json['apartment'] as String?,
      floor: json['floor'] as String?,
      zipCode: json['zipCode'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$AddressUpdateRequestImplToJson(
        _$AddressUpdateRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'city': instance.city,
      'district': instance.district,
      'neighborhood': instance.neighborhood,
      'street': instance.street,
      'buildingNo': instance.buildingNo,
      'apartment': instance.apartment,
      'floor': instance.floor,
      'zipCode': instance.zipCode,
      'note': instance.note,
    };

_$AddressListResponseImpl _$$AddressListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AddressListResponseImpl(
      addresses: (json['addresses'] as List<dynamic>)
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentAddress: json['current_address'] == null
          ? null
          : Address.fromJson(json['current_address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AddressListResponseImplToJson(
        _$AddressListResponseImpl instance) =>
    <String, dynamic>{
      'addresses': instance.addresses,
      'current_address': instance.currentAddress,
    };
