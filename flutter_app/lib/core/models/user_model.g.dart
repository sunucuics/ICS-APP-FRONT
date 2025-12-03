// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String? ?? 'customer',
      addresses: (json['addresses'] as List<dynamic>?)
              ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isGuest: json['isGuest'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'role': instance.role,
      'addresses': instance.addresses,
      'isGuest': instance.isGuest,
    };

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      id: json['id'] as String?,
      label: json['label'] as String?,
      name: json['name'] as String?,
      city: json['city'] as String,
      zipCode: json['zipCode'] as String,
      district: json['district'] as String,
      neighborhood: json['neighborhood'] as String?,
      street: json['street'] as String?,
      buildingNo: json['buildingNo'] as String?,
      floor: json['floor'] as String?,
      apartment: json['apartment'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'name': instance.name,
      'city': instance.city,
      'zipCode': instance.zipCode,
      'district': instance.district,
      'neighborhood': instance.neighborhood,
      'street': instance.street,
      'buildingNo': instance.buildingNo,
      'floor': instance.floor,
      'apartment': instance.apartment,
      'note': instance.note,
    };

_$AddressCreateImpl _$$AddressCreateImplFromJson(Map<String, dynamic> json) =>
    _$AddressCreateImpl(
      label: json['label'] as String?,
      name: json['name'] as String?,
      city: json['city'] as String,
      zipCode: json['zipCode'] as String,
      district: json['district'] as String,
      neighborhood: json['neighborhood'] as String?,
      street: json['street'] as String?,
      buildingNo: json['buildingNo'] as String?,
      floor: json['floor'] as String?,
      apartment: json['apartment'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$AddressCreateImplToJson(_$AddressCreateImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'name': instance.name,
      'city': instance.city,
      'zipCode': instance.zipCode,
      'district': instance.district,
      'neighborhood': instance.neighborhood,
      'street': instance.street,
      'buildingNo': instance.buildingNo,
      'floor': instance.floor,
      'apartment': instance.apartment,
      'note': instance.note,
    };

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterRequestImpl(
      name: json['name'] as String,
      phone: json['phone'] as String?,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$RegisterRequestImplToJson(
        _$RegisterRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
    };

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) =>
    _$AuthResponseImpl(
      userId: json['userId'] as String,
      user: UserProfile.fromJson(json['user'] as Map<String, dynamic>),
      idToken: json['idToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
    );

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'user': instance.user,
      'idToken': instance.idToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
    };
