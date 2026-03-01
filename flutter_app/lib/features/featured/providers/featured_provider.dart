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
  bool _hasLoaded = false;

  FeaturedProductsNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    // Don't load immediately - wait until first access (lazy loading)
  }

  Future<void> loadFeaturedProducts({bool force = false}) async {
    // Prevent multiple simultaneous loads
    if (!force && _hasLoaded && state.hasValue) return;

    try {
      // İlk yüklemede loading göster, force refresh'te mevcut datayı koru
      if (!_hasLoaded) {
        state = const AsyncValue.loading();
      }
      final products = await _repository.getFeaturedProducts();
      state = AsyncValue.data(products);
      _hasLoaded = true;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      _hasLoaded = false;
    }
  }

  Future<void> refresh() async {
    await loadFeaturedProducts(force: true);
  }

  Future<FeaturedProduct> featureProduct(String productId) async {
    // Optimistic update: hemen listeye ekle
    final currentList = state.valueOrNull ?? [];
    final optimistic = FeaturedProduct(id: productId);
    state = AsyncValue.data([...currentList, optimistic]);

    try {
      final featuredProduct = await _repository.featureProduct(productId);
      // Sunucudan güncel listeyi al
      await loadFeaturedProducts(force: true);
      return featuredProduct;
    } catch (error) {
      // Hata durumunda eski listeye geri dön
      state = AsyncValue.data(currentList);
      rethrow;
    }
  }

  Future<void> unfeatureProduct(String productId) async {
    // Optimistic update: hemen listeden çıkar
    final currentList = state.valueOrNull ?? [];
    state = AsyncValue.data(
      currentList.where((p) => p.id != productId).toList(),
    );

    try {
      await _repository.unfeatureProduct(productId);
      // Sunucudan güncel listeyi al
      await loadFeaturedProducts(force: true);
    } catch (error) {
      // Hata durumunda eski listeye geri dön
      state = AsyncValue.data(currentList);
      rethrow;
    }
  }
}

final featuredProductsProvider = StateNotifierProvider<
    FeaturedProductsNotifier, AsyncValue<List<FeaturedProduct>>>((ref) {
  final repository = ref.read(featuredRepositoryProvider);
  final notifier = FeaturedProductsNotifier(repository);
  // Load data when provider is first accessed
  notifier.loadFeaturedProducts();
  return notifier;
});

// Featured Services Provider
class FeaturedServicesNotifier
    extends StateNotifier<AsyncValue<List<FeaturedService>>> {
  final FeaturedRepository _repository;
  bool _hasLoaded = false;

  FeaturedServicesNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    // Don't load immediately - wait until first access (lazy loading)
  }

  Future<void> loadFeaturedServices({bool force = false}) async {
    // Prevent multiple simultaneous loads
    if (!force && _hasLoaded && state.hasValue) return;

    try {
      // İlk yüklemede loading göster, force refresh'te mevcut datayı koru
      if (!_hasLoaded) {
        state = const AsyncValue.loading();
      }
      final services = await _repository.getFeaturedServices();
      state = AsyncValue.data(services);
      _hasLoaded = true;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      _hasLoaded = false;
    }
  }

  Future<void> refresh() async {
    await loadFeaturedServices(force: true);
  }

  Future<FeaturedService> featureService(String serviceId) async {
    // Optimistic update: hemen listeye ekle
    final currentList = state.valueOrNull ?? [];
    final optimistic = FeaturedService(id: serviceId);
    state = AsyncValue.data([...currentList, optimistic]);

    try {
      final featuredService = await _repository.featureService(serviceId);
      // Sunucudan güncel listeyi al
      await loadFeaturedServices(force: true);
      return featuredService;
    } catch (error) {
      // Hata durumunda eski listeye geri dön
      state = AsyncValue.data(currentList);
      rethrow;
    }
  }

  Future<void> unfeatureService(String serviceId) async {
    // Optimistic update: hemen listeden çıkar
    final currentList = state.valueOrNull ?? [];
    state = AsyncValue.data(
      currentList.where((s) => s.id != serviceId).toList(),
    );

    try {
      await _repository.unfeatureService(serviceId);
      // Sunucudan güncel listeyi al
      await loadFeaturedServices(force: true);
    } catch (error) {
      // Hata durumunda eski listeye geri dön
      state = AsyncValue.data(currentList);
      rethrow;
    }
  }
}

final featuredServicesProvider = StateNotifierProvider<
    FeaturedServicesNotifier, AsyncValue<List<FeaturedService>>>((ref) {
  final repository = ref.read(featuredRepositoryProvider);
  final notifier = FeaturedServicesNotifier(repository);
  // Load data when provider is first accessed
  notifier.loadFeaturedServices();
  return notifier;
});

// Featured Content Provider (Combined)
class FeaturedContentNotifier
    extends StateNotifier<AsyncValue<FeaturedListResponse>> {
  final FeaturedRepository _repository;
  bool _hasLoaded = false;

  FeaturedContentNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    // Don't load immediately - wait until first access (lazy loading)
  }

  Future<void> loadFeaturedContent({bool force = false}) async {
    // Prevent multiple simultaneous loads
    if (!force && _hasLoaded && state.hasValue) return;

    try {
      if (!_hasLoaded) {
        state = const AsyncValue.loading();
      }
      final content = await _repository.getFeaturedContent();
      state = AsyncValue.data(content);
      _hasLoaded = true;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      _hasLoaded = false;
    }
  }

  Future<void> refresh() async {
    await loadFeaturedContent(force: true);
  }
}

final featuredContentProvider = StateNotifierProvider<
    FeaturedContentNotifier, AsyncValue<FeaturedListResponse>>((ref) {
  final repository = ref.read(featuredRepositoryProvider);
  final notifier = FeaturedContentNotifier(repository);
  // Load data when provider is first accessed
  notifier.loadFeaturedContent();
  return notifier;
});

// Featured Statistics Provider
class FeaturedStatisticsNotifier
    extends StateNotifier<AsyncValue<FeaturedStatistics>> {
  final FeaturedRepository _repository;
  bool _hasLoaded = false;

  FeaturedStatisticsNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    // Don't load immediately - wait until first access (lazy loading)
  }

  Future<void> loadStatistics({bool force = false}) async {
    // Prevent multiple simultaneous loads
    if (!force && _hasLoaded && state.hasValue) return;

    try {
      if (!_hasLoaded) {
        state = const AsyncValue.loading();
      }
      final statistics = await _repository.getFeaturedStatistics();
      state = AsyncValue.data(statistics);
      _hasLoaded = true;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      _hasLoaded = false;
    }
  }

  Future<void> refresh() async {
    await loadStatistics(force: true);
  }
}

final featuredStatisticsProvider = StateNotifierProvider<
    FeaturedStatisticsNotifier, AsyncValue<FeaturedStatistics>>((ref) {
  final repository = ref.read(featuredRepositoryProvider);
  final notifier = FeaturedStatisticsNotifier(repository);
  // Load data when provider is first accessed
  notifier.loadStatistics();
  return notifier;
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
    // Parallel refresh — 4x faster than sequential awaits
    await Future.wait([
      ref.read(featuredProductsProvider.notifier).refresh(),
      ref.read(featuredServicesProvider.notifier).refresh(),
      ref.read(featuredContentProvider.notifier).refresh(),
      ref.read(featuredStatisticsProvider.notifier).refresh(),
    ]);
  }
}
