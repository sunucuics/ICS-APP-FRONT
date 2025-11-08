import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

// Order Status Enum - Updated for backend integration
@freezed
class OrderStatus with _$OrderStatus {
  const factory OrderStatus.preparing() = _Preparing;
  const factory OrderStatus.shipped() = _Shipped;
  const factory OrderStatus.delivered() = _Delivered;
  const factory OrderStatus.canceled() = _Canceled;
  const factory OrderStatus.paymentFailed() = _PaymentFailed;

  const OrderStatus._();

  factory OrderStatus.fromString(String status) {
    switch (status.toLowerCase()) {
      case 'preparing':
        return const OrderStatus.preparing();
      case 'shipped':
        return const OrderStatus.shipped();
      case 'delivered':
        return const OrderStatus.delivered();
      case 'canceled':
      case 'cancelled':
        return const OrderStatus.canceled();
      case 'payment_failed':
        return const OrderStatus.paymentFailed();
      default:
        return const OrderStatus.preparing();
    }
  }

  String get displayName {
    return when(
      preparing: () => 'Hazırlanıyor',
      shipped: () => 'Kargoya Verildi',
      delivered: () => 'Teslim Edildi',
      canceled: () => 'İptal Edildi',
      paymentFailed: () => 'Ödeme Başarısız',
    );
  }

  String get backendValue {
    return when(
      preparing: () => 'preparing',
      shipped: () => 'shipped',
      delivered: () => 'delivered',
      canceled: () => 'canceled',
      paymentFailed: () => 'payment_failed',
    );
  }
}

