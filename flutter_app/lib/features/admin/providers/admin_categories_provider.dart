import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import '../providers/admin_dashboard_provider.dart';
import '../../../core/models/product_model.dart';
import '../../../features/products/providers/products_provider.dart';

// Categories Provider
final adminCategoriesProvider = FutureProvider<List<Category>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getCategories();
});

// Categories State Notifier for CRUD operations
final adminCategoriesNotifierProvider =
    StateNotifierProvider<AdminCategoriesNotifier, AsyncValue<List<Category>>>(
        (ref) {
  final repository = ref.watch(adminRepositoryProvider);
  return AdminCategoriesNotifier(repository, ref);
});

class AdminCategoriesNotifier
    extends StateNotifier<AsyncValue<List<Category>>> {
  final AdminRepository _repository;
  final Ref _ref;

  AdminCategoriesNotifier(this._repository, this._ref)
      : super(const AsyncValue.loading()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    state = const AsyncValue.loading();
    try {
      final categories = await _repository.getCategories();
      state = AsyncValue.data(categories);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> createCategory(Map<String, dynamic> categoryData) async {
    try {
      await _repository.createCategory(categoryData);
      await loadCategories(); // Refresh the list
      // Immediately refresh main app's categories provider (pre-fetch for instant update)
      _ref.invalidate(categoriesProvider);
      _ref.read(categoriesProvider); // Trigger immediate fetch in background
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateCategory(
      String categoryId, Map<String, dynamic> categoryData) async {
    try {
      await _repository.updateCategory(categoryId, categoryData);
      await loadCategories(); // Refresh the list
      // Immediately refresh main app's categories provider (pre-fetch for instant update)
      _ref.invalidate(categoriesProvider);
      _ref.read(categoriesProvider); // Trigger immediate fetch in background
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await _repository.deleteCategory(categoryId);
      await loadCategories(); // Refresh the list
      // Immediately refresh main app's categories provider (pre-fetch for instant update)
      _ref.invalidate(categoriesProvider);
      _ref.read(categoriesProvider); // Trigger immediate fetch in background
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadCategories();
  }
}
