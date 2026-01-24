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

// Paginated Orders State
class PaginatedOrdersState {
  final List<Order> items;
  final bool isLoading;
  final bool hasMore;
  final String? nextCursor;
  final Object? error;

  const PaginatedOrdersState({
    this.items = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.nextCursor,
    this.error,
  });

  PaginatedOrdersState copyWith({
    List<Order>? items,
    bool? isLoading,
    bool? hasMore,
    String? nextCursor,
    Object? error,
  }) {
    return PaginatedOrdersState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      nextCursor: nextCursor ?? this.nextCursor,
      error: error, // Error is nullable, so if passed as null it clears
    );
  }
}

// Paginated Orders Notifier
class PaginatedOrdersNotifier extends StateNotifier<PaginatedOrdersState> {
  final OrdersRepository _repository;
  final String _viewType; // 'active' or 'past'
  bool _isFetching = false;

  PaginatedOrdersNotifier(this._repository, this._viewType)
      : super(const PaginatedOrdersState()) {
    loadInitial();
  }

  Future<void> loadInitial() async {
    if (_isFetching) return;
    _isFetching = true;
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _repository.getMyOrders(
        viewType: _viewType,
        limit: 20,
      );

      state = state.copyWith(
        items: response.items,
        isLoading: false,
        hasMore: response.nextCursor != null && response.items.length >= 20,
        nextCursor: response.nextCursor,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    } finally {
      _isFetching = false;
    }
  }

  Future<void> loadMore() async {
    if (_isFetching || !state.hasMore || state.nextCursor == null) return;
    _isFetching = true;
    
    // Don't set isLoading = true here to avoid full page loader, 
    // maybe add isLoadingMore flag if needed, but for now just append
    
    try {
      final response = await _repository.getMyOrders(
        viewType: _viewType,
        limit: 20,
        startAfter: state.nextCursor,
      );

      state = state.copyWith(
        items: [...state.items, ...response.items],
        hasMore: response.nextCursor != null && response.items.length >= 20,
        nextCursor: response.nextCursor,
      );
    } catch (e) {
      // Handle error quietly or show snackbar via listener? 
      // For list state, we might just stop loading
      state = state.copyWith(error: e);
    } finally {
      _isFetching = false;
    }
  }

  Future<void> refresh() async {
    state = const PaginatedOrdersState(); // Reset state
    await loadInitial();
  }
}

// Providers for Active and Past orders
final activeOrdersProvider =
    StateNotifierProvider<PaginatedOrdersNotifier, PaginatedOrdersState>((ref) {
  final repository = ref.read(ordersRepositoryProvider);
  return PaginatedOrdersNotifier(repository, 'active');
});

final pastOrdersProvider =
    StateNotifierProvider<PaginatedOrdersNotifier, PaginatedOrdersState>((ref) {
  final repository = ref.read(ordersRepositoryProvider);
  return PaginatedOrdersNotifier(repository, 'past');
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

  Future<void> cancelAwaitingOrder() async {
    if (_currentOrderId != null) {
      try {
        await _repository.cancelAwaitingOrder(_currentOrderId!);
        // Refresh order detail to get updated status
        await loadOrderDetail(_currentOrderId!);
      } catch (error, stackTrace) {
        // Here we might want to keep the current state but maybe notify UI of error?
        // Since we are using AsyncValue, setting error will replace content.
        // Better strategy for actions is to rethrow or use a separate side-effect provider.
        // For simplicity, we'll assume UI handles AsyncValue.error but it might hide the detail.
        // Let's just rethrow so UI can catch it? 
        // Cannot rethrow easily from void method.
        // Let's set error state temporarily or use a specific pattern?
        // For now, let's just refresh, if it failed on backend, it might throw.
        // Ideally we should have a separate 'actionStatus' provider.
        throw error; // Let UI handle try-catch
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
    String? referenceNumber, // Added to match other flows if needed
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
