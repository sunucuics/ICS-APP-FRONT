// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentRequestImpl _$$PaymentRequestImplFromJson(Map<String, dynamic> json) =>
    _$PaymentRequestImpl(
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      method: _methodFromJson(json['method'] as String),
      description: json['description'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      simulate: json['simulate'] as bool? ?? true,
    );

Map<String, dynamic> _$$PaymentRequestImplToJson(
        _$PaymentRequestImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
      'method': _methodToJson(instance.method),
      'description': instance.description,
      'metadata': instance.metadata,
      'simulate': instance.simulate,
    };

_$PaymentResponseImpl _$$PaymentResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentResponseImpl(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: _statusFromJson(json['status'] as String),
      method: _methodFromJson(json['method'] as String),
      transactionId: json['transactionId'] as String?,
      referenceNumber: json['referenceNumber'] as String?,
      description: json['description'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      errorMessage: json['errorMessage'] as String?,
      errorCode: json['errorCode'] as String?,
    );

Map<String, dynamic> _$$PaymentResponseImplToJson(
        _$PaymentResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': _statusToJson(instance.status),
      'method': _methodToJson(instance.method),
      'transactionId': instance.transactionId,
      'referenceNumber': instance.referenceNumber,
      'description': instance.description,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'errorMessage': instance.errorMessage,
      'errorCode': instance.errorCode,
    };

_$MockPaymentResultImpl _$$MockPaymentResultImplFromJson(
        Map<String, dynamic> json) =>
    _$MockPaymentResultImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      transactionId: json['transactionId'] as String?,
      referenceNumber: json['referenceNumber'] as String?,
      status: _nullableStatusFromJson(json['status'] as String?),
      errorCode: json['errorCode'] as String?,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$$MockPaymentResultImplToJson(
        _$MockPaymentResultImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'transactionId': instance.transactionId,
      'referenceNumber': instance.referenceNumber,
      'status': _nullableStatusToJson(instance.status),
      'errorCode': instance.errorCode,
      'errorMessage': instance.errorMessage,
    };

_$PaymentSummaryImpl _$$PaymentSummaryImplFromJson(Map<String, dynamic> json) =>
    _$PaymentSummaryImpl(
      subtotal: (json['subtotal'] as num).toDouble(),
      shipping: (json['shipping'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      currency: json['currency'] as String,
      couponCode: json['couponCode'] as String?,
      couponDiscount: (json['couponDiscount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$PaymentSummaryImplToJson(
        _$PaymentSummaryImpl instance) =>
    <String, dynamic>{
      'subtotal': instance.subtotal,
      'shipping': instance.shipping,
      'tax': instance.tax,
      'discount': instance.discount,
      'total': instance.total,
      'currency': instance.currency,
      'couponCode': instance.couponCode,
      'couponDiscount': instance.couponDiscount,
    };

_$PaymentHistoryImpl _$$PaymentHistoryImplFromJson(Map<String, dynamic> json) =>
    _$PaymentHistoryImpl(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: _statusFromJson(json['status'] as String),
      method: _methodFromJson(json['method'] as String),
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      transactionId: json['transactionId'] as String?,
    );

Map<String, dynamic> _$$PaymentHistoryImplToJson(
        _$PaymentHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': _statusToJson(instance.status),
      'method': _methodToJson(instance.method),
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'transactionId': instance.transactionId,
    };
