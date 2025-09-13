import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

// Order Status Enum
@freezed
class OrderStatus with _$OrderStatus {
  const factory OrderStatus.hazirlaniyor() = _Hazirlaniyor;
  const factory OrderStatus.siparisAlindi() = _SiparisAlindi;
  const factory OrderStatus.kargoyaVerildi() = _KargoyaVerildi;
  const factory OrderStatus.yolda() = _Yolda;
  const factory OrderStatus.dagitimda() = _Dagitimda;
  const factory OrderStatus.teslimEdildi() = _TeslimEdildi;
  const factory OrderStatus.iptal() = _Iptal;
  const factory OrderStatus.iade() = _Iade;

  const OrderStatus._();

  factory OrderStatus.fromString(String status) {
    switch (status) {
      case 'Hazırlanıyor':
        return const OrderStatus.hazirlaniyor();
      case 'Sipariş Alındı':
        return const OrderStatus.siparisAlindi();
      case 'Kargoya Verildi':
        return const OrderStatus.kargoyaVerildi();
      case 'Yolda':
        return const OrderStatus.yolda();
      case 'Dağıtımda':
        return const OrderStatus.dagitimda();
      case 'Teslim Edildi':
        return const OrderStatus.teslimEdildi();
      case 'İptal':
        return const OrderStatus.iptal();
      case 'İade':
        return const OrderStatus.iade();
      default:
        return const OrderStatus.hazirlaniyor();
    }
  }

  String get displayName {
    return when(
      hazirlaniyor: () => 'Hazırlanıyor',
      siparisAlindi: () => 'Sipariş Alındı',
      kargoyaVerildi: () => 'Kargoya Verildi',
      yolda: () => 'Yolda',
      dagitimda: () => 'Dağıtımda',
      teslimEdildi: () => 'Teslim Edildi',
      iptal: () => 'İptal',
      iade: () => 'İade',
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
    required String productId,
    required String name,
    @JsonKey(name: 'title') String? title,
    required int quantity,
    required double price,
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
    @JsonKey(name: 'item_count') required int itemCount,
    required double subtotal,
    required double discount,
    required double shipping,
    required double tax,
    @JsonKey(name: 'grand_total') required double grandTotal,
    required String currency,
  }) = _OrderTotals;

  factory OrderTotals.fromJson(Map<String, dynamic> json) =>
      _$OrderTotalsFromJson(json);
}

// Shipment Model
@freezed
class OrderShipment with _$OrderShipment {
  const factory OrderShipment({
    String? provider,
    @JsonKey(name: 'tracking_number') String? trackingNumber,
    String? status,
    bool? simulated,
    String? log,
  }) = _OrderShipment;

  factory OrderShipment.fromJson(Map<String, dynamic> json) =>
      _$OrderShipmentFromJson(json);
}

// Main Order Model
@freezed
class Order with _$Order {
  const factory Order({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    required OrderStatus status,
    @JsonKey(name: 'tracking_number') String? trackingNumber,
    @JsonKey(name: 'shipping_provider') String? shippingProvider,
    @JsonKey(name: 'integration_code') String? integrationCode,
    required Address address,
    required List<OrderItem> items,
    OrderTotals? totals,
    OrderShipment? shipment,
    String? note,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

// JSON conversion helpers for OrderStatus
OrderStatus _statusFromJson(String status) => OrderStatus.fromString(status);
String _statusToJson(OrderStatus status) => status.displayName;

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

// Orders List Response Model
@freezed
class OrdersListResponse with _$OrdersListResponse {
  const factory OrdersListResponse({
    required List<Order> active,
    required List<Order> past,
  }) = _OrdersListResponse;

  factory OrdersListResponse.fromJson(Map<String, dynamic> json) =>
      _$OrdersListResponseFromJson(json);
}
