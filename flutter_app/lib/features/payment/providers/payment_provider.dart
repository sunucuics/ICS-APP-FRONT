import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/payment_model.dart';
import '../../../core/models/order_model.dart';
import '../../../core/models/paytr_model.dart';
import '../../../features/orders/providers/orders_provider.dart';
import '../../../features/addresses/providers/addresses_provider.dart';
import '../../../features/cart/providers/cart_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../data/mock_payment_service.dart';
import '../providers/paytr_provider.dart';

// Mock Payment Service Provider
final mockPaymentServiceProvider = Provider<MockPaymentService>((ref) {
  return MockPaymentService();
});

// Payment Method Provider
final selectedPaymentMethodProvider = StateProvider<PaymentMethod>((ref) {
  return const PaymentMethod.creditCard();
});

// Payment Status Provider
final paymentStatusProvider = StateProvider<PaymentStatus>((ref) {
  return const PaymentStatus.pending();
});

// Payment Processing Provider
class PaymentProcessingNotifier
    extends StateNotifier<AsyncValue<PaymentResponse?>> {
  final MockPaymentService _mockPaymentService;

  PaymentProcessingNotifier(this._mockPaymentService)
      : super(const AsyncValue.data(null));

  Future<PaymentResponse?> processPayment({
    required double amount,
    required PaymentMethod method,
    String? description,
    bool simulateSuccess = true,
  }) async {
    try {
      state = const AsyncValue.loading();

      final result = await _mockPaymentService.processPayment(
        amount: amount,
        method: method,
        description: description,
        simulateSuccess: simulateSuccess,
      );

      if (result.success) {
        final response = PaymentResponse(
          id: result.transactionId ??
              'mock_payment_${DateTime.now().millisecondsSinceEpoch}',
          orderId: 'mock_order_${DateTime.now().millisecondsSinceEpoch}',
          amount: amount,
          currency: 'TRY',
          status: result.status ?? const PaymentStatus.completed(),
          method: method,
          transactionId: result.transactionId,
          referenceNumber: result.referenceNumber,
          description: description,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        state = AsyncValue.data(response);
        return response;
      } else {
        final response = PaymentResponse(
          id: result.transactionId ??
              'mock_payment_${DateTime.now().millisecondsSinceEpoch}',
          orderId: 'mock_order_${DateTime.now().millisecondsSinceEpoch}',
          amount: amount,
          currency: 'TRY',
          status: result.status ?? const PaymentStatus.failed(),
          method: method,
          transactionId: result.transactionId,
          referenceNumber: result.referenceNumber,
          description: description,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          errorMessage: result.errorMessage,
          errorCode: result.errorCode,
        );

        state = AsyncValue.data(response);
        return response;
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return null;
    }
  }

  void clearState() {
    state = const AsyncValue.data(null);
  }
}

final paymentProcessingProvider = StateNotifierProvider<
    PaymentProcessingNotifier, AsyncValue<PaymentResponse?>>((ref) {
  final mockPaymentService = ref.read(mockPaymentServiceProvider);
  return PaymentProcessingNotifier(mockPaymentService);
});

// Payment Summary Provider
final paymentSummaryProvider = Provider<PaymentSummary>((ref) {
  final cartTotalAsync = ref.watch(cartTotalProvider);

  final subtotal = cartTotalAsync.when(
    data: (cartTotal) => cartTotal.totalPrice,
    loading: () => 0.0,
    error: (error, stack) => 0.0,
  );

  final shipping = 0.0; // Free shipping for now
  final tax = 0.0; // Backend already includes VAT in totalPrice
  final discount = 0.0; // No discount for now

  final total = subtotal + shipping + tax - discount;

  return PaymentSummary(
    subtotal: subtotal,
    shipping: shipping,
    tax: tax,
    discount: discount,
    total: total,
    currency: 'TRY',
  );
});

// Checkout flow
enum CheckoutStage {
  idle,
  loading,
  awaitingPayment,
  awaitingConfirmation,
  completed,
  failed,
}

class CheckoutState {
  final CheckoutStage stage;
  final Order? order;
  final PayTRDirectInitResponse? paytrInit;
  final String? checkoutId;
  final PaymentMethod? paymentMethod;
  final String? orderNote;
  final String? errorMessage;
  final PaymentStatus? paymentStatus;
  final DateTime? pollingStartedAt;
  final int pollAttempts;
  final bool pollTimedOut;

  const CheckoutState({
    required this.stage,
    this.order,
    this.paytrInit,
    this.checkoutId,
    this.paymentMethod,
    this.orderNote,
    this.errorMessage,
    this.paymentStatus,
    this.pollingStartedAt,
    this.pollAttempts = 0,
    this.pollTimedOut = false,
  });

  factory CheckoutState.initial() => const CheckoutState(
        stage: CheckoutStage.idle,
        pollAttempts: 0,
        pollTimedOut: false,
      );

  CheckoutState copyWith({
    CheckoutStage? stage,
    Order? order,
    PayTRDirectInitResponse? paytrInit,
    String? checkoutId,
    PaymentMethod? paymentMethod,
    String? orderNote,
    String? errorMessage,
    PaymentStatus? paymentStatus,
    DateTime? pollingStartedAt,
    int? pollAttempts,
    bool? pollTimedOut,
    bool clearOrder = false,
    bool clearPayTR = false,
  }) {
    return CheckoutState(
      stage: stage ?? this.stage,
      order: clearOrder ? null : (order ?? this.order),
      paytrInit: clearPayTR ? null : (paytrInit ?? this.paytrInit),
      checkoutId: checkoutId ?? this.checkoutId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      orderNote: orderNote ?? this.orderNote,
      errorMessage: errorMessage,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      pollingStartedAt: pollingStartedAt ?? this.pollingStartedAt,
      pollAttempts: pollAttempts ?? this.pollAttempts,
      pollTimedOut: pollTimedOut ?? this.pollTimedOut,
    );
  }

  bool get isLoading =>
      stage == CheckoutStage.loading ||
      stage == CheckoutStage.awaitingConfirmation;

  bool get requiresPayTR =>
      stage == CheckoutStage.awaitingPayment && paytrInit != null;
}

class CheckoutNotifier extends StateNotifier<CheckoutState> {
  final Ref _ref;
  static const Duration _pollInterval = Duration(seconds: 2);
  static const Duration _pollTimeout = Duration(seconds: 60);

  CheckoutNotifier(this._ref) : super(CheckoutState.initial());

  Future<void> startCheckout({
    required PaymentMethod paymentMethod,
    String? orderNote,
    int installmentCount = 0,
  }) async {
    state = state.copyWith(
      stage: CheckoutStage.loading,
      paymentMethod: paymentMethod,
      orderNote: orderNote,
      errorMessage: null,
      clearOrder: true,
      clearPayTR: true,
      paymentStatus: null,
      pollingStartedAt: null,
      pollAttempts: 0,
      pollTimedOut: false,
    );

    try {
      final currentAddressAsync = _ref.read(currentAddressProvider);
      final currentAddress = currentAddressAsync.when(
        data: (address) => address,
        loading: () => null,
        error: (error, stack) => null,
      );

      if (currentAddress == null) {
        throw Exception('Aktif adres bulunamadı. Lütfen bir adres ekleyin.');
      }

      final cartItems = _ref.read(cartItemsProvider);
      if (cartItems.isEmpty) {
        throw Exception('Sepetiniz boş. Lütfen ürün ekleyin.');
      }

      final orderItems = cartItems
          .map(
            (item) => OrderCreateItem(
              productId: item.productId,
              name: item.title,
              quantity: item.qty,
              price: item.finalPrice ?? item.price,
            ),
          )
          .toList();

      final authState = _ref.read(authProvider);
      final userProfile = authState.user;
      if (userProfile == null) {
        throw Exception(
            'Kullanıcı bilgileri bulunamadı. Lütfen tekrar giriş yapın.');
      }

      final isCardPayment = paymentMethod == const PaymentMethod.creditCard() ||
          paymentMethod == const PaymentMethod.debitCard();

      if (isCardPayment) {
        final order = await _ref.read(createOrderHelperProvider)(
          items: orderItems,
          note: orderNote,
          simulate: false,
          clearCartOnSuccess: false,
        );

        if (order == null || order.id == null) {
          throw Exception('Sipariş oluşturulamadı.');
        }

        final paymentStatus = _parsePaymentStatus(order.payment?.status);

        final paytrRepository = _ref.read(paytrRepositoryProvider);
        final paytrInit = await paytrRepository.getDirectInit(
          orderId: order.id!,
          cartItems: cartItems,
          userProfile: userProfile,
          currentAddress: currentAddress,
          installmentCount: installmentCount,
        );

        state = state.copyWith(
          stage: CheckoutStage.awaitingPayment,
          paytrInit: paytrInit,
          checkoutId: order.id,
          order: order,
          paymentMethod: paymentMethod,
          orderNote: orderNote,
          paymentStatus: paymentStatus,
          pollingStartedAt: null,
          pollAttempts: 0,
          pollTimedOut: false,
        );
        return;
      }

      final totalAmount = cartItems.fold<double>(
        0.0,
        (sum, item) => sum + ((item.finalPrice ?? item.price) * item.qty),
      );

      final paymentResponse =
          await _ref.read(paymentProcessingProvider.notifier).processPayment(
                amount: totalAmount,
                method: paymentMethod,
                description: 'Ödeme işlemi',
                simulateSuccess: true,
              );

      if (paymentResponse == null || !paymentResponse.status.isSuccess) {
        throw Exception(
            paymentResponse?.errorMessage ?? 'Ödeme işlemi başarısız');
      }

      final order = await _ref.read(createOrderHelperProvider)(
        items: orderItems,
        note: orderNote,
        simulate: false,
        clearCartOnSuccess: true,
      );

      if (order == null) {
        throw Exception('Sipariş oluşturulamadı.');
      }

      await _ref.read(cartProvider.notifier).refresh();
      await _ref.read(ordersProvider.notifier).refresh();

      state = state.copyWith(
        stage: CheckoutStage.completed,
        order: order,
        checkoutId: order.id,
        paymentMethod: paymentMethod,
        orderNote: orderNote,
        paymentStatus: _parsePaymentStatus(order.payment?.status),
      );
    } catch (error) {
      state = state.copyWith(
        stage: CheckoutStage.failed,
        errorMessage: error.toString(),
        clearPayTR: true,
        paymentStatus: const PaymentStatus.failed(),
      );
    }
  }

  Future<void> completePayTRPayment() async {
    final currentState = state;
    if (currentState.checkoutId == null) {
      throw Exception('Ödeme işlemi için geçersiz oturum.');
    }

    state = currentState.copyWith(
      stage: CheckoutStage.awaitingConfirmation,
      errorMessage: null,
      pollingStartedAt: DateTime.now(),
      pollAttempts: 0,
      pollTimedOut: false,
    );

    try {
      final order = await _pollForPaymentStatus(currentState.checkoutId!);

      await _ref.read(cartProvider.notifier).refresh();
      await _ref.read(ordersProvider.notifier).refresh();

      state = currentState.copyWith(
        stage: CheckoutStage.completed,
        order: order,
        paymentStatus: _parsePaymentStatus(order.payment?.status),
        clearPayTR: true,
      );
    } on TimeoutException {
      state = currentState.copyWith(
        stage: CheckoutStage.failed,
        errorMessage:
            'Ödeme doğrulanamadı. Lütfen siparişinizi kontrol edin.',
        pollTimedOut: true,
      );
    } on PaymentFailedException catch (error) {
      state = currentState.copyWith(
        stage: CheckoutStage.failed,
        errorMessage: error.message,
        paymentStatus: const PaymentStatus.failed(),
      );
    } catch (error) {
      state = currentState.copyWith(
        stage: CheckoutStage.failed,
        errorMessage: error.toString(),
        paymentStatus: const PaymentStatus.failed(),
      );
    }
  }

  void markPaymentFailed(String message) {
    state = state.copyWith(
      stage: CheckoutStage.failed,
      errorMessage: message,
      clearPayTR: true,
      paymentStatus: const PaymentStatus.failed(),
    );
  }

  void reset() {
    state = CheckoutState.initial();
  }

  PaymentStatus _parsePaymentStatus(String? rawStatus) {
    if (rawStatus == null) {
      return const PaymentStatus.pending();
    }
    switch (rawStatus.toLowerCase()) {
      case 'succeeded':
      case 'success':
      case 'completed':
        return const PaymentStatus.completed();
      case 'failed':
      case 'failure':
        return const PaymentStatus.failed();
      case 'cancelled':
      case 'canceled':
        return const PaymentStatus.cancelled();
      case 'processing':
        return const PaymentStatus.processing();
      case 'awaiting':
      case 'pending':
      default:
        return const PaymentStatus.pending();
    }
  }

  Future<Order> _pollForPaymentStatus(String orderId) async {
    final repository = _ref.read(ordersRepositoryProvider);
    final start = DateTime.now();
    var attempts = 0;

    while (true) {
      if (attempts > 0) {
        await Future.delayed(_pollInterval);
      }

      attempts += 1;
      final order = await repository.getOrderDetail(orderId);
      final paymentStatus = _parsePaymentStatus(order.payment?.status);

      state = state.copyWith(
        order: order,
        paymentStatus: paymentStatus,
        pollAttempts: attempts,
      );

      if (paymentStatus == const PaymentStatus.completed()) {
        return order;
      }

      if (paymentStatus == const PaymentStatus.failed() ||
          paymentStatus == const PaymentStatus.cancelled()) {
        throw PaymentFailedException(
          'Ödeme işlemi tamamlanamadı. Lütfen tekrar deneyin.',
        );
      }

      if (DateTime.now().difference(start) >= _pollTimeout) {
        throw TimeoutException('Payment confirmation timed out');
      }
    }
  }
}

final checkoutProvider =
    StateNotifierProvider<CheckoutNotifier, CheckoutState>((ref) {
  return CheckoutNotifier(ref);
});

// Payment Methods Provider
final availablePaymentMethodsProvider = Provider<List<PaymentMethod>>((ref) {
  return const [PaymentMethod.creditCard()];
});

// Payment Method Fees Provider
final paymentMethodFeesProvider = Provider<Map<PaymentMethod, double>>((ref) {
  final mockPaymentService = ref.read(mockPaymentServiceProvider);
  final summary = ref.read(paymentSummaryProvider);

  final fees = <PaymentMethod, double>{};
  final method = const PaymentMethod.creditCard();
  fees[method] =
      mockPaymentService.getPaymentMethodFee(method, summary.subtotal);
  return fees;
});

// Convenience Providers
final isPaymentProcessingProvider = Provider<bool>((ref) {
  return ref.watch(paymentProcessingProvider).isLoading;
});

final paymentResultProvider = Provider<PaymentResponse?>((ref) {
  return ref.watch(paymentProcessingProvider).when(
        data: (response) => response,
        loading: () => null,
        error: (error, stack) => null,
      );
});

final isCheckoutProcessingProvider = Provider<bool>((ref) {
  final checkoutState = ref.watch(checkoutProvider);
  return checkoutState.isLoading;
});

final checkoutResultProvider = Provider<Order?>((ref) {
  final checkoutState = ref.watch(checkoutProvider);
  return checkoutState.order;
});

class PaymentFailedException implements Exception {
  final String message;
  PaymentFailedException(this.message);

  @override
  String toString() => message;
}
