// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      label: json['label'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      neighborhood: json['neighborhood'] as String?,
      street: json['street'] as String?,
      buildingNo: json['buildingNo'] as String?,
      apartment: json['apartment'] as String?,
      floor: json['floor'] as String?,
      zipCode: json['zipCode'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'label': instance.label,
      'city': instance.city,
      'district': instance.district,
      'neighborhood': instance.neighborhood,
      'street': instance.street,
      'buildingNo': instance.buildingNo,
      'apartment': instance.apartment,
      'floor': instance.floor,
      'zipCode': instance.zipCode,
      'note': instance.note,
    };

_$OrderItemImpl _$$OrderItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemImpl(
      productId: json['product_id'] as String?,
      name: json['name'] as String,
      title: json['title'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      unitPrice: (json['unit_price'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      lineTotal: (json['line_total'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      sku: json['sku'] as String?,
      variantId: json['variant_id'] as String?,
      imageUrl: json['image_url'] as String?,
      options: json['options'] as Map<String, dynamic>? ?? const {},
      product: json['product'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'name': instance.name,
      'title': instance.title,
      'quantity': instance.quantity,
      'price': instance.price,
      'unit_price': instance.unitPrice,
      'total': instance.total,
      'line_total': instance.lineTotal,
      'currency': instance.currency,
      'sku': instance.sku,
      'variant_id': instance.variantId,
      'image_url': instance.imageUrl,
      'options': instance.options,
      'product': instance.product,
    };

_$OrderTotalsImpl _$$OrderTotalsImplFromJson(Map<String, dynamic> json) =>
    _$OrderTotalsImpl(
      itemCount: (json['item_count'] as num).toInt(),
      subtotal: (json['subtotal'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      shipping: (json['shipping'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      grandTotal: (json['grand_total'] as num).toDouble(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$$OrderTotalsImplToJson(_$OrderTotalsImpl instance) =>
    <String, dynamic>{
      'item_count': instance.itemCount,
      'subtotal': instance.subtotal,
      'discount': instance.discount,
      'shipping': instance.shipping,
      'tax': instance.tax,
      'grand_total': instance.grandTotal,
      'currency': instance.currency,
    };

_$OrderShipmentImpl _$$OrderShipmentImplFromJson(Map<String, dynamic> json) =>
    _$OrderShipmentImpl(
      provider: json['provider'] as String?,
      trackingNumber: json['tracking_number'] as String?,
      status: json['status'] as String?,
      simulated: json['simulated'] as bool?,
      log: json['log'] as String?,
    );

Map<String, dynamic> _$$OrderShipmentImplToJson(_$OrderShipmentImpl instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'tracking_number': instance.trackingNumber,
      'status': instance.status,
      'simulated': instance.simulated,
      'log': instance.log,
    };

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      status: _statusFromJson(json['status'] as String),
      trackingNumber: json['tracking_number'] as String?,
      shippingProvider: json['shipping_provider'] as String?,
      integrationCode: json['integration_code'] as String?,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totals: json['totals'] == null
          ? null
          : OrderTotals.fromJson(json['totals'] as Map<String, dynamic>),
      shipment: json['shipment'] == null
          ? null
          : OrderShipment.fromJson(json['shipment'] as Map<String, dynamic>),
      note: json['note'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'status': _statusToJson(instance.status),
      'tracking_number': instance.trackingNumber,
      'shipping_provider': instance.shippingProvider,
      'integration_code': instance.integrationCode,
      'address': instance.address,
      'items': instance.items,
      'totals': instance.totals,
      'shipment': instance.shipment,
      'note': instance.note,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

_$OrderCreateRequestImpl _$$OrderCreateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderCreateRequestImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderCreateItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$OrderCreateRequestImplToJson(
        _$OrderCreateRequestImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'note': instance.note,
    };

_$OrderCreateItemImpl _$$OrderCreateItemImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderCreateItemImpl(
      productId: json['product_id'] as String,
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$$OrderCreateItemImplToJson(
        _$OrderCreateItemImpl instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'name': instance.name,
      'quantity': instance.quantity,
      'price': instance.price,
    };

_$OrdersListResponseImpl _$$OrdersListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$OrdersListResponseImpl(
      active: (json['active'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
      past: (json['past'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$OrdersListResponseImplToJson(
        _$OrdersListResponseImpl instance) =>
    <String, dynamic>{
      'active': instance.active,
      'past': instance.past,
    };
