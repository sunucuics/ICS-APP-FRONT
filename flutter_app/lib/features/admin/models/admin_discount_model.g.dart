// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_discount_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminDiscountImpl _$$AdminDiscountImplFromJson(Map<String, dynamic> json) =>
    _$AdminDiscountImpl(
      id: json['id'] as String,
      targetType: json['target_type'] as String,
      targetId: json['target_id'] as String?,
      percentage: (json['percent'] as num).toDouble(),
      active: json['active'] as bool? ?? true,
      startAt: json['start_at'] == null
          ? null
          : DateTime.parse(json['start_at'] as String),
      endAt: json['end_at'] == null
          ? null
          : DateTime.parse(json['end_at'] as String),
      targetName: json['targetName'] as String?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$AdminDiscountImplToJson(_$AdminDiscountImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'target_type': instance.targetType,
      'target_id': instance.targetId,
      'percent': instance.percentage,
      'active': instance.active,
      'start_at': instance.startAt?.toIso8601String(),
      'end_at': instance.endAt?.toIso8601String(),
      'targetName': instance.targetName,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$DiscountCreateRequestImpl _$$DiscountCreateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$DiscountCreateRequestImpl(
      name: json['name'] as String,
      percentage: (json['percentage'] as num).toDouble(),
      targetType: json['targetType'] as String,
      targetId: json['targetId'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool? ?? true,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$DiscountCreateRequestImplToJson(
        _$DiscountCreateRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'percentage': instance.percentage,
      'targetType': instance.targetType,
      'targetId': instance.targetId,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'isActive': instance.isActive,
      'description': instance.description,
    };

_$DiscountUpdateRequestImpl _$$DiscountUpdateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$DiscountUpdateRequestImpl(
      name: json['name'] as String?,
      percentage: (json['percentage'] as num?)?.toDouble(),
      targetType: json['targetType'] as String?,
      targetId: json['targetId'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$DiscountUpdateRequestImplToJson(
        _$DiscountUpdateRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'percentage': instance.percentage,
      'targetType': instance.targetType,
      'targetId': instance.targetId,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isActive': instance.isActive,
      'description': instance.description,
    };
