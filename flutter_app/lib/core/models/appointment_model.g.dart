// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceAvailabilityImpl _$$ServiceAvailabilityImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceAvailabilityImpl(
      serviceId: json['service_id'] as String,
      workingHours: (json['working_hours'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k, (e as List<dynamic>).map((e) => e as String).toList()),
          ) ??
          const {},
      breakTimes: (json['break_times'] as List<dynamic>?)
              ?.map((e) => Map<String, String>.from(e as Map))
              .toList() ??
          const [],
      isAvailable: json['is_available'] as bool? ?? true,
    );

Map<String, dynamic> _$$ServiceAvailabilityImplToJson(
        _$ServiceAvailabilityImpl instance) =>
    <String, dynamic>{
      'service_id': instance.serviceId,
      'working_hours': instance.workingHours,
      'break_times': instance.breakTimes,
      'is_available': instance.isAvailable,
    };
