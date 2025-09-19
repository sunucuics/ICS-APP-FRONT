import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import '../providers/admin_dashboard_provider.dart';
import '../../../core/models/order_model.dart';

// Orders Provider
final adminOrdersProvider = FutureProvider<List<Order>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getOrders();
});

// Orders State Notifier for CRUD operations
final adminOrdersNotifierProvider =
    StateNotifierProvider<AdminOrdersNotifier, AsyncValue<List<Order>>>((ref) {
  final repository = ref.watch(adminRepositoryProvider);
  return AdminOrdersNotifier(repository);
});

class AdminOrdersNotifier extends StateNotifier<AsyncValue<List<Order>>> {
  final AdminRepository _repository;

  AdminOrdersNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    state = const AsyncValue.loading();
    try {
      final orders = await _repository.getOrders();
      state = AsyncValue.data(orders);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _repository.updateOrderStatus(orderId, status);
      await loadOrders(); // Refresh the list
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadOrders();
  }
}
