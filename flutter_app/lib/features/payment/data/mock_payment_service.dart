import 'dart:async';
import 'dart:math';
import '../../../core/models/payment_model.dart';

class MockPaymentService {
  static final MockPaymentService _instance = MockPaymentService._internal();
  factory MockPaymentService() => _instance;
  MockPaymentService._internal();

  // Mock payment simulation delay
  static const Duration _simulationDelay = Duration(seconds: 2);

  /// Simulate payment processing
  Future<MockPaymentResult> processPayment({
    required double amount,
    required PaymentMethod method,
    String? description,
    bool simulateSuccess = true,
  }) async {
    // Simulate network delay
    await Future.delayed(_simulationDelay);

    // Generate mock transaction ID
    final transactionId = _generateTransactionId();
    final referenceNumber = _generateReferenceNumber();

    // Simulate payment processing
    if (simulateSuccess) {
      return MockPaymentResult(
        success: true,
        message: 'Ödeme başarıyla tamamlandı',
        transactionId: transactionId,
        referenceNumber: referenceNumber,
        status: const PaymentStatus.completed(),
      );
    } else {
      // Simulate random failure scenarios
      final failureScenarios = [
        'Kart limiti yetersiz',
        'Kart bilgileri hatalı',
        'Banka bağlantı hatası',
        'Ödeme işlemi reddedildi',
        'Sistem hatası',
      ];

      final randomFailure =
          failureScenarios[Random().nextInt(failureScenarios.length)];

      return MockPaymentResult(
        success: false,
        message: randomFailure,
        transactionId: transactionId,
        referenceNumber: referenceNumber,
        status: const PaymentStatus.failed(),
        errorCode: 'PAYMENT_FAILED',
        errorMessage: randomFailure,
      );
    }
  }

  /// Simulate payment with random success/failure
  Future<MockPaymentResult> processPaymentWithRandomResult({
    required double amount,
    required PaymentMethod method,
    String? description,
    double successRate = 0.85, // 85% success rate
  }) async {
    final random = Random();
    final shouldSucceed = random.nextDouble() < successRate;

    return processPayment(
      amount: amount,
      method: method,
      description: description,
      simulateSuccess: shouldSucceed,
    );
  }

  /// Simulate payment processing with steps
  Future<Stream<PaymentStatus>> processPaymentWithSteps({
    required double amount,
    required PaymentMethod method,
    String? description,
    bool simulateSuccess = true,
  }) async {
    final controller = StreamController<PaymentStatus>();

    // Start processing
    controller.add(const PaymentStatus.pending());

    // Simulate processing delay
    await Future.delayed(const Duration(milliseconds: 500));
    controller.add(const PaymentStatus.processing());

    // Simulate main processing delay
    await Future.delayed(const Duration(seconds: 1));

    // Final result
    if (simulateSuccess) {
      controller.add(const PaymentStatus.completed());
    } else {
      controller.add(const PaymentStatus.failed());
    }

    // Close stream after a short delay
    await Future.delayed(const Duration(milliseconds: 500));
    controller.close();

    return controller.stream;
  }

  /// Generate mock transaction ID
  String _generateTransactionId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(9999).toString().padLeft(4, '0');
    return 'TXN_${timestamp}_$random';
  }

  /// Generate mock reference number
  String _generateReferenceNumber() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(999999).toString().padLeft(6, '0');
    return 'REF_${timestamp}_$random';
  }

  /// Get available payment methods
  List<PaymentMethod> getAvailablePaymentMethods() {
    return [
      const PaymentMethod.creditCard(),
      const PaymentMethod.debitCard(),
    ];
  }

  /// Validate payment amount
  bool validatePaymentAmount(double amount) {
    return amount > 0 && amount <= 100000; // Max 100,000 TL
  }

  /// Get payment method fees
  double getPaymentMethodFee(PaymentMethod method, double amount) {
    return method.when(
      creditCard: () => amount * 0.029, // 2.9% fee
      debitCard: () => amount * 0.015, // 1.5% fee
    );
  }

  /// Calculate total amount with fees
  double calculateTotalAmount(double amount, PaymentMethod method) {
    final fee = getPaymentMethodFee(method, amount);
    return amount + fee;
  }

  /// Get payment method description
  String getPaymentMethodDescription(PaymentMethod method) {
    return method.when(
      creditCard: () => 'Kredi kartı ile güvenli ödeme',
      debitCard: () => 'Banka kartı ile hızlı ödeme',
    );
  }

  /// Get payment method processing time
  Duration getPaymentMethodProcessingTime(PaymentMethod method) {
    return method.when(
      creditCard: () => const Duration(seconds: 3),
      debitCard: () => const Duration(seconds: 2),
    );
  }
}
