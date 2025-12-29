import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import '../providers/admin_dashboard_provider.dart';
import '../providers/admin_products_provider.dart';
import '../models/admin_discount_model.dart';

// Discounts Provider
final adminDiscountsProvider = FutureProvider<List<AdminDiscount>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getDiscounts();
});

// Discounts State Notifier for CRUD operations
final adminDiscountsNotifierProvider = StateNotifierProvider<
    AdminDiscountsNotifier, AsyncValue<List<AdminDiscount>>>((ref) {
  final repository = ref.watch(adminRepositoryProvider);
  return AdminDiscountsNotifier(repository, ref);
});

class AdminDiscountsNotifier
    extends StateNotifier<AsyncValue<List<AdminDiscount>>> {
  final AdminRepository _repository;
  final Ref _ref;

  AdminDiscountsNotifier(this._repository, this._ref)
      : super(const AsyncValue.loading()) {
    loadDiscounts();
  }

  Future<void> loadDiscounts({
    String? productId,
    bool? active,
  }) async {
    state = const AsyncValue.loading();
    try {
      final discounts = await _repository.getDiscounts(
        productId: productId,
        active: active,
      );
      state = AsyncValue.data(discounts);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Create discount using JSON (for category discounts or full control)
  Future<void> createDiscount(DiscountCreateRequest discountData) async {
    try {
      await _repository.createDiscount(discountData);
      await loadDiscounts(); // Refresh the list
      // Also refresh products to update prices
      _ref.read(adminProductsNotifierProvider.notifier).refresh();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Create product discount using form-data (recommended for product discounts)
  Future<void> createDiscountForm(
      DiscountCreateFormRequest discountData) async {
    try {
      await _repository.createDiscountForm(discountData);
      await loadDiscounts(); // Refresh the list
      // Also refresh products to update prices
      _ref.read(adminProductsNotifierProvider.notifier).refresh();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Update discount using JSON (for category discounts or full control)
  Future<void> updateDiscount(
      String discountId, DiscountUpdateRequest discountData) async {
    try {
      await _repository.updateDiscount(discountId, discountData);
      await loadDiscounts(); // Refresh the list
      // Also refresh products to update prices
      _ref.read(adminProductsNotifierProvider.notifier).refresh();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Update product discount using form-data (recommended for product discounts)
  Future<void> updateDiscountForm(
      String discountId, DiscountUpdateFormRequest discountData) async {
    try {
      await _repository.updateDiscountForm(discountId, discountData);
      await loadDiscounts(); // Refresh the list
      // Also refresh products to update prices
      _ref.read(adminProductsNotifierProvider.notifier).refresh();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteDiscount(String discountId) async {
    try {
      await _repository.deleteDiscount(discountId);
      await loadDiscounts(); // Refresh the list
      // Also refresh products to update prices
      _ref.read(adminProductsNotifierProvider.notifier).refresh();
    } catch (error, stackTrace) {
      // Hata olsa bile listeyi yenile (indirim zaten silinmiş olabilir)
      // Özellikle 404 hatası durumunda (indirim zaten silinmiş)
      try {
        await loadDiscounts(); // Refresh the list anyway
        _ref.read(adminProductsNotifierProvider.notifier).refresh();
      } catch (_) {
        // Liste yenileme de başarısız olursa hatayı göster
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }

  Future<void> refresh({
    String? productId,
    bool? active,
  }) async {
    await loadDiscounts(productId: productId, active: active);
  }
}
