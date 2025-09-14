import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/models/appointment_model.dart';

class AppointmentsApiService {
  final ApiClient _apiClient = ApiClient.instance;

  /// Aylık müsaitlik bilgilerini getirir
  Future<MonthlyAvailability> getMonthlyAvailability({
    required String serviceId,
    required int year,
    required int month,
  }) async {
    final url = ApiEndpoints.monthlyAvailability(serviceId, year, month);
    final response = await _apiClient.get(url);
    return MonthlyAvailability.fromJson(response.data as Map<String, dynamic>);
  }

  /// Randevu talebi oluşturur
  Future<Appointment> bookAppointment({
    required AppointmentBookingRequest request,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.appointmentsBook,
      data: request.toJson(),
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

  /// Randevu durumunu günceller (admin)
  Future<void> updateAppointmentStatus({
    required String appointmentId,
    required String status,
  }) async {
    await _apiClient.put(
      ApiEndpoints.appointment(appointmentId),
      data: {'status': status},
    );
  }

  /// Randevuyu siler (admin)
  Future<void> deleteAppointment({
    required String appointmentId,
  }) async {
    await _apiClient.delete(ApiEndpoints.appointment(appointmentId));
  }

  /// Servis müsaitlik ayarlarını getirir (admin)
  Future<ServiceAvailability> getServiceAvailability({
    required String serviceId,
  }) async {
    final url = ApiEndpoints.serviceAvailability(serviceId);
    final response = await _apiClient.get(url);
    return ServiceAvailability.fromJson(response.data as Map<String, dynamic>);
  }

  /// Servis müsaitlik ayarlarını günceller (admin)
  Future<void> updateServiceAvailability({
    required String serviceId,
    required ServiceAvailability availability,
  }) async {
    final url = ApiEndpoints.serviceAvailability(serviceId);
    await _apiClient.put(url, data: availability.toJson());
  }
}
