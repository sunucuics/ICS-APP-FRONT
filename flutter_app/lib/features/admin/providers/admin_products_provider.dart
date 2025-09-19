import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import '../providers/admin_dashboard_provider.dart';
import '../../../core/models/product_model.dart';

// Products Provider
final adminProductsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getProducts();
});

// Products State Notifier for CRUD operations
final adminProductsNotifierProvider =
    StateNotifierProvider<AdminProductsNotifier, AsyncValue<List<Product>>>(
        (ref) {
  final repository = ref.watch(adminRepositoryProvider);
  return AdminProductsNotifier(repository);
});

class AdminProductsNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final AdminRepository _repository;

  AdminProductsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    state = const AsyncValue.loading();
    try {
      final products = await _repository.getProducts();
      state = AsyncValue.data(products);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> createProduct(Map<String, dynamic> productData) async {
    try {
      await _repository.createProduct(productData);
      await loadProducts(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateProduct(
      String productId, Map<String, dynamic> productData) async {
    try {
      await _repository.updateProduct(productId, productData);
      await loadProducts(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _repository.deleteProduct(productId);
      await loadProducts(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadProducts();
  }
}
