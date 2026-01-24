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
      productId: json['product_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      qty: _qtyFromJson(_qtyReadValue(json, 'qty')),
      price: (json['price'] as num?)?.toDouble(),
      finalPrice: (json['final_price'] as num?)?.toDouble(),
      imageUrl: json['image_url'] as String?,
      options: json['options'] as Map<String, dynamic>? ?? const {},
      product: json['product'] as Map<String, dynamic>?,
      title: json['title'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      unitPrice: (json['unit_price'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      lineTotal: (json['line_total'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      sku: json['sku'] as String?,
      variantId: json['variant_id'] as String?,
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'name': instance.name,
      'qty': instance.qty,
      'price': instance.price,
      'final_price': instance.finalPrice,
      'image_url': instance.imageUrl,
      'options': instance.options,
      'product': instance.product,
      'title': instance.title,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'total': instance.total,
      'line_total': instance.lineTotal,
      'currency': instance.currency,
      'sku': instance.sku,
      'variant_id': instance.variantId,
    };

_$OrderTotalsImpl _$$OrderTotalsImplFromJson(Map<String, dynamic> json) =>
    _$OrderTotalsImpl(
      grandTotal: (json['grand_total'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? 'TRY',
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      itemCount: (json['item_count'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toDouble(),
      shipping: (json['shipping'] as num?)?.toDouble(),
      tax: (json['tax'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$OrderTotalsImplToJson(_$OrderTotalsImpl instance) =>
    <String, dynamic>{
      'grand_total': instance.grandTotal,
      'currency': instance.currency,
      'subtotal': instance.subtotal,
      'item_count': instance.itemCount,
      'discount': instance.discount,
      'shipping': instance.shipping,
      'tax': instance.tax,
    };

_$OrderPaymentImpl _$$OrderPaymentImplFromJson(Map<String, dynamic> json) =>
    _$OrderPaymentImpl(
      provider: json['provider'] as String? ?? 'UNKNOWN',
      status: json['status'] as String? ?? 'unknown',
      merchantOid: json['merchant_oid'] as String?,
      receivedTotal: (json['received_total'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
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
      'merchant_oid': instance.merchantOid,
      'received_total': instance.receivedTotal,
      'currency': instance.currency,
      'payment_type': instance.paymentType,
      'reported_at': instance.reportedAt?.toIso8601String(),
      'paytr': instance.paytr,
    };

_$StatusEventMetaImpl _$$StatusEventMetaImplFromJson(
        Map<String, dynamic> json) =>
    _$StatusEventMetaImpl(
      trackingNumber: json['tracking_number'] as String?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$StatusEventMetaImplToJson(
        _$StatusEventMetaImpl instance) =>
    <String, dynamic>{
      'tracking_number': instance.trackingNumber,
      'reason': instance.reason,
    };

_$StatusEventImpl _$$StatusEventImplFromJson(Map<String, dynamic> json) =>
    _$StatusEventImpl(
      status: json['status'] as String? ?? '',
      at: _dateTimeFromJson(json['at']),
      by: json['by'] as String?,
      meta: json['meta'] == null
          ? null
          : StatusEventMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StatusEventImplToJson(_$StatusEventImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'at': instance.at.toIso8601String(),
      'by': instance.by,
      'meta': instance.meta,
    };

_$ShippingInfoImpl _$$ShippingInfoImplFromJson(Map<String, dynamic> json) =>
    _$ShippingInfoImpl(
      provider: json['provider'] as String?,
      trackingNumber: json['tracking_number'] as String?,
      trackingUrl: json['tracking_url'] as String?,
      shippedAt: json['shipped_at'] == null
          ? null
          : DateTime.parse(json['shipped_at'] as String),
      deliveredAt: json['delivered_at'] == null
          ? null
          : DateTime.parse(json['delivered_at'] as String),
      shippingAddress: json['address'] as String?,
      status: json['status'] as String?,
      simulated: json['simulated'] as bool?,
      log: json['log'] as String?,
    );

Map<String, dynamic> _$$ShippingInfoImplToJson(_$ShippingInfoImpl instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'tracking_number': instance.trackingNumber,
      'tracking_url': instance.trackingUrl,
      'shipped_at': instance.shippedAt?.toIso8601String(),
      'delivered_at': instance.deliveredAt?.toIso8601String(),
      'address': instance.shippingAddress,
      'status': instance.status,
      'simulated': instance.simulated,
      'log': instance.log,
    };

_$OrderStatusHistoryImpl _$$OrderStatusHistoryImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderStatusHistoryImpl(
      status: json['status'] as String? ?? '',
      at: _dateTimeFromJson(json['at']),
      by: json['by'] as String,
    );

Map<String, dynamic> _$$OrderStatusHistoryImplToJson(
        _$OrderStatusHistoryImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'at': instance.at.toIso8601String(),
      'by': instance.by,
    };

_$CustomerAddressImpl _$$CustomerAddressImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomerAddressImpl(
      line1: _readLine1(json, 'line1') as String?,
      city: json['city'] as String?,
      postalCode: json['postal_code'] as String?,
      country: json['country'] as String?,
      fullAddress: json['full_address'] as String?,
      ip: json['ip'] as String?,
    );

Map<String, dynamic> _$$CustomerAddressImplToJson(
        _$CustomerAddressImpl instance) =>
    <String, dynamic>{
      'line1': instance.line1,
      'city': instance.city,
      'postal_code': instance.postalCode,
      'country': instance.country,
      'full_address': instance.fullAddress,
      'ip': instance.ip,
    };

_$CustomerInfoImpl _$$CustomerInfoImplFromJson(Map<String, dynamic> json) =>
    _$CustomerInfoImpl(
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] == null
          ? null
          : CustomerAddress.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CustomerInfoImplToJson(_$CustomerInfoImpl instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
    };

_$OrderCustomerImpl _$$OrderCustomerImplFromJson(Map<String, dynamic> json) =>
    _$OrderCustomerImpl(
      fullName: json['full_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      address: OrderAddress.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OrderCustomerImplToJson(_$OrderCustomerImpl instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'address': _orderAddressToJson(instance.address),
    };

_$OrderShippingImpl _$$OrderShippingImplFromJson(Map<String, dynamic> json) =>
    _$OrderShippingImpl(
      provider: json['provider'] as String? ?? 'MANUAL',
      shippingAddress: json['address'] as String?,
    );

Map<String, dynamic> _$$OrderShippingImplToJson(_$OrderShippingImpl instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'address': instance.shippingAddress,
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
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      createdAt: _dateTimeFromJson(json['created_at']),
      updatedAt: _dateTimeFromJson(json['updated_at']),
      isDeleted: json['is_deleted'] as bool? ?? false,
      status: _statusFromJson(json['status'] as String?),
      statusHistory: _statusHistoryFromJson(json['status_history']),
      customer: _customerInfoFromJson(json['customer']),
      shipping: _shippingInfoFromJson(json['shipping']),
      shippingInfo: json['shipping_info'] == null
          ? null
          : ShippingInfo.fromJson(
              json['shipping_info'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totals: _totalsFromJson(json['totals']),
      note: json['note'] as String?,
      payment: json['payment'] == null
          ? null
          : OrderPayment.fromJson(json['payment'] as Map<String, dynamic>),
      trackingNumber: json['tracking_number'] as String?,
      shippingProvider: json['shipping_provider'] as String?,
      integrationCode: json['integration_code'] as String?,
      address: _addressFromJson(json['address']),
      shipment: json['shipment'] == null
          ? null
          : ShippingInfo.fromJson(json['shipment'] as Map<String, dynamic>),
      customerName: json['customer_name'] as String?,
      customerPhone: json['customer_phone'] as String?,
      customerEmail: json['customer_email'] as String?,
      emailFlags: json['email_flags'] == null
          ? null
          : OrderEmailFlags.fromJson(
              json['email_flags'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'is_deleted': instance.isDeleted,
      'status': _statusToJson(instance.status),
      'status_history': instance.statusHistory,
      'customer': instance.customer,
      'shipping': instance.shipping,
      'shipping_info': instance.shippingInfo,
      'items': instance.items,
      'totals': instance.totals,
      'note': instance.note,
      'payment': instance.payment,
      'tracking_number': instance.trackingNumber,
      'shipping_provider': instance.shippingProvider,
      'integration_code': instance.integrationCode,
      'address': _addressToJson(instance.address),
      'shipment': instance.shipment,
      'customer_name': instance.customerName,
      'customer_phone': instance.customerPhone,
      'customer_email': instance.customerEmail,
      'email_flags': instance.emailFlags,
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
      productId: json['product_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
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
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      nextCursor: json['next_cursor'] as String?,
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$OrdersListResponseImplToJson(
        _$OrdersListResponseImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'next_cursor': instance.nextCursor,
      'count': instance.count,
    };

_$OrderShipRequestImpl _$$OrderShipRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderShipRequestImpl(
      trackingNumber: json['tracking_number'] as String,
      provider: json['provider'] as String? ?? 'MANUAL',
      trackingUrl: json['tracking_url'] as String?,
    );

Map<String, dynamic> _$$OrderShipRequestImplToJson(
        _$OrderShipRequestImpl instance) =>
    <String, dynamic>{
      'tracking_number': instance.trackingNumber,
      'provider': instance.provider,
      'tracking_url': instance.trackingUrl,
    };

_$OrderCancelRequestImpl _$$OrderCancelRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderCancelRequestImpl(
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$OrderCancelRequestImplToJson(
        _$OrderCancelRequestImpl instance) =>
    <String, dynamic>{
      'reason': instance.reason,
    };
