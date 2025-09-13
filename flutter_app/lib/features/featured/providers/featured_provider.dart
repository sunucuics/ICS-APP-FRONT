import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/featured_model.dart';
import '../../../core/network/api_client.dart';
import '../data/featured_api_service.dart';
import '../data/featured_repository.dart';

// Repository Provider
final featuredRepositoryProvider = Provider<FeaturedRepository>((ref) {
  final apiClient = ref.read(apiClientProvider);
  final apiService = FeaturedApiService(apiClient);
  return FeaturedRepository(apiService);
});

// Featured Products Provider
class FeaturedProductsNotifier
    extends StateNotifier<AsyncValue<List<FeaturedProduct>>> {
  final FeaturedRepository _repository;

  FeaturedProductsNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    loadFeaturedProducts();
  }

  Future<void> loadFeaturedProducts() async {
    try {
      state = const AsyncValue.loading();
      final products = await _repository.getFeaturedProducts();
      state = AsyncValue.data(products);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadFeaturedProducts();
  }

  Future<FeaturedProduct> featureProduct(String productId) async {
    try {
      final featuredProduct = await _repository.featureProduct(productId);
      // Refresh the list
      await loadFeaturedProducts();
      return featuredProduct;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> unfeatureProduct(String productId) async {
    try {
      await _repository.unfeatureProduct(productId);
      // Refresh the list
      await loadFeaturedProducts();
    } catch (error) {
      rethrow;
    }
  }
}

final featuredProductsProvider = StateNotifierProvider<FeaturedProductsNotifier,
    AsyncValue<List<FeaturedProduct>>>((ref) {
  final repository = ref.read(featuredRepositoryProvider);
  return FeaturedProductsNotifier(repository);
});

// Featured Services Provider
class FeaturedServicesNotifier
    extends StateNotifier<AsyncValue<List<FeaturedService>>> {
  final FeaturedRepository _repository;

  FeaturedServicesNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    loadFeaturedServices();
  }

  Future<void> loadFeaturedServices() async {
    try {
      state = const AsyncValue.loading();
      final services = await _repository.getFeaturedServices();
      state = AsyncValue.data(services);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadFeaturedServices();
  }

  Future<FeaturedService> featureService(String serviceId) async {
    try {
      final featuredService = await _repository.featureService(serviceId);
      // Refresh the list
      await loadFeaturedServices();
      return featuredService;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> unfeatureService(String serviceId) async {
    try {
      await _repository.unfeatureService(serviceId);
      // Refresh the list
      await loadFeaturedServices();
    } catch (error) {
      rethrow;
    }
  }
}

final featuredServicesProvider = StateNotifierProvider<FeaturedServicesNotifier,
    AsyncValue<List<FeaturedService>>>((ref) {
  final repository = ref.read(featuredRepositoryProvider);
  return FeaturedServicesNotifier(repository);
});

// Featured Content Provider (Combined)
class FeaturedContentNotifier
    extends StateNotifier<AsyncValue<FeaturedListResponse>> {
  final FeaturedRepository _repository;

  FeaturedContentNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    loadFeaturedContent();
  }

  Future<void> loadFeaturedContent() async {
    try {
      state = const AsyncValue.loading();
      final content = await _repository.getFeaturedContent();
      state = AsyncValue.data(content);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadFeaturedContent();
  }
}

final featuredContentProvider = StateNotifierProvider<FeaturedContentNotifier,
    AsyncValue<FeaturedListResponse>>((ref) {
  final repository = ref.read(featuredRepositoryProvider);
  return FeaturedContentNotifier(repository);
});

// Featured Statistics Provider
class FeaturedStatisticsNotifier
    extends StateNotifier<AsyncValue<FeaturedStatistics>> {
  final FeaturedRepository _repository;

  FeaturedStatisticsNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    loadStatistics();
  }

  Future<void> loadStatistics() async {
    try {
      state = const AsyncValue.loading();
      final statistics = await _repository.getFeaturedStatistics();
      state = AsyncValue.data(statistics);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadStatistics();
  }
}

final featuredStatisticsProvider = StateNotifierProvider<
    FeaturedStatisticsNotifier, AsyncValue<FeaturedStatistics>>((ref) {
  final repository = ref.read(featuredRepositoryProvider);
  return FeaturedStatisticsNotifier(repository);
});

// Convenience Providers
final featuredProductsListProvider = Provider<List<FeaturedProduct>>((ref) {
  return ref.watch(featuredProductsProvider).when(
        data: (products) => products,
        loading: () => <FeaturedProduct>[],
        error: (error, stack) => <FeaturedProduct>[],
      );
});

final featuredServicesListProvider = Provider<List<FeaturedService>>((ref) {
  return ref.watch(featuredServicesProvider).when(
        data: (services) => services,
        loading: () => <FeaturedService>[],
        error: (error, stack) => <FeaturedService>[],
      );
});

final featuredContentDataProvider = Provider<FeaturedListResponse>((ref) {
  return ref.watch(featuredContentProvider).when(
        data: (content) => content,
        loading: () => const FeaturedListResponse(),
        error: (error, stack) => const FeaturedListResponse(),
      );
});

final featuredStatisticsDataProvider = Provider<FeaturedStatistics>((ref) {
  return ref.watch(featuredStatisticsProvider).when(
        data: (stats) => stats,
        loading: () => const FeaturedStatistics(),
        error: (error, stack) => const FeaturedStatistics(),
      );
});

// Helper to manage featured content from anywhere in the app
final featuredManagerProvider = Provider<FeaturedManager>((ref) {
  return FeaturedManager(ref);
});

class FeaturedManager {
  final Ref ref;

  FeaturedManager(this.ref);

  Future<FeaturedProduct> featureProduct(String productId) async {
    return await ref
        .read(featuredProductsProvider.notifier)
        .featureProduct(productId);
  }

  Future<void> unfeatureProduct(String productId) async {
    return await ref
        .read(featuredProductsProvider.notifier)
        .unfeatureProduct(productId);
  }

  Future<FeaturedService> featureService(String serviceId) async {
    return await ref
        .read(featuredServicesProvider.notifier)
        .featureService(serviceId);
  }

  Future<void> unfeatureService(String serviceId) async {
    return await ref
        .read(featuredServicesProvider.notifier)
        .unfeatureService(serviceId);
  }

  Future<void> refreshAll() async {
    await ref.read(featuredProductsProvider.notifier).refresh();
    await ref.read(featuredServicesProvider.notifier).refresh();
    await ref.read(featuredContentProvider.notifier).refresh();
    await ref.read(featuredStatisticsProvider.notifier).refresh();
  }
}
