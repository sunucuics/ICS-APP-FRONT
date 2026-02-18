import 'package:dio/dio.dart';
import '../../../core/models/order_model.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/exceptions/api_exception.dart';

class OrdersApiService {
  final Dio _dio;

  OrdersApiService(this._dio);

  /// Create a new order from cart
  /// Backend reads cart from user_id and creates order automatically
  /// According to backend docs: Body is empty, backend reads from cart
  Future<Order> createOrder({
    // Deprecated: items parameter - backend reads from cart
    @Deprecated('Backend reads from cart, items parameter is ignored')
    List<OrderCreateItem>? items,
    // Deprecated: note parameter - backend reads from cart
    @Deprecated('Backend reads from cart, note parameter is ignored')
    String? note,
    bool simulate = false,
    bool clearCartOnSuccess = true,
    String? checkoutId,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.orders,
        // No body according to backend docs
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

      final data = Map<String, dynamic>.from(response.data);
      return Order.fromJson(_sanitizeOrderJson(data));
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Get user's orders with filtering and pagination
  /// Query parameters: view_type (active|past), limit (1..100, default 20), start_after (ISO datetime cursor)
  Future<OrdersListResponse> getMyOrders({
    String viewType = 'active', // active|past
    int? limit, // 1..100, default 20
    String? startAfter, // ISO datetime cursor (start_after)
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'view_type': viewType,
      };
      
      if (limit != null && limit >= 1 && limit <= 100) {
        queryParams['limit'] = limit;
      }
      if (startAfter != null && startAfter.isNotEmpty) {
        queryParams['start_after'] = startAfter; // ISO datetime cursor
      }

      final response = await _dio.get(
        ApiEndpoints.orders,
        queryParameters: queryParams,
      );
      final data = Map<String, dynamic>.from(response.data);
      final items = (data['items'] as List<dynamic>? ?? [])
          .map((item) => _sanitizeOrderJson(
                Map<String, dynamic>.from(item as Map),
              ))
          .toList();
      data['items'] = items;
      return OrdersListResponse.fromJson(data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Get order details by ID
  Future<Order> getOrderDetail(String orderId) async {
    try {
      final response = await _dio.get(ApiEndpoints.order(orderId));
      final data = Map<String, dynamic>.from(response.data);
      return Order.fromJson(_sanitizeOrderJson(data));
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Cancel awaiting order
  Future<void> cancelAwaitingOrder(String orderId) async {
    try {
      await _dio.post('${ApiEndpoints.order(orderId)}/cancel-awaiting');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Sync order status from Aras Kargo
  Future<Order> syncOrderStatus(String orderId) async {
    try {
      final response =
          await _dio.post('${ApiEndpoints.order(orderId)}/sync-status');
      final data = Map<String, dynamic>.from(response.data);
      return Order.fromJson(_sanitizeOrderJson(data));
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

Map<String, dynamic> _sanitizeOrderJson(Map<String, dynamic> json) {
  final sanitized = Map<String, dynamic>.from(json);

  final payment = sanitized['payment'];
  if (payment is Map<String, dynamic>) {
    final hasRequiredPaymentFields =
        (payment['provider'] != null && payment['status'] != null); 
        // currency and received_total are optional now

    if (!hasRequiredPaymentFields || payment.isEmpty) {
      sanitized['payment'] = null;
    }
  } else if (payment == null) {
    sanitized['payment'] = null;
  }

  return sanitized;
}
