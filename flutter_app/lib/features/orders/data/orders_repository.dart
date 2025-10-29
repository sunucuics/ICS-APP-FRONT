import '../../../core/models/order_model.dart';
import 'orders_api_service.dart';

class OrdersRepository {
  final OrdersApiService _apiService;

  OrdersRepository(this._apiService);

  /// Create a new order from cart or items
  Future<Order> createOrder({
    List<OrderCreateItem>? items,
    String? note,
    bool simulate = false,
    bool clearCartOnSuccess = true,
    String? checkoutId,
  }) async {
    return await _apiService.createOrder(
      items: items,
      note: note,
      simulate: simulate,
      clearCartOnSuccess: clearCartOnSuccess,
      checkoutId: checkoutId,
    );
  }

  /// Get user's orders with filtering and pagination
  Future<OrdersListResponse> getMyOrders({
    String? status,
    int? limit,
    String? startAfter,
  }) async {
    return await _apiService.getMyOrders(
      status: status,
      limit: limit,
      startAfter: startAfter,
    );
  }

  /// Get order details by ID
  Future<Order> getOrderDetail(String orderId) async {
    return await _apiService.getOrderDetail(orderId);
  }

  /// Sync order status from Aras Kargo
  Future<Order> syncOrderStatus(String orderId) async {
    return await _apiService.syncOrderStatus(orderId);
  }

  /// Debug active address (for development)
  Future<Map<String, dynamic>> debugActiveAddress() async {
    return await _apiService.debugActiveAddress();
  }
}
