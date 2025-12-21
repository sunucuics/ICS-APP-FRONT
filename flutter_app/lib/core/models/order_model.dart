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

// Order Item Model - Updated for backend integration
@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    @JsonKey(name: 'product_id') required String productId,
    required String name,
    @JsonKey(name: 'qty', fromJson: _qtyFromJson) required int qty,
    double? price, // Fallback price
    @JsonKey(name: 'final_price') double? finalPrice, // Priority price
    @JsonKey(name: 'image_url') String? imageUrl,
    @Default({}) Map<String, dynamic> options,
    Map<String, dynamic>? product,
    // Legacy fields for backward compatibility
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'quantity') int? quantity, // Deprecated, use qty
    @JsonKey(name: 'unit_price') double? unitPrice,
    double? total,
    @JsonKey(name: 'line_total') double? lineTotal,
    String? currency,
    String? sku,
    @JsonKey(name: 'variant_id') String? variantId,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}

// Helper function to handle both qty and quantity fields
int _qtyFromJson(dynamic json) {
  if (json is int) return json;
  if (json is num) return json.toInt();
  return 0;
}

// Totals Model - Updated for backend integration
@freezed
class OrderTotals with _$OrderTotals {
  const factory OrderTotals({
    @JsonKey(name: 'grand_total') required double grandTotal,
    @Default('TRY') String currency,
    double? subtotal, // Backend internal calculation
    @JsonKey(name: 'item_count') int? itemCount,
    double? discount,
    double? shipping,
    double? tax,
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

// Status Event Meta Model
@freezed
class StatusEventMeta with _$StatusEventMeta {
  const factory StatusEventMeta({
    @JsonKey(name: 'tracking_number') String? trackingNumber,
    String? reason,
  }) = _StatusEventMeta;

  factory StatusEventMeta.fromJson(Map<String, dynamic> json) =>
      _$StatusEventMetaFromJson(json);
}

// Status Event Model - Updated for backend integration
@freezed
class StatusEvent with _$StatusEvent {
  const factory StatusEvent({
    required String status,
    required DateTime at,
    String? by, // Optional user_id or admin id
    StatusEventMeta? meta,
  }) = _StatusEvent;

  factory StatusEvent.fromJson(Map<String, dynamic> json) =>
      _$StatusEventFromJson(json);
}

// Shipping Info Model - Updated for backend integration (renamed from OrderShipment)
@freezed
class ShippingInfo with _$ShippingInfo {
  const factory ShippingInfo({
    String? provider,
    @JsonKey(name: 'tracking_number') String? trackingNumber,
    @JsonKey(name: 'tracking_url') String? trackingUrl,
    @JsonKey(name: 'shipped_at') DateTime? shippedAt,
    @JsonKey(name: 'delivered_at') DateTime? deliveredAt,
    // Legacy fields
    String? status,
    bool? simulated,
    String? log,
  }) = _ShippingInfo;

  factory ShippingInfo.fromJson(Map<String, dynamic> json) =>
      _$ShippingInfoFromJson(json);
}

// Legacy OrderShipment for backward compatibility
@Deprecated('Use ShippingInfo instead')
typedef OrderShipment = ShippingInfo;

// Legacy Status History Model for backward compatibility
@Deprecated('Use StatusEvent instead')
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

// Customer Address Model - Updated for backend integration
@freezed
class CustomerAddress with _$CustomerAddress {
  const factory CustomerAddress({
    String? line1,
    String? city,
    @JsonKey(name: 'postal_code') String? postalCode,
    String? country,
  }) = _CustomerAddress;

  factory CustomerAddress.fromJson(Map<String, dynamic> json) =>
      _$CustomerAddressFromJson(json);
}

// Customer Info Model - Updated for backend integration
@freezed
class CustomerInfo with _$CustomerInfo {
  const factory CustomerInfo({
    @JsonKey(name: 'full_name') String? fullName,
    String? email,
    String? phone,
    CustomerAddress? address,
  }) = _CustomerInfo;

  factory CustomerInfo.fromJson(Map<String, dynamic> json) =>
      _$CustomerInfoFromJson(json);
}

// Legacy OrderCustomer for backward compatibility
@Deprecated('Use CustomerInfo instead')
@freezed
class OrderCustomer with _$OrderCustomer {
  const factory OrderCustomer({
    @JsonKey(name: 'full_name') required String fullName,
    required String email,
    required String phone,
    @JsonKey(fromJson: OrderAddress.fromJson, toJson: _orderAddressToJson)
    required OrderAddress address,
  }) = _OrderCustomer;

  factory OrderCustomer.fromJson(Map<String, dynamic> json) =>
      _$OrderCustomerFromJson(json);
}

// Helper function for OrderAddress toJson
Map<String, dynamic> _orderAddressToJson(OrderAddress address) => address.toJson();

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
      return OrderAddress(
        line1: json['line1'] as String? ?? '',
        city: json['city'] as String? ?? '',
        postalCode: json['postal_code'] as String? ?? '',
        country: json['country'] as String? ?? 'TR',
      );
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

    return OrderAddress(
      line1: line1,
      city: city,
      postalCode: postalCode,
      country: country,
    );
  }
}

// Extension to add toJson method for OrderAddress
extension OrderAddressToJson on OrderAddress {
  Map<String, dynamic> toJson() {
    return {
      'line1': line1,
      'city': city,
      'postal_code': postalCode,
      'country': country,
    };
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
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'created_at', fromJson: _dateTimeFromJson) required DateTime createdAt,
    @JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson) required DateTime updatedAt,
    @JsonKey(name: 'is_deleted') @Default(false) bool isDeleted,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    required OrderStatus status,
    @JsonKey(name: 'status_history', fromJson: _statusHistoryFromJson) List<StatusEvent>? statusHistory,
    @JsonKey(fromJson: _customerInfoFromJson) required CustomerInfo customer,
    @JsonKey(fromJson: _shippingInfoFromJson) required ShippingInfo shipping,
    required List<OrderItem> items,
    @JsonKey(fromJson: _totalsFromJson) required OrderTotals totals,
    String? note,
    @JsonKey(name: 'payment') Map<String, dynamic>? payment,
    // Legacy fields for backward compatibility
    @JsonKey(name: 'tracking_number') String? trackingNumber,
    @JsonKey(name: 'shipping_provider') String? shippingProvider,
    @JsonKey(name: 'integration_code') String? integrationCode,
    @JsonKey(fromJson: _addressFromJson, toJson: _addressToJson) Address? address,
    @JsonKey(name: 'shipment') ShippingInfo? shipment,
    @JsonKey(name: 'customer_name') String? customerName,
    @JsonKey(name: 'customer_phone') String? customerPhone,
    @JsonKey(name: 'customer_email') String? customerEmail,
    @JsonKey(name: 'email_flags') OrderEmailFlags? emailFlags,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderFromJson(json);
}

