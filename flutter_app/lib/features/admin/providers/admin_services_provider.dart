import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import '../providers/admin_dashboard_provider.dart';
import '../../../core/models/service_model.dart';

// Services Provider
final adminServicesProvider = FutureProvider<List<Service>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getServices();
});

// Services State Notifier for CRUD operations
final adminServicesNotifierProvider =
    StateNotifierProvider<AdminServicesNotifier, AsyncValue<List<Service>>>(
        (ref) {
  final repository = ref.watch(adminRepositoryProvider);
  return AdminServicesNotifier(repository);
});

class AdminServicesNotifier extends StateNotifier<AsyncValue<List<Service>>> {
  final AdminRepository _repository;

  AdminServicesNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadServices();
  }

  Future<void> loadServices() async {
    state = const AsyncValue.loading();
    try {
      final services = await _repository.getServices();
      state = AsyncValue.data(services);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> createService(Map<String, dynamic> serviceData) async {
    try {
      await _repository.createService(serviceData);
      await loadServices(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateService(
      String serviceId, Map<String, dynamic> serviceData) async {
    try {
      await _repository.updateService(serviceId, serviceData);
      await loadServices(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteService(String serviceId) async {
    try {
      await _repository.deleteService(serviceId);
      await loadServices(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadServices();
  }
}
