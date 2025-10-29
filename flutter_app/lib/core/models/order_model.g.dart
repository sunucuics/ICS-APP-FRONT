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
      name: json['name'] as String?,
      title: json['title'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
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
      itemCount: (json['item_count'] as num?)?.toInt(),
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      shipping: (json['shipping'] as num?)?.toDouble(),
      tax: (json['tax'] as num?)?.toDouble(),
      grandTotal: (json['grand_total'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
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

_$OrderPaymentImpl _$$OrderPaymentImplFromJson(Map<String, dynamic> json) =>
    _$OrderPaymentImpl(
      provider: json['provider'] as String,
      status: json['status'] as String,
      receivedTotal: (json['received_total'] as num?)?.toDouble(),
      currency: json['currency'] as String,
      paymentType: json['payment_type'] as String?,
      reportedAt: json['reported_at'] == null
          ? null
          : DateTime.parse(json['reported_at'] as String),
      paytr: json['paytr'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$OrderPaymentImplToJson(_$OrderPaymentImpl instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'status': instance.status,
      'received_total': instance.receivedTotal,
      'currency': instance.currency,
      'payment_type': instance.paymentType,
      'reported_at': instance.reportedAt?.toIso8601String(),
      'paytr': instance.paytr,
    };

_$OrderShipmentImpl _$$OrderShipmentImplFromJson(Map<String, dynamic> json) =>
    _$OrderShipmentImpl(
      provider: json['provider'] as String?,
      trackingNumber: json['tracking_number'] as String?,
      status: json['status'] as String?,
      shippedAt: json['shipped_at'] == null
          ? null
          : DateTime.parse(json['shipped_at'] as String),
      deliveredAt: json['delivered_at'] == null
          ? null
          : DateTime.parse(json['delivered_at'] as String),
      simulated: json['simulated'] as bool?,
      log: json['log'] as String?,
    );

Map<String, dynamic> _$$OrderShipmentImplToJson(_$OrderShipmentImpl instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'tracking_number': instance.trackingNumber,
      'status': instance.status,
      'shipped_at': instance.shippedAt?.toIso8601String(),
      'delivered_at': instance.deliveredAt?.toIso8601String(),
      'simulated': instance.simulated,
      'log': instance.log,
    };

_$OrderStatusHistoryImpl _$$OrderStatusHistoryImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderStatusHistoryImpl(
      status: json['status'] as String,
      at: DateTime.parse(json['at'] as String),
      by: json['by'] as String,
    );

Map<String, dynamic> _$$OrderStatusHistoryImplToJson(
        _$OrderStatusHistoryImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'at': instance.at.toIso8601String(),
      'by': instance.by,
    };

_$OrderCustomerImpl _$$OrderCustomerImplFromJson(Map<String, dynamic> json) =>
    _$OrderCustomerImpl(
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: OrderAddress.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OrderCustomerImplToJson(_$OrderCustomerImpl instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
    };

_$OrderAddressImpl _$$OrderAddressImplFromJson(Map<String, dynamic> json) =>
    _$OrderAddressImpl(
      line1: json['line1'] as String,
      city: json['city'] as String,
      postalCode: json['postal_code'] as String,
      country: json['country'] as String? ?? 'TR',
    );

Map<String, dynamic> _$$OrderAddressImplToJson(_$OrderAddressImpl instance) =>
    <String, dynamic>{
      'line1': instance.line1,
      'city': instance.city,
      'postal_code': instance.postalCode,
      'country': instance.country,
    };

_$OrderShippingImpl _$$OrderShippingImplFromJson(Map<String, dynamic> json) =>
    _$OrderShippingImpl(
      provider: json['provider'] as String,
    );

Map<String, dynamic> _$$OrderShippingImplToJson(_$OrderShippingImpl instance) =>
    <String, dynamic>{
      'provider': instance.provider,
    };

_$OrderEmailFlagsImpl _$$OrderEmailFlagsImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderEmailFlagsImpl(
      shippedSent: json['shipped_sent'] as bool? ?? false,
      deliveredSent: json['delivered_sent'] as bool? ?? false,
      canceledSent: json['canceled_sent'] as bool? ?? false,
    );

Map<String, dynamic> _$$OrderEmailFlagsImplToJson(
        _$OrderEmailFlagsImpl instance) =>
    <String, dynamic>{
      'shipped_sent': instance.shippedSent,
      'delivered_sent': instance.deliveredSent,
      'canceled_sent': instance.canceledSent,
    };

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      status: _statusFromJson(json['status'] as String?),
      trackingNumber: json['tracking_number'] as String?,
      shippingProvider: json['shipping_provider'] as String?,
      integrationCode: json['integration_code'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
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
      customerName: json['customer_name'] as String?,
      customerPhone: json['customer_phone'] as String?,
      customerEmail: json['customer_email'] as String?,
      customer: json['customer'] == null
          ? null
          : OrderCustomer.fromJson(json['customer'] as Map<String, dynamic>),
      shipping: json['shipping'] == null
          ? null
          : OrderShipping.fromJson(json['shipping'] as Map<String, dynamic>),
      payment: json['payment'] == null
          ? null
          : OrderPayment.fromJson(json['payment'] as Map<String, dynamic>),
      statusHistory: (json['status_history'] as List<dynamic>?)
          ?.map((e) => OrderStatusHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
      emailFlags: json['email_flags'] == null
          ? null
          : OrderEmailFlags.fromJson(
              json['email_flags'] as Map<String, dynamic>),
      isDeleted: json['is_deleted'] as bool? ?? false,
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
      'customer_name': instance.customerName,
      'customer_phone': instance.customerPhone,
      'customer_email': instance.customerEmail,
      'customer': instance.customer,
      'shipping': instance.shipping,
      'payment': instance.payment,
      'status_history': instance.statusHistory,
      'email_flags': instance.emailFlags,
      'is_deleted': instance.isDeleted,
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
      items: (json['items'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextCursor: json['next_cursor'] as String?,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$$OrdersListResponseImplToJson(
        _$OrdersListResponseImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'next_cursor': instance.nextCursor,
      'count': instance.count,
    };

_$AdminOrdersQueueResponseImpl _$$AdminOrdersQueueResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AdminOrdersQueueResponseImpl(
      preparing: (json['preparing'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
      shipped: (json['shipped'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: AdminOrdersCount.fromJson(json['count'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AdminOrdersQueueResponseImplToJson(
        _$AdminOrdersQueueResponseImpl instance) =>
    <String, dynamic>{
      'preparing': instance.preparing,
      'shipped': instance.shipped,
      'count': instance.count,
    };

_$AdminOrdersCountImpl _$$AdminOrdersCountImplFromJson(
        Map<String, dynamic> json) =>
    _$AdminOrdersCountImpl(
      preparing: (json['preparing'] as num).toInt(),
      shipped: (json['shipped'] as num).toInt(),
    );

Map<String, dynamic> _$$AdminOrdersCountImplToJson(
        _$AdminOrdersCountImpl instance) =>
    <String, dynamic>{
      'preparing': instance.preparing,
      'shipped': instance.shipped,
    };

_$OrderShipRequestImpl _$$OrderShipRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderShipRequestImpl(
      trackingNumber: json['tracking_number'] as String?,
      provider: json['provider'] as String? ?? 'MANUAL',
    );

Map<String, dynamic> _$$OrderShipRequestImplToJson(
        _$OrderShipRequestImpl instance) =>
    <String, dynamic>{
      'tracking_number': instance.trackingNumber,
      'provider': instance.provider,
    };

_$OrderCancelRequestImpl _$$OrderCancelRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderCancelRequestImpl(
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$$OrderCancelRequestImplToJson(
        _$OrderCancelRequestImpl instance) =>
    <String, dynamic>{
      'reason': instance.reason,
    };
