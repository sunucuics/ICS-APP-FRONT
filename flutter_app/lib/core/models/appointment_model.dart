import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment_model.freezed.dart';

@freezed
class Appointment with _$Appointment {
  const factory Appointment({
    required String id,
    required String serviceId,
    String? userId,
    required DateTime start,
    required DateTime end,
    required String status,
    String? notes,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as String? ?? '',
      serviceId: json['service_id'] as String? ?? '',
      userId: json['user_id'] as String?,
      start: DateTime.tryParse(json['start'].toString()) ?? DateTime.now(),
      end: DateTime.tryParse(json['end'].toString()) ?? DateTime.now(),
      status: json['status'] as String? ?? 'pending',
      notes: json['notes'] as String?,
    );
  }
}

@freezed
class AppointmentWithDetails with _$AppointmentWithDetails {
  const factory AppointmentWithDetails({
    required String id,
    required String serviceId,
    String? userId,
    required DateTime start,
    required DateTime end,
    required String status,
    String? notes,
    ServiceBrief? service,
    UserBrief? user,
  }) = _AppointmentWithDetails;

  factory AppointmentWithDetails.fromJson(Map<String, dynamic> json) {
    return AppointmentWithDetails(
      id: json['id'] as String? ?? '',
      serviceId: json['service_id'] as String? ?? '',
      userId: json['user_id'] as String?,
      start: DateTime.tryParse(json['start'].toString()) ?? DateTime.now(),
      end: DateTime.tryParse(json['end'].toString()) ?? DateTime.now(),
      status: json['status'] as String? ?? 'pending',
      notes: json['notes'] as String?,
      service: json['service'] != null
          ? ServiceBrief.fromJson(json['service'] as Map<String, dynamic>)
          : null,
      user: json['user'] != null
          ? UserBrief.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}

@freezed
class ServiceBrief with _$ServiceBrief {
  const factory ServiceBrief({
    required String id,
    String? title,
    double? price,
  }) = _ServiceBrief;

  factory ServiceBrief.fromJson(Map<String, dynamic> json) {
    return ServiceBrief(
      id: json['id'] as String? ?? '',
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
    );
  }
}

@freezed
class UserBrief with _$UserBrief {
  const factory UserBrief({
    required String id,
    String? name,
    String? phone,
    String? email,
    List<Map<String, dynamic>>? addresses,
  }) = _UserBrief;

  factory UserBrief.fromJson(Map<String, dynamic> json) {
    return UserBrief(
      id: json['id'] as String? ?? '',
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }
}

@freezed
class TimeSlot with _$TimeSlot {
  const factory TimeSlot({
    required String startTime,
    required String endTime,
    required bool isAvailable,
    String? appointmentId,
  }) = _TimeSlot;

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      startTime: json['start_time'] as String? ?? '',
      endTime: json['end_time'] as String? ?? '',
      isAvailable: json['is_available'] as bool? ?? false,
      appointmentId: json['appointment_id'] as String?,
    );
  }
}

@freezed
class DayAvailability with _$DayAvailability {
  const factory DayAvailability({
    required DateTime date,
    required bool isWorkingDay,
    @Default([]) List<TimeSlot> timeSlots,
  }) = _DayAvailability;

  factory DayAvailability.fromJson(Map<String, dynamic> json) {
    return DayAvailability(
      date: DateTime.tryParse(json['date'].toString()) ?? DateTime.now(),
      isWorkingDay: json['is_working_day'] as bool? ?? false,
      timeSlots: (json['time_slots'] as List<dynamic>?)
              ?.map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

@freezed
class MonthlyAvailability with _$MonthlyAvailability {
  const factory MonthlyAvailability({
    required String serviceId,
    required int year,
    required int month,
    @Default([]) List<DayAvailability> days,
  }) = _MonthlyAvailability;

  factory MonthlyAvailability.fromJson(Map<String, dynamic> json) {
    return MonthlyAvailability(
      serviceId: json['service_id'] as String? ?? '',
      year: json['year'] as int? ?? DateTime.now().year,
      month: json['month'] as int? ?? DateTime.now().month,
      days: (json['days'] as List<dynamic>?)
              ?.map((e) => DayAvailability.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

@freezed
class AppointmentBookingRequest with _$AppointmentBookingRequest {
  const factory AppointmentBookingRequest({
    required String serviceId,
    required DateTime date,
    required String startTime,
    String? notes,
  }) = _AppointmentBookingRequest;

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'date': date.toIso8601String().split('T')[0], // YYYY-MM-DD format
      'start_time': startTime,
      if (notes != null) 'notes': notes,
    };
  }
}

@freezed
class ServiceAvailability with _$ServiceAvailability {
  const factory ServiceAvailability({
    required String serviceId,
    @Default({}) Map<String, List<String>> workingHours,
    @Default([]) List<Map<String, String>> breakTimes,
    @Default(true) bool isAvailable,
  }) = _ServiceAvailability;

  factory ServiceAvailability.fromJson(Map<String, dynamic> json) {
    return ServiceAvailability(
      serviceId: json['service_id'] as String? ?? '',
      workingHours: Map<String, List<String>>.from(
        json['working_hours'] as Map<String, dynamic>? ?? {},
      ),
      breakTimes: (json['break_times'] as List<dynamic>?)
              ?.map((e) => Map<String, String>.from(e as Map<String, dynamic>))
              .toList() ??
          [],
      isAvailable: json['is_available'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'working_hours': workingHours,
      'break_times': breakTimes,
      'is_available': isAvailable,
    };
  }
}
