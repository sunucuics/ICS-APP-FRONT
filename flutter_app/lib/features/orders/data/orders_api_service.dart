import 'package:dio/dio.dart';
import '../../../core/models/order_model.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/exceptions/api_exception.dart';

class OrdersApiService {
  final Dio _dio;

  OrdersApiService(this._dio);

  /// Create a new order from cart
  /// Backend reads cart from user_id and creates order automatically
  Future<Order> createOrder({
    List<OrderCreateItem>? items, // Optional - backend reads from cart if empty
    String? note,
    bool simulate = false,
    bool clearCartOnSuccess = true,
    String? checkoutId,
  }) async {
    try {
      // Backend reads cart from user_id, so no body needed per Swagger docs
      print('🔍 [ORDER CREATE DEBUG] Sending POST /orders with empty body');
      
      final response = await _dio.post(
        ApiEndpoints.orders,
        data: null, // Explicitly null to avoid Content-Type header
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
          },
        ),
        queryParameters: {
          'simulate': simulate,
          'clear_cart_on_success': clearCartOnSuccess,
          if (checkoutId != null) 'checkout_id': checkoutId,
        },
      );

      print('🔍 [ORDER CREATE DEBUG] Response: ${response.data}');
      return Order.fromJson(response.data);
    } on DioException catch (e) {
      print('🔍 [ORDER CREATE DEBUG] Error: ${e.response?.data}');
      print('🔍 [ORDER CREATE DEBUG] Status code: ${e.response?.statusCode}');
      throw ApiException.fromDioException(e);
    }
  }

  /// Get user's orders with filtering and pagination
  Future<OrdersListResponse> getMyOrders({
    String? status,
    int? limit,
    String? startAfter,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (status != null) queryParams['status'] = status;
      if (limit != null) queryParams['limit'] = limit;
      if (startAfter != null) queryParams['start_after'] = startAfter;

      final response = await _dio.get(
        ApiEndpoints.orders,
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );
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
