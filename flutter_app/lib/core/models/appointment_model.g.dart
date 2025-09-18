// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusySlotImpl _$$BusySlotImplFromJson(Map<String, dynamic> json) =>
    _$BusySlotImpl(
      serviceId: json['service_id'] as String?,
      date: json['date'] as String,
      start: json['start'] as String,
      end: json['end'] as String,
      status: json['status'] as String,
      appointmentId: json['appointment_id'] as String,
    );

Map<String, dynamic> _$$BusySlotImplToJson(_$BusySlotImpl instance) =>
    <String, dynamic>{
      'service_id': instance.serviceId,
      'date': instance.date,
      'start': instance.start,
      'end': instance.end,
      'status': instance.status,
      'appointment_id': instance.appointmentId,
    };

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
