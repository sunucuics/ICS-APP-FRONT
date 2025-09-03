import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/service_model.dart';
import '../data/services_repository.dart';

// Services Repository Provider
final servicesRepositoryProvider = Provider<ServicesRepository>((ref) {
  return ServicesRepository();
});

// Services Provider - fetches all services
final servicesProvider = FutureProvider.autoDispose<List<Service>>((ref) async {
  final repository = ref.read(servicesRepositoryProvider);
  return repository.getServices();
});

// Single Service Provider
final serviceProvider =
    FutureProvider.autoDispose.family<Service, String>((ref, serviceId) async {
  final repository = ref.read(servicesRepositoryProvider);
  return repository.getService(serviceId);
});

// Featured Services Provider (first 3 services)
final featuredServicesProvider = Provider<List<Service>>((ref) {
  return ref.watch(servicesProvider).when(
        data: (services) => services.take(3).toList(),
        loading: () => <Service>[],
        error: (error, stack) => <Service>[],
      );
});

// Non-upcoming Services Provider (active services only)
final activeServicesProvider = Provider<List<Service>>((ref) {
  return ref.watch(servicesProvider).when(
        data: (services) => services
            .where((service) => !service.isUpcoming && !service.isDeleted)
            .toList(),
        loading: () => <Service>[],
        error: (error, stack) => <Service>[],
      );
});
