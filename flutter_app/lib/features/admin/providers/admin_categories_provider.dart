import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import '../providers/admin_dashboard_provider.dart';
import '../../../core/models/product_model.dart';

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
  return AdminCategoriesNotifier(repository);
});

class AdminCategoriesNotifier
    extends StateNotifier<AsyncValue<List<Category>>> {
  final AdminRepository _repository;

  AdminCategoriesNotifier(this._repository)
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
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateCategory(
      String categoryId, Map<String, dynamic> categoryData) async {
    try {
      await _repository.updateCategory(categoryId, categoryData);
      await loadCategories(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await _repository.deleteCategory(categoryId);
      await loadCategories(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadCategories();
  }
}
