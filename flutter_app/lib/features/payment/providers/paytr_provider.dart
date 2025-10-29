import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../../../core/models/paytr_model.dart';
import '../../../core/models/order_model.dart';
import '../data/paytr_api_service.dart';
import '../data/paytr_repository.dart';
import '../../addresses/providers/addresses_provider.dart';
import '../../cart/providers/cart_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../orders/providers/orders_provider.dart';

// PayTR API Service Provider
final paytrApiServiceProvider = Provider<PayTRApiService>((ref) {
  final dio = ref.watch(apiClientProvider);
  return PayTRApiService(dio);
});

// PayTR Repository Provider
final paytrRepositoryProvider = Provider<PayTRRepository>((ref) {
  final apiService = ref.watch(paytrApiServiceProvider);
  return PayTRRepository(apiService);
});

// PayTR Payment Token Provider
class PayTRTokenNotifier extends StateNotifier<AsyncValue<PayTRTokenResponse?>> {
  final PayTRRepository _repository;
  final Ref _ref;

  PayTRTokenNotifier(this._repository, this._ref) : super(const AsyncValue.data(null));

  Future<void> getPaymentToken(String orderId) async {
    try {
      state = const AsyncValue.loading();

      // Get cart items
      final cartItems = _ref.read(cartItemsProvider);
      if (cartItems.isEmpty) {
        throw Exception('Sepetiniz boş. Lütfen ürün ekleyin.');
      }

      // Get user profile
      final authData = _ref.read(authProvider);
      final userProfile = authData.user;
      
      if (userProfile == null) {
        throw Exception('Kullanıcı bilgileri bulunamadı');
      }

      // Get current address
      final currentAddressAsync = _ref.read(currentAddressProvider);
      final currentAddress = currentAddressAsync.when(
        data: (address) => address,
        loading: () => throw Exception('Adres bilgileri yükleniyor...'),
        error: (error, stack) => throw Exception('Aktif adres bulunamadı. Lütfen bir adres ekleyin.'),
      );

      if (currentAddress == null) {
        throw Exception('Aktif adres bulunamadı. Lütfen bir adres ekleyin.');
      }

      // Get payment token
      final tokenResponse = await _repository.getPaymentToken(
        orderId: orderId,
        cartItems: cartItems,
        userProfile: userProfile,
        currentAddress: currentAddress,
      );

      state = AsyncValue.data(tokenResponse);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void clearToken() {
    state = const AsyncValue.data(null);
  }
}

final paytrTokenProvider = StateNotifierProvider<PayTRTokenNotifier, AsyncValue<PayTRTokenResponse?>>((ref) {
  final repository = ref.watch(paytrRepositoryProvider);
  return PayTRTokenNotifier(repository, ref);
});

// PayTR Payment Processing Provider
class PayTRPaymentNotifier extends StateNotifier<AsyncValue<Order?>> {
  final Ref _ref;

  PayTRPaymentNotifier(this._ref) : super(const AsyncValue.data(null));

  Future<Order?> processPayment({
    required String orderId,
  }) async {
    try {
      state = const AsyncValue.loading();

      // Get PayTR token
      await _ref.read(paytrTokenProvider.notifier).getPaymentToken(orderId);
      
      final tokenAsync = _ref.read(paytrTokenProvider);
      final tokenResponse = tokenAsync.when(
        data: (response) => response,
        loading: () => throw Exception('Ödeme token alınıyor...'),
        error: (error, stack) => throw Exception('Ödeme token alınamadı: $error'),
      );

      if (tokenResponse == null) {
        throw Exception('Ödeme token alınamadı');
      }

      // Return the order - the actual payment will be handled by PayTR iframe
      // Backend will update the order status via callback
      final orderDetailAsync = _ref.read(orderDetailProvider.notifier);
      await orderDetailAsync.loadOrderDetail(orderId);
      
      final order = orderDetailAsync.state.when(
        data: (order) => order,
        loading: () => throw Exception('Sipariş yükleniyor...'),
        error: (error, stack) => throw Exception('Sipariş yüklenemedi: $error'),
      );
      
      state = AsyncValue.data(order);
      return order;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      return null;
    }
  }

  void clearPayment() {
    state = const AsyncValue.data(null);
    _ref.read(paytrTokenProvider.notifier).clearToken();
  }
}

final paytrPaymentProvider = StateNotifierProvider<PayTRPaymentNotifier, AsyncValue<Order?>>((ref) {
  return PayTRPaymentNotifier(ref);
});

// Convenience providers
final paytrTokenDataProvider = Provider<PayTRTokenResponse?>((ref) {
  return ref.watch(paytrTokenProvider).when(
    data: (response) => response,
    loading: () => null,
    error: (error, stack) => null,
  );
});

final isPayTRLoadingProvider = Provider<bool>((ref) {
  return ref.watch(paytrTokenProvider).isLoading || 
         ref.watch(paytrPaymentProvider).isLoading;
});
