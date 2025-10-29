import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

// Payment Status Enum
@freezed
class PaymentStatus with _$PaymentStatus {
  const factory PaymentStatus.pending() = _Pending;
  const factory PaymentStatus.processing() = _Processing;
  const factory PaymentStatus.completed() = _Completed;
  const factory PaymentStatus.failed() = _Failed;
  const factory PaymentStatus.cancelled() = _Cancelled;
  const factory PaymentStatus.refunded() = _Refunded;

  const PaymentStatus._();

  factory PaymentStatus.fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const PaymentStatus.pending();
      case 'processing':
        return const PaymentStatus.processing();
      case 'completed':
      case 'success':
        return const PaymentStatus.completed();
      case 'failed':
      case 'failure':
        return const PaymentStatus.failed();
      case 'cancelled':
      case 'canceled':
        return const PaymentStatus.cancelled();
      case 'refunded':
        return const PaymentStatus.refunded();
      default:
        return const PaymentStatus.pending();
    }
  }

  String get displayName {
    return when(
      pending: () => 'Beklemede',
      processing: () => 'İşleniyor',
      completed: () => 'Tamamlandı',
      failed: () => 'Başarısız',
      cancelled: () => 'İptal Edildi',
      refunded: () => 'İade Edildi',
    );
  }

  bool get isSuccess => this == const PaymentStatus.completed();
  bool get isFailure => this == const PaymentStatus.failed();
  bool get isPending =>
      this == const PaymentStatus.pending() ||
      this == const PaymentStatus.processing();
}

// Payment Method Enum
@freezed
class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod.creditCard() = _CreditCard;
  const factory PaymentMethod.debitCard() = _DebitCard;

  const PaymentMethod._();

  factory PaymentMethod.fromString(String method) {
    switch (method.toLowerCase()) {
      case 'credit_card':
      case 'creditcard':
        return const PaymentMethod.creditCard();
      case 'debit_card':
      case 'debitcard':
        return const PaymentMethod.debitCard();
      default:
        return const PaymentMethod.creditCard();
    }
  }

  String get displayName {
    return when(
      creditCard: () => 'Kredi Kartı',
      debitCard: () => 'Banka Kartı',
    );
  }

  String get icon {
    return when(
      creditCard: () => '💳',
      debitCard: () => '💳',
    );
  }
}

// Payment Request Model
@freezed
class PaymentRequest with _$PaymentRequest {
  const factory PaymentRequest({
    required double amount,
    required String currency,
    @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
    required PaymentMethod method,
    String? description,
    Map<String, dynamic>? metadata,
    @Default(true) bool simulate, // Mock payment için default true
  }) = _PaymentRequest;

  factory PaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentRequestFromJson(json);
}

// Payment Response Model
@freezed
class PaymentResponse with _$PaymentResponse {
  const factory PaymentResponse({
    required String id,
    required String orderId,
    required double amount,
    required String currency,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    required PaymentStatus status,
    @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
    required PaymentMethod method,
    String? transactionId,
    String? referenceNumber,
    String? description,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? errorMessage,
    String? errorCode,
  }) = _PaymentResponse;

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseFromJson(json);
}

// Mock Payment Result Model
@freezed
class MockPaymentResult with _$MockPaymentResult {
  const factory MockPaymentResult({
    required bool success,
    required String message,
    String? transactionId,
    String? referenceNumber,
    @JsonKey(fromJson: _nullableStatusFromJson, toJson: _nullableStatusToJson)
    PaymentStatus? status,
    String? errorCode,
    String? errorMessage,
  }) = _MockPaymentResult;

  factory MockPaymentResult.fromJson(Map<String, dynamic> json) =>
      _$MockPaymentResultFromJson(json);
}

// Payment Summary Model
@freezed
class PaymentSummary with _$PaymentSummary {
  const factory PaymentSummary({
    required double subtotal,
    required double shipping,
    required double tax,
    required double discount,
    required double total,
    required String currency,
    String? couponCode,
    double? couponDiscount,
  }) = _PaymentSummary;

  factory PaymentSummary.fromJson(Map<String, dynamic> json) =>
      _$PaymentSummaryFromJson(json);
}

// Payment History Model
@freezed
class PaymentHistory with _$PaymentHistory {
  const factory PaymentHistory({
    required String id,
    required String orderId,
    required double amount,
    required String currency,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    required PaymentStatus status,
    @JsonKey(fromJson: _methodFromJson, toJson: _methodToJson)
    required PaymentMethod method,
    String? description,
    DateTime? createdAt,
    String? transactionId,
  }) = _PaymentHistory;

  factory PaymentHistory.fromJson(Map<String, dynamic> json) =>
      _$PaymentHistoryFromJson(json);
}

// JSON conversion helpers for PaymentMethod and PaymentStatus
PaymentMethod _methodFromJson(String method) =>
    PaymentMethod.fromString(method);
String _methodToJson(PaymentMethod method) => method.displayName;

PaymentStatus _statusFromJson(String status) =>
    PaymentStatus.fromString(status);
String _statusToJson(PaymentStatus status) => status.displayName;

// Nullable versions
PaymentStatus? _nullableStatusFromJson(String? status) =>
    status != null ? PaymentStatus.fromString(status) : null;
String? _nullableStatusToJson(PaymentStatus? status) => status?.displayName;
