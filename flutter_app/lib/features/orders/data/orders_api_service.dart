import 'package:dio/dio.dart';
import '../../../core/models/order_model.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/exceptions/api_exception.dart';

class OrdersApiService {
  final Dio _dio;

  OrdersApiService(this._dio);

  /// Create a new order from cart or items
  Future<Order> createOrder({
    List<OrderCreateItem>? items,
    String? note,
    bool simulate = false,
    bool clearCartOnSuccess = true,
    String? checkoutId,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.orders,
        data: OrderCreateRequest(
          items: items ?? [],
          note: note,
        ).toJson(),
        queryParameters: {
          'simulate': simulate,
          'clear_cart_on_success': clearCartOnSuccess,
          if (checkoutId != null) 'checkout_id': checkoutId,
        },
      );

      return Order.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Get user's orders (active and past)
  Future<OrdersListResponse> getMyOrders() async {
    try {
      final response = await _dio.get(ApiEndpoints.orders + '/my');
      return OrdersListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Get order details by ID
  Future<Order> getOrderDetail(String orderId) async {
    try {
      final response = await _dio.get(ApiEndpoints.order(orderId));
      return Order.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Sync order status from Aras Kargo
  Future<Order> syncOrderStatus(String orderId) async {
    try {
      final response =
          await _dio.post('${ApiEndpoints.order(orderId)}/sync-status');
      return Order.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Debug active address (for development)
  Future<Map<String, dynamic>> debugActiveAddress() async {
    try {
      final response = await _dio.get('${ApiEndpoints.orders}/_debug/address');
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