// Address Model
@freezed
class Address with _$Address {
  const factory Address({
    String? id,
    String? name,
    String? label,
    String? city,
    String? district,
    String? neighborhood,
    String? street,
    String? buildingNo,
    String? apartment,
    String? floor,
    String? zipCode,
    String? note,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

// Order Item Model
@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    @JsonKey(name: 'product_id') String? productId,
    String? name,
    @JsonKey(name: 'title') String? title,
    int? quantity,
    double? price,
    @JsonKey(name: 'unit_price') double? unitPrice,
    double? total,
    @JsonKey(name: 'line_total') double? lineTotal,
    String? currency,
    String? sku,
    @JsonKey(name: 'variant_id') String? variantId,
    @JsonKey(name: 'image_url') String? imageUrl,
    @Default({}) Map<String, dynamic> options,
    Map<String, dynamic>? product,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}

// Totals Model
@freezed
class OrderTotals with _$OrderTotals {
  const factory OrderTotals({
    @JsonKey(name: 'item_count') int? itemCount,
    double? subtotal,
    double? discount,
    double? shipping,
    double? tax,
    @JsonKey(name: 'grand_total') double? grandTotal,
    String? currency,
  }) = _OrderTotals;

  factory OrderTotals.fromJson(Map<String, dynamic> json) =>
      _$OrderTotalsFromJson(json);
}

// Payment Model
@freezed
class OrderPayment with _$OrderPayment {
  const factory OrderPayment({
    required String provider,
    required String status,
    @JsonKey(name: 'received_total') double? receivedTotal,
    required String currency,
    @JsonKey(name: 'payment_type') String? paymentType,
    @JsonKey(name: 'reported_at') DateTime? reportedAt,
    Map<String, dynamic>? paytr,
  }) = _OrderPayment;

  factory OrderPayment.fromJson(Map<String, dynamic> json) =>
      _$OrderPaymentFromJson(json);
}

// Shipment Model - Updated for backend integration
@freezed
class OrderShipment with _$OrderShipment {
  const factory OrderShipment({
    String? provider,
    @JsonKey(name: 'tracking_number') String? trackingNumber,
    String? status,
    @JsonKey(name: 'shipped_at') DateTime? shippedAt,
    @JsonKey(name: 'delivered_at') DateTime? deliveredAt,
    bool? simulated,
    String? log,
  }) = _OrderShipment;

  factory OrderShipment.fromJson(Map<String, dynamic> json) =>
      _$OrderShipmentFromJson(json);
}

// Status History Model
@freezed
class OrderStatusHistory with _$OrderStatusHistory {
  const factory OrderStatusHistory({
    required String status,
    required DateTime at,
    required String by,
  }) = _OrderStatusHistory;

  factory OrderStatusHistory.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusHistoryFromJson(json);
}

// Customer Model
@freezed
class OrderCustomer with _$OrderCustomer {
  const factory OrderCustomer({
    @JsonKey(name: 'full_name') required String fullName,
    required String email,
    required String phone,
    required OrderAddress address,
  }) = _OrderCustomer;

  factory OrderCustomer.fromJson(Map<String, dynamic> json) =>
      _$OrderCustomerFromJson(json);
}

// Order Address Model (simplified for backend)
@freezed
class OrderAddress with _$OrderAddress {
  const factory OrderAddress({
    @JsonKey(name: 'line1') required String line1,
    required String city,
    @JsonKey(name: 'postal_code') required String postalCode,
    @Default('TR') String country,
  }) = _OrderAddress;

  factory OrderAddress.fromJson(Map<String, dynamic> json) {
    // If backend already returns expected schema, use generated parser
    if (json.containsKey('line1')) {
      return _$OrderAddressFromJson(json);
    }

    String? _asString(dynamic value) {
      if (value == null) return null;
      final str = value.toString().trim();
      return str.isEmpty ? null : str;
    }

    String _joinParts(List<String?> parts) {
      final buffer = StringBuffer();
      for (final part in parts) {
        if (part == null || part.trim().isEmpty) continue;
        if (buffer.isNotEmpty) buffer.write(', ');
        buffer.write(part.trim());
      }
      return buffer.isEmpty ? 'Adres' : buffer.toString();
    }

    final line1 = _joinParts([
      _asString(json['label']),
      _asString(json['street']),
      _asString(json['buildingNo']),
      _asString(json['apartment']),
      _asString(json['floor']),
      _asString(json['neighborhood']),
      _asString(json['district']),
    ]);

    final city = _asString(json['city']) ?? _asString(json['district']) ?? 'İstanbul';
    final postalCode =
        _asString(json['postal_code']) ?? _asString(json['zipCode']) ?? '00000';
    final country =
        _asString(json['country']) ?? _asString(json['countryCode']) ?? 'TR';

    return _OrderAddress(
      line1: line1,
      city: city,
      postalCode: postalCode,
      country: country,
    );
  }
}

// Shipping Model
@freezed
class OrderShipping with _$OrderShipping {
  const factory OrderShipping({
    required String provider,
  }) = _OrderShipping;

  factory OrderShipping.fromJson(Map<String, dynamic> json) =>
      _$OrderShippingFromJson(json);
}

// Email Flags Model
@freezed
class OrderEmailFlags with _$OrderEmailFlags {
  const factory OrderEmailFlags({
    @JsonKey(name: 'shipped_sent') @Default(false) bool shippedSent,
    @JsonKey(name: 'delivered_sent') @Default(false) bool deliveredSent,
    @JsonKey(name: 'canceled_sent') @Default(false) bool canceledSent,
  }) = _OrderEmailFlags;

  factory OrderEmailFlags.fromJson(Map<String, dynamic> json) =>
      _$OrderEmailFlagsFromJson(json);
}

// Main Order Model - Updated for backend integration
@freezed
class Order with _$Order {
  const factory Order({
    String? id,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    required OrderStatus status,
    @JsonKey(name: 'tracking_number') String? trackingNumber,
    @JsonKey(name: 'shipping_provider') String? shippingProvider,
    @JsonKey(name: 'integration_code') String? integrationCode,
    Address? address,
    List<OrderItem>? items,
    OrderTotals? totals,
    OrderShipment? shipment,
    String? note,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'customer_name') String? customerName,
    @JsonKey(name: 'customer_phone') String? customerPhone,
    @JsonKey(name: 'customer_email') String? customerEmail,
    // New backend fields
    OrderCustomer? customer,
    OrderShipping? shipping,
    OrderPayment? payment,
    @JsonKey(name: 'status_history') List<OrderStatusHistory>? statusHistory,
    @JsonKey(name: 'email_flags') OrderEmailFlags? emailFlags,
    @JsonKey(name: 'is_deleted') @Default(false) bool isDeleted,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

// JSON conversion helpers for OrderStatus
OrderStatus _statusFromJson(String? status) =>
    OrderStatus.fromString(status ?? 'preparing');
String _statusToJson(OrderStatus status) => status.backendValue;

// Order Create Request Model
@freezed
class OrderCreateRequest with _$OrderCreateRequest {
  const factory OrderCreateRequest({
    required List<OrderCreateItem> items,
    String? note,
  }) = _OrderCreateRequest;

  factory OrderCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderCreateRequestFromJson(json);
}

// Order Create Item Model
@freezed
class OrderCreateItem with _$OrderCreateItem {
  const factory OrderCreateItem({
    @JsonKey(name: 'product_id') required String productId,
    required String name,
    required int quantity,
    required double price,
  }) = _OrderCreateItem;

  factory OrderCreateItem.fromJson(Map<String, dynamic> json) =>
      _$OrderCreateItemFromJson(json);
}

// Orders List Response Model - Updated for backend integration
@freezed
class OrdersListResponse with _$OrdersListResponse {
  const factory OrdersListResponse({
    required List<Order> items,
    @JsonKey(name: 'next_cursor') String? nextCursor,
    required int count,
  }) = _OrdersListResponse;

  factory OrdersListResponse.fromJson(Map<String, dynamic> json) =>
      _$OrdersListResponseFromJson(json);
}

// Admin Orders Queue Response Model
@freezed
class AdminOrdersQueueResponse with _$AdminOrdersQueueResponse {
  const factory AdminOrdersQueueResponse({
    required List<Order> preparing,
    required List<Order> shipped,
    required AdminOrdersCount count,
  }) = _AdminOrdersQueueResponse;

  factory AdminOrdersQueueResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminOrdersQueueResponseFromJson(json);
}

// Admin Orders Count Model
@freezed
class AdminOrdersCount with _$AdminOrdersCount {
  const factory AdminOrdersCount({
    required int preparing,
    required int shipped,
  }) = _AdminOrdersCount;

  factory AdminOrdersCount.fromJson(Map<String, dynamic> json) =>
      _$AdminOrdersCountFromJson(json);
}

// Order Ship Request Model
@freezed
class OrderShipRequest with _$OrderShipRequest {
  const factory OrderShipRequest({
    @JsonKey(name: 'tracking_number') String? trackingNumber,
    @Default('MANUAL') String provider,
  }) = _OrderShipRequest;

  factory OrderShipRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderShipRequestFromJson(json);
}

// Order Cancel Request Model
@freezed
class OrderCancelRequest with _$OrderCancelRequest {
  const factory OrderCancelRequest({
    required String reason,
  }) = _OrderCancelRequest;

  factory OrderCancelRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderCancelRequestFromJson(json);
}
