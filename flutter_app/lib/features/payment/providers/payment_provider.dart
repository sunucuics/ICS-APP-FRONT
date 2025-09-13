import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/payment_model.dart';
import '../../../core/models/order_model.dart';
import '../../../core/models/address_model.dart';
import '../../../features/orders/providers/orders_provider.dart';
import '../../../features/addresses/providers/addresses_provider.dart';
import '../../../features/cart/providers/cart_provider.dart';
import '../data/mock_payment_service.dart';

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
  final Ref _ref;

  PaymentProcessingNotifier(this._mockPaymentService, this._ref)
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
  return PaymentProcessingNotifier(mockPaymentService, ref);
});

// Payment Summary Provider
final paymentSummaryProvider = Provider<PaymentSummary>((ref) {
  final cartTotalAsync = ref.watch(cartTotalProvider);
  final selectedMethod = ref.watch(selectedPaymentMethodProvider);

  final subtotal = cartTotalAsync.when(
    data: (cartTotal) => cartTotal.totalPrice,
    loading: () => 0.0,
    error: (error, stack) => 0.0,
  );

  final shipping = 0.0; // Free shipping for now
  final tax = subtotal * 0.18; // 18% VAT
  final discount = 0.0; // No discount for now
  final paymentFee = ref
      .read(mockPaymentServiceProvider)
      .getPaymentMethodFee(selectedMethod, subtotal);

  final total = subtotal + shipping + tax + paymentFee - discount;

  return PaymentSummary(
    subtotal: subtotal,
    shipping: shipping,
    tax: tax,
    discount: discount,
    total: total,
    currency: 'TRY',
  );
});

// Checkout Provider
class CheckoutNotifier extends StateNotifier<AsyncValue<Order?>> {
  final Ref _ref;

  CheckoutNotifier(this._ref) : super(const AsyncValue.data(null));

  Future<Order?> processCheckout({
    required PaymentMethod paymentMethod,
    String? orderNote,
    bool simulatePaymentSuccess = true,
  }) async {
    try {
      state = const AsyncValue.loading();

      // Check if user has current address
      final currentAddressAsync = _ref.read(currentAddressProvider);
      final currentAddress = currentAddressAsync.when(
        data: (address) => address,
        loading: () => null,
        error: (error, stack) => null,
      );

      if (currentAddress == null) {
        throw Exception('Aktif adres bulunamadı. Lütfen bir adres ekleyin.');
      }

      // Get cart items
      final cartItems = _ref.read(cartItemsProvider);
      if (cartItems.isEmpty) {
        throw Exception('Sepetiniz boş. Lütfen ürün ekleyin.');
      }

      // Create order items from cart
      final orderItems = cartItems
          .map((item) => OrderCreateItem(
                productId: item.productId,
                name: item.title,
                quantity: item.qty,
                price: item.price,
              ))
          .toList();

      // Create order with simulate=true for mock payment
      final order = await _ref.read(createOrderHelperProvider)(
        items: orderItems,
        note: orderNote,
        simulate: true, // Mock payment
        clearCartOnSuccess: true,
      );

      if (order != null) {
        // Process mock payment
        final paymentResponse =
            await _ref.read(paymentProcessingProvider.notifier).processPayment(
                  amount: order.totals?.grandTotal ?? 0.0,
                  method: paymentMethod,
                  description: 'Sipariş #${order.id}',
                  simulateSuccess: simulatePaymentSuccess,
                );

        if (paymentResponse != null && paymentResponse.status.isSuccess) {
          state = AsyncValue.data(order);
          return order;
        } else {
          throw Exception(
              paymentResponse?.errorMessage ?? 'Ödeme işlemi başarısız');
        }
      } else {
        throw Exception('Sipariş oluşturulamadı');
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

final checkoutProvider =
    StateNotifierProvider<CheckoutNotifier, AsyncValue<Order?>>((ref) {
  return CheckoutNotifier(ref);
});

// Payment Methods Provider
final availablePaymentMethodsProvider = Provider<List<PaymentMethod>>((ref) {
  final mockPaymentService = ref.read(mockPaymentServiceProvider);
  return mockPaymentService.getAvailablePaymentMethods();
});

// Payment Method Fees Provider
final paymentMethodFeesProvider = Provider<Map<PaymentMethod, double>>((ref) {
  final mockPaymentService = ref.read(mockPaymentServiceProvider);
  final availableMethods = ref.read(availablePaymentMethodsProvider);
  final summary = ref.read(paymentSummaryProvider);

  final fees = <PaymentMethod, double>{};
  for (final method in availableMethods) {
    fees[method] =
        mockPaymentService.getPaymentMethodFee(method, summary.subtotal);
  }

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
  return ref.watch(checkoutProvider).isLoading;
});

final checkoutResultProvider = Provider<Order?>((ref) {
  return ref.watch(checkoutProvider).when(
        data: (order) => order,
        loading: () => null,
        error: (error, stack) => null,
      );
});
