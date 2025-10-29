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
      // Don't set the entire state to error, just log the error
      // The UI should handle this gracefully
      print('Error updating order status: $error');
      // Optionally, you could show a snackbar or toast instead
      rethrow; // Re-throw to let the UI handle it
    }
  }

  Future<Order> shipOrder(String orderId, OrderShipRequest request) async {
    try {
      final order = await _repository.shipOrder(orderId, request);
      await loadOrders(); // Refresh the list
      return order;
    } catch (error, stackTrace) {
      print('Error shipping order: $error');
      rethrow;
    }
  }

  Future<Order> deliverOrder(String orderId) async {
    try {
      final order = await _repository.deliverOrder(orderId);
      await loadOrders(); // Refresh the list
      return order;
    } catch (error, stackTrace) {
      print('Error delivering order: $error');
      rethrow;
    }
  }

  Future<Order> cancelOrder(String orderId, OrderCancelRequest request) async {
    try {
      final order = await _repository.cancelOrder(orderId, request);
      await loadOrders(); // Refresh the list
      return order;
    } catch (error, stackTrace) {
      print('Error canceling order: $error');
      rethrow;
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      await _repository.deleteOrder(orderId);
      await loadOrders(); // Refresh the list
    } catch (error, stackTrace) {
      print('Error deleting order: $error');
      rethrow;
    }
  }

  Future<void> refresh() async {
    await loadOrders();
  }
}

// Admin Orders Queue Provider
class AdminOrdersQueueNotifier extends StateNotifier<AsyncValue<AdminOrdersQueueResponse>> {
  final AdminRepository _repository;

  AdminOrdersQueueNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadOrdersQueue();
  }

  Future<void> loadOrdersQueue() async {
    try {
      state = const AsyncValue.loading();
      final queueResponse = await _repository.getOrdersQueue();
      state = AsyncValue.data(queueResponse);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadOrdersQueue();
  }
}

final adminOrdersQueueProvider = StateNotifierProvider<AdminOrdersQueueNotifier, AsyncValue<AdminOrdersQueueResponse>>((ref) {
  final repository = ref.watch(adminRepositoryProvider);
  return AdminOrdersQueueNotifier(repository);
});
