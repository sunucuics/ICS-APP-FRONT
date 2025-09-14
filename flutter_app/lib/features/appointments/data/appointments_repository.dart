import '../../../../core/models/appointment_model.dart';
import 'appointments_api_service.dart';

class AppointmentsRepository {
  final AppointmentsApiService _apiService;

  AppointmentsRepository({
    required AppointmentsApiService apiService,
  }) : _apiService = apiService;

  /// Aylık müsaitlik bilgilerini getirir
  Future<MonthlyAvailability> getMonthlyAvailability({
    required String serviceId,
    required int year,
    required int month,
  }) async {
    return await _apiService.getMonthlyAvailability(
      serviceId: serviceId,
      year: year,
      month: month,
    );
  }

  /// Randevu talebi oluşturur
  Future<Appointment> bookAppointment({
    required AppointmentBookingRequest request,
  }) async {
    return await _apiService.bookAppointment(request: request);
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
  }) async {
    return await _apiService.deleteAppointment(appointmentId: appointmentId);
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
}
