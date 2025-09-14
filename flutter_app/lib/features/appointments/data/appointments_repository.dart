import '../../../../core/models/appointment_model.dart';
import 'appointments_api_service.dart';

class AppointmentsRepository {
  final AppointmentsApiService _apiService;

  AppointmentsRepository({
    required AppointmentsApiService apiService,
  }) : _apiService = apiService;

  /// Dolu slotları getirir (takvim için)
  Future<Map<String, dynamic>> getBusySlots({
    String? serviceId,
    int days = 30,
  }) async {
    return await _apiService.getBusySlots(
      serviceId: serviceId,
      days: days,
    );
  }

  /// Form-data ile randevu talebi oluşturur
  Future<Appointment> bookAppointmentForm({
    required String serviceId,
    required DateTime start,
  }) async {
    return await _apiService.bookAppointmentForm(
      serviceId: serviceId,
      start: start,
    );
  }

  /// Kullanıcının randevularını getirir
  Future<List<AppointmentWithDetails>> getMyAppointments() async {
    return await _apiService.getMyAppointments();
  }

  /// Randevu durumunu günceller (admin)
  Future<void> updateAppointmentStatus({
    required String appointmentId,
    required String status,
  }) async {
    return await _apiService.updateAppointmentStatus(
      appointmentId: appointmentId,
      status: status,
    );
  }

  /// Randevuyu siler (admin)
  Future<void> deleteAppointment({
    required String appointmentId,
    required String status,
  }) async {
    return await _apiService.deleteAppointment(
      appointmentId: appointmentId,
      status: status,
    );
  }

  /// Servis müsaitlik ayarlarını getirir (admin)
  Future<ServiceAvailability> getServiceAvailability({
    required String serviceId,
  }) async {
    return await _apiService.getServiceAvailability(serviceId: serviceId);
  }

  /// Servis müsaitlik ayarlarını günceller (admin)
  Future<void> updateServiceAvailability({
    required String serviceId,
    required ServiceAvailability availability,
  }) async {
    return await _apiService.updateServiceAvailability(
      serviceId: serviceId,
      availability: availability,
    );
  }

  /// Admin - Tüm randevuları listeler
  Future<List<AppointmentAdminOut>> getAllAppointments({
    String? status,
  }) async {
    return await _apiService.getAllAppointments(status: status);
  }

  /// Admin - Manuel randevu oluşturur
  Future<Appointment> createAppointmentAdmin({
    required String serviceId,
    String? userId,
    required DateTime start,
    DateTime? end,
  }) async {
    return await _apiService.createAppointmentAdmin(
      serviceId: serviceId,
      userId: userId,
      start: start,
      end: end,
    );
  }
}
