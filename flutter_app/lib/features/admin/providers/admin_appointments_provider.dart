import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import '../providers/admin_dashboard_provider.dart';
import '../../../core/models/appointment_model.dart';

// Appointments Provider
final adminAppointmentsProvider =
    FutureProvider<List<AppointmentWithDetails>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getAppointments();
});

// Appointments State Notifier for CRUD operations
final adminAppointmentsNotifierProvider = StateNotifierProvider<
    AdminAppointmentsNotifier, AsyncValue<List<AppointmentWithDetails>>>((ref) {
  final repository = ref.watch(adminRepositoryProvider);
  return AdminAppointmentsNotifier(repository);
});

class AdminAppointmentsNotifier
    extends StateNotifier<AsyncValue<List<AppointmentWithDetails>>> {
  final AdminRepository _repository;

  AdminAppointmentsNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    loadAppointments();
  }

  Future<void> loadAppointments() async {
    state = const AsyncValue.loading();
    try {
      final appointments = await _repository.getAppointments();
      state = AsyncValue.data(appointments);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateAppointmentStatus(
      String appointmentId, String status) async {
    try {
      await _repository.updateAppointmentStatus(appointmentId, status);
      await loadAppointments(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadAppointments();
  }
}