// Helper functions for Order.fromJson
DateTime _dateTimeFromJson(dynamic json) {
  if (json == null) return DateTime.now();
  if (json is String) return DateTime.parse(json);
  if (json is DateTime) return json;
  return DateTime.now();
}

CustomerInfo _customerInfoFromJson(dynamic json) {
  if (json == null) return const CustomerInfo();
  if (json is Map<String, dynamic>) {
    return CustomerInfo.fromJson(json);
  }
  return const CustomerInfo();
}

ShippingInfo _shippingInfoFromJson(dynamic json) {
  if (json == null) return const ShippingInfo();
  if (json is Map<String, dynamic>) {
    return ShippingInfo.fromJson(json);
  }
  return const ShippingInfo();
}

OrderTotals _totalsFromJson(dynamic json) {
  if (json == null) return const OrderTotals(grandTotal: 0.0);
  if (json is Map<String, dynamic>) {
    return OrderTotals.fromJson(json);
  }
  return const OrderTotals(grandTotal: 0.0);
}

List<StatusEvent>? _statusHistoryFromJson(dynamic json) {
  if (json == null) return null;
  if (json is! List) return null;
  
  return json.map((item) {
    if (item is Map<String, dynamic>) {
      // Check if it's new format (StatusEvent with meta) or legacy
      if (item.containsKey('meta')) {
        return StatusEvent.fromJson(item);
      } else {
        // Legacy format - convert to StatusEvent
        return StatusEvent(
          status: item['status'] as String? ?? '',
          at: item['at'] is String 
              ? DateTime.parse(item['at'] as String)
              : (item['at'] as DateTime? ?? DateTime.now()),
          by: item['by'] as String?,
        );
      }
    }
    return StatusEvent(
      status: '',
      at: DateTime.now(),
    );
  }).toList();
}

// Helper functions for Address serialization
Address? _addressFromJson(dynamic json) {
  if (json == null) return null;
  if (json is Map<String, dynamic>) {
    return Address.fromJson(json);
  }
  return null;
}

Map<String, dynamic>? _addressToJson(Address? address) {
  if (address == null) return null;
  return address.toJson();
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
    required List<Order> delivered,
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
    required int delivered,
  }) = _AdminOrdersCount;

  factory AdminOrdersCount.fromJson(Map<String, dynamic> json) =>
      _$AdminOrdersCountFromJson(json);
}

// Order Ship Request Model - Updated for backend integration
@freezed
class OrderShipRequest with _$OrderShipRequest {
  const factory OrderShipRequest({
    @JsonKey(name: 'tracking_number') required String trackingNumber, // Required according to backend docs
    @Default('MANUAL') String provider,
    @JsonKey(name: 'tracking_url') String? trackingUrl, // Optional
  }) = _OrderShipRequest;

  factory OrderShipRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderShipRequestFromJson(json);
}

// Order Cancel Request Model - Updated for backend integration
@freezed
class OrderCancelRequest with _$OrderCancelRequest {
  const factory OrderCancelRequest({
    String? reason, // Optional according to backend docs
  }) = _OrderCancelRequest;

  factory OrderCancelRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderCancelRequestFromJson(json);
}
