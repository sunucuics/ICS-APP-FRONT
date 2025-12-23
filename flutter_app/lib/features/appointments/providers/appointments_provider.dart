import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/appointment_model.dart';
import '../data/appointments_repository.dart';
import '../data/appointments_api_service.dart';

// API Service Provider
final appointmentsApiServiceProvider = Provider<AppointmentsApiService>((ref) {
  return AppointmentsApiService();
});

// Repository Provider
final appointmentsRepositoryProvider = Provider<AppointmentsRepository>((ref) {
  final apiService = ref.watch(appointmentsApiServiceProvider);
  return AppointmentsRepository(apiService: apiService);
});

// Busy Slots Provider (Takvim için)
final busySlotsProvider =
    FutureProvider.family<List<BusySlot>, BusySlotsParams>((ref, params) async {
  final repository = ref.watch(appointmentsRepositoryProvider);
  return await repository.getBusySlots(
    serviceId: params.serviceId,
    days: params.days,
  );
});

class BusySlotsParams {
  final String? serviceId;
  final int days;

  BusySlotsParams({
    this.serviceId,
    this.days = 30,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusySlotsParams &&
          runtimeType == other.runtimeType &&
          serviceId == other.serviceId &&
          days == other.days;

  @override
  int get hashCode => serviceId.hashCode ^ days.hashCode;
}

// My Appointments Provider
final myAppointmentsProvider =
    FutureProvider<List<AppointmentWithDetails>>((ref) async {
  final repository = ref.watch(appointmentsRepositoryProvider);
  return await repository.getMyAppointments();
});

// Appointment Booking Provider
final appointmentBookingProvider =
    StateNotifierProvider<AppointmentBookingNotifier, AsyncValue<Appointment?>>(
        (ref) {
  final repository = ref.watch(appointmentsRepositoryProvider);
  return AppointmentBookingNotifier(repository);
});

class AppointmentBookingNotifier
    extends StateNotifier<AsyncValue<Appointment?>> {
  final AppointmentsRepository _repository;

  AppointmentBookingNotifier(this._repository)
      : super(const AsyncValue.data(null));

  Future<void> bookAppointmentForm({
    required String serviceId,
    required DateTime start,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    try {
      final appointment = await _repository.bookAppointmentForm(
        serviceId: serviceId,
        start: start,
        notes: notes,
      );
      state = AsyncValue.data(appointment);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

// Service Availability Provider (Admin)
final serviceAvailabilityProvider =
    FutureProvider.family<ServiceAvailability, String>((ref, serviceId) async {
  final repository = ref.watch(appointmentsRepositoryProvider);
  return await repository.getServiceAvailability(serviceId: serviceId);
});

// Service Availability Update Provider (Admin)
final serviceAvailabilityUpdateProvider =
    StateNotifierProvider<ServiceAvailabilityUpdateNotifier, AsyncValue<void>>(
        (ref) {
  final repository = ref.watch(appointmentsRepositoryProvider);
  return ServiceAvailabilityUpdateNotifier(repository);
});

class ServiceAvailabilityUpdateNotifier
    extends StateNotifier<AsyncValue<void>> {
  final AppointmentsRepository _repository;

  ServiceAvailabilityUpdateNotifier(this._repository)
      : super(const AsyncValue.data(null));

  Future<void> updateServiceAvailability({
    required String serviceId,
    required ServiceAvailability availability,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _repository.updateServiceAvailability(
        serviceId: serviceId,
        availability: availability,
      );
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

// Appointment Status Update Provider (Admin)
final appointmentStatusUpdateProvider =
    StateNotifierProvider<AppointmentStatusUpdateNotifier, AsyncValue<void>>(
        (ref) {
  final repository = ref.watch(appointmentsRepositoryProvider);
  return AppointmentStatusUpdateNotifier(repository);
});

class AppointmentStatusUpdateNotifier extends StateNotifier<AsyncValue<void>> {
  final AppointmentsRepository _repository;

  AppointmentStatusUpdateNotifier(this._repository)
      : super(const AsyncValue.data(null));

  Future<void> updateAppointmentStatus({
    required String appointmentId,
    required String status,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _repository.updateAppointmentStatus(
        appointmentId: appointmentId,
        status: status,
      );
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteAppointment({
    required String appointmentId,
    required String status,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteAppointment(
        appointmentId: appointmentId,
        status: status,
      );
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

// Admin - Tüm Randevuları Listele Provider
final allAppointmentsProvider =
    FutureProvider.family<List<AppointmentAdminOut>, String?>(
        (ref, status) async {
  final repository = ref.watch(appointmentsRepositoryProvider);
  return await repository.getAllAppointments(status: status);
});

// Admin - Manuel Randevu Oluştur Provider
final createAppointmentAdminProvider = StateNotifierProvider<
    CreateAppointmentAdminNotifier, AsyncValue<Appointment?>>((ref) {
  final repository = ref.watch(appointmentsRepositoryProvider);
  return CreateAppointmentAdminNotifier(repository);
});

class CreateAppointmentAdminNotifier
    extends StateNotifier<AsyncValue<Appointment?>> {
  final AppointmentsRepository _repository;

  CreateAppointmentAdminNotifier(this._repository)
      : super(const AsyncValue.data(null));

  Future<void> createAppointment({
    required String serviceId,
    String? userId,
    required DateTime start,
    DateTime? end,
  }) async {
    state = const AsyncValue.loading();
    try {
      final appointment = await _repository.createAppointmentAdmin(
        serviceId: serviceId,
        userId: userId,
        start: start,
        end: end,
      );
      state = AsyncValue.data(appointment);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
