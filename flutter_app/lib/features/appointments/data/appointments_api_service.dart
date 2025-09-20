import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/models/appointment_model.dart';

class AppointmentsApiService {
  final ApiClient _apiClient = ApiClient.instance;

  /// Dolu slotları getirir (takvim için)
  Future<List<BusySlot>> getBusySlots({
    String? serviceId,
    int days = 30,
  }) async {
    final queryParams = <String, dynamic>{
      'days': days,
    };
    if (serviceId != null) {
      queryParams['service_id'] = serviceId;
    }

    final response = await _apiClient.get(
      ApiEndpoints.appointmentsCalendar,
      queryParameters: queryParams,
    );

    final data = response.data as Map<String, dynamic>;
    final busyList = data['busy'] as List<dynamic>? ?? [];

    return busyList
        .map((item) => BusySlot.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Form-data ile randevu talebi oluşturur
  Future<Appointment> bookAppointmentForm({
    required String serviceId,
    required DateTime start,
  }) async {
    // Send the DateTime as-is, backend will handle timezone conversion
    final isoString = start.toIso8601String();

    final formData = FormData.fromMap({
      'service_id': serviceId,
      'start': isoString,
    });

    final response = await _apiClient.post(
      ApiEndpoints.appointments, // POST /appointments/
      data: formData,
    );
    return Appointment.fromJson(response.data as Map<String, dynamic>);
  }

  /// Kullanıcının randevularını getirir
  Future<List<AppointmentWithDetails>> getMyAppointments() async {
    final response = await _apiClient.get(ApiEndpoints.myAppointments);
    final jsonData = response.data as List<dynamic>;
    return jsonData
        .map((item) =>
            AppointmentWithDetails.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Randevu durumunu günceller (admin) - Form-data ile
  Future<void> updateAppointmentStatus({
    required String appointmentId,
    required String status,
  }) async {
    final formData = FormData.fromMap({
      'status': status,
    });

    await _apiClient.put(
      ApiEndpoints.adminAppointment(appointmentId),
      data: formData,
    );
  }

  /// Randevuyu siler (admin) - Form-data ile
  Future<void> deleteAppointment({
    required String appointmentId,
    required String status,
  }) async {
    final formData = FormData.fromMap({
      'status': status,
    });

    await _apiClient.delete(
      ApiEndpoints.adminAppointment(appointmentId),
      data: formData,
    );
  }

  /// Servis müsaitlik ayarlarını getirir (admin)
  Future<ServiceAvailability> getServiceAvailability({
    required String serviceId,
  }) async {
    final url = ApiEndpoints.adminServiceAvailability(serviceId);
    final response = await _apiClient.get(url);
    return ServiceAvailability.fromJson(response.data as Map<String, dynamic>);
  }

  /// Servis müsaitlik ayarlarını günceller (admin)
  Future<void> updateServiceAvailability({
    required String serviceId,
    required ServiceAvailability availability,
  }) async {
    final url = ApiEndpoints.adminServiceAvailability(serviceId);
    await _apiClient.put(url, data: availability.toJson());
  }

  /// Admin - Tüm randevuları listeler
  Future<List<AppointmentAdminOut>> getAllAppointments({
    String? status,
  }) async {
    final queryParams = <String, dynamic>{};
    if (status != null) {
      queryParams['status'] = status;
    }

    final response = await _apiClient.get(
      ApiEndpoints.adminAppointments, // GET /admin/appointments/
      queryParameters: queryParams,
    );
    final jsonData = response.data as List<dynamic>;
    return jsonData
        .map((item) =>
            AppointmentAdminOut.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Admin - Manuel randevu oluşturur
  Future<Appointment> createAppointmentAdmin({
    required String serviceId,
    String? userId,
    required DateTime start,
    DateTime? end,
  }) async {
    // Send the DateTime as-is, backend will handle timezone conversion
    final formData = FormData.fromMap({
      'service_id': serviceId,
      'start': start.toIso8601String(),
      if (userId != null) 'user_id': userId,
      if (end != null) 'end': end.toIso8601String(),
    });

    final response = await _apiClient.post(
      ApiEndpoints.adminAppointments, // POST /admin/appointments/
      data: formData,
    );
    return Appointment.fromJson(response.data as Map<String, dynamic>);
  }
}
