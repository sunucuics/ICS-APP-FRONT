import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import '../providers/admin_dashboard_provider.dart';
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
  return AdminDiscountsNotifier(repository);
});

class AdminDiscountsNotifier
    extends StateNotifier<AsyncValue<List<AdminDiscount>>> {
  final AdminRepository _repository;

  AdminDiscountsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadDiscounts();
  }

  Future<void> loadDiscounts() async {
    state = const AsyncValue.loading();
    try {
      final discounts = await _repository.getDiscounts();
      state = AsyncValue.data(discounts);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> createDiscount(DiscountCreateRequest discountData) async {
    try {
      await _repository.createDiscount(discountData);
      await loadDiscounts(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateDiscount(
      String discountId, DiscountUpdateRequest discountData) async {
    try {
      await _repository.updateDiscount(discountId, discountData);
      await loadDiscounts(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteDiscount(String discountId) async {
    try {
      await _repository.deleteDiscount(discountId);
      await loadDiscounts(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadDiscounts();
  }
}
