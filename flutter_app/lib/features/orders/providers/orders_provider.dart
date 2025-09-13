import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/order_model.dart';
import '../../../core/network/api_client.dart';
import '../data/orders_api_service.dart';
import '../data/orders_repository.dart';

// Repository Provider
final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  final apiClient = ref.read(apiClientProvider);
  final apiService = OrdersApiService(apiClient);
  return OrdersRepository(apiService);
});

// Orders List Provider
class OrdersNotifier extends StateNotifier<AsyncValue<OrdersListResponse>> {
  final OrdersRepository _repository;

  OrdersNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    try {
      state = const AsyncValue.loading();
      final orders = await _repository.getMyOrders();
      state = AsyncValue.data(orders);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadOrders();
  }
}

final ordersProvider =
    StateNotifierProvider<OrdersNotifier, AsyncValue<OrdersListResponse>>(
        (ref) {
  final repository = ref.read(ordersRepositoryProvider);
  return OrdersNotifier(repository);
});

// Order Detail Provider
class OrderDetailNotifier extends StateNotifier<AsyncValue<Order>> {
  final OrdersRepository _repository;
  String? _currentOrderId;

  OrderDetailNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadOrderDetail(String orderId) async {
    if (_currentOrderId == orderId && state.hasValue) {
      return; // Already loaded
    }

    try {
      state = const AsyncValue.loading();
      _currentOrderId = orderId;
      final order = await _repository.getOrderDetail(orderId);
      state = AsyncValue.data(order);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    if (_currentOrderId != null) {
      await loadOrderDetail(_currentOrderId!);
    }
  }

  Future<void> syncStatus() async {
    if (_currentOrderId != null) {
      try {
        final updatedOrder =
            await _repository.syncOrderStatus(_currentOrderId!);
        state = AsyncValue.data(updatedOrder);
      } catch (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }
}

final orderDetailProvider =
    StateNotifierProvider<OrderDetailNotifier, AsyncValue<Order>>((ref) {
  final repository = ref.read(ordersRepositoryProvider);
  return OrderDetailNotifier(repository);
});

// Create Order Provider
class CreateOrderNotifier extends StateNotifier<AsyncValue<Order?>> {
  final OrdersRepository _repository;

  CreateOrderNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<Order?> createOrder({
    List<OrderCreateItem>? items,
    String? note,
    bool simulate = false,
    bool clearCartOnSuccess = true,
    String? checkoutId,
  }) async {
    try {
      state = const AsyncValue.loading();
      final order = await _repository.createOrder(
        items: items,
        note: note,
        simulate: simulate,
        clearCartOnSuccess: clearCartOnSuccess,
        checkoutId: checkoutId,
      );
      state = AsyncValue.data(order);
      return order;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return null;
    }
  }

  void clearState() {
    state = const AsyncValue.data(null);
  }
}

final createOrderProvider =
    StateNotifierProvider<CreateOrderNotifier, AsyncValue<Order?>>((ref) {
  final repository = ref.read(ordersRepositoryProvider);
  return CreateOrderNotifier(repository);
});

// Convenience Providers
final activeOrdersProvider = Provider<List<Order>>((ref) {
  return ref.watch(ordersProvider).when(
        data: (ordersResponse) => ordersResponse.active,
        loading: () => <Order>[],
        error: (error, stack) => <Order>[],
      );
});

final pastOrdersProvider = Provider<List<Order>>((ref) {
  return ref.watch(ordersProvider).when(
        data: (ordersResponse) => ordersResponse.past,
        loading: () => <Order>[],
        error: (error, stack) => <Order>[],
      );
});

final ordersCountProvider = Provider<int>((ref) {
  return ref.watch(ordersProvider).when(
        data: (ordersResponse) =>
            ordersResponse.active.length + ordersResponse.past.length,
        loading: () => 0,
        error: (error, stack) => 0,
      );
});

// Helper to create order from anywhere in the app
final createOrderHelperProvider = Provider<
    Future<Order?> Function({
      List<OrderCreateItem>? items,
      String? note,
      bool simulate,
      bool clearCartOnSuccess,
      String? checkoutId,
    })>((ref) {
  return ({
    List<OrderCreateItem>? items,
    String? note,
    bool simulate = false,
    bool clearCartOnSuccess = true,
    String? checkoutId,
  }) async {
    return await ref.read(createOrderProvider.notifier).createOrder(
          items: items,
          note: note,
          simulate: simulate,
          clearCartOnSuccess: clearCartOnSuccess,
          checkoutId: checkoutId,
        );
  };
});
