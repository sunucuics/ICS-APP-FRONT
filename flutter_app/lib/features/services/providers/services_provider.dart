import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/service_model.dart';
import '../../../core/models/paginated_list_state.dart';
import '../data/services_repository.dart';

// Services Repository Provider
final servicesRepositoryProvider = Provider<ServicesRepository>((ref) {
  return ServicesRepository();
});

// ============================================================================
// NEW: Cursor-based paginated services notifier (infinite scroll)
// ============================================================================

class ServicesNotifier extends StateNotifier<PaginatedListState<Service>> {
  final ServicesRepository _repository;
  static const int _pageSize = 20;

  ServicesNotifier(this._repository) : super(const PaginatedListState());

  /// İlk sayfa yükle.
  Future<void> loadInitial() async {
    state = PaginatedListState.loading();

    try {
      final response = await _repository.getServices(
        limit: _pageSize,
      );

      state = PaginatedListState(
        items: response.items,
        hasMore: response.hasMore,
        nextCursor: response.nextCursor,
        isLoading: false,
      );
    } catch (e) {
      state = PaginatedListState.error(e.toString());
    }
  }

  /// Sonraki sayfa yükle (infinite scroll).
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final response = await _repository.getServices(
        limit: _pageSize,
        startAfter: state.nextCursor,
      );

      state = state.copyWith(
        items: [...state.items, ...response.items],
        hasMore: response.hasMore,
        nextCursor: response.nextCursor,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  /// Pull-to-refresh.
  Future<void> refresh() => loadInitial();
}

/// Paginated services notifier provider.
/// autoDispose kullanılMIyor — tab geçişlerinde state korunmalı.
final servicesNotifierProvider =
    StateNotifierProvider<ServicesNotifier, PaginatedListState<Service>>((ref) {
  final repository = ref.read(servicesRepositoryProvider);
  final notifier = ServicesNotifier(repository);
  // İlk yükleme otomatik — provider oluşturulduğunda
  notifier.loadInitial();
  return notifier;
});

// ============================================================================
// LEGACY: Eski provider'lar — mevcut UI'lar kademeli olarak geçirilecek.
// Backend artık CursorPage döndüğü için items extract ediliyor.
// ============================================================================

/// Eski servicesProvider — FutureProvider.autoDispose
/// services_tab.dart, home_tab.dart, home_page.dart tarafından kullanılıyor.
final servicesProvider = FutureProvider.autoDispose<List<Service>>((ref) async {
  final repository = ref.read(servicesRepositoryProvider);
  // Limit yüksek tutarak eski davranışı korur
  final response = await repository.getServices(limit: 100);
  return response.items;
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
