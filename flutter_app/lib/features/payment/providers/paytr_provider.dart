import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../../../core/models/paytr_model.dart';
import '../data/paytr_api_service.dart';
import '../data/paytr_repository.dart';
import '../../addresses/providers/addresses_provider.dart';
import '../../cart/providers/cart_provider.dart';
import '../../auth/providers/auth_provider.dart';

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

// PayTR Direct API Init Provider
class PayTRDirectInitNotifier extends StateNotifier<AsyncValue<PayTRDirectInitResponse?>> {
  final PayTRRepository _repository;
  final Ref _ref;

  PayTRDirectInitNotifier(this._repository, this._ref) : super(const AsyncValue.data(null));

  Future<void> getDirectInit({
    required String orderId,
    int installmentCount = 0,
    String? cardType,
  }) async {
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

      // Get PayTR Direct API init
      final initResponse = await _repository.getDirectInit(
        orderId: orderId,
        cartItems: cartItems,
        userProfile: userProfile,
        currentAddress: currentAddress,
        installmentCount: installmentCount,
        cardType: cardType,
      );

      state = AsyncValue.data(initResponse);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void clearInit() {
    state = const AsyncValue.data(null);
  }
}

final paytrDirectInitProvider = StateNotifierProvider<PayTRDirectInitNotifier, AsyncValue<PayTRDirectInitResponse?>>((ref) {
  final repository = ref.watch(paytrRepositoryProvider);
  return PayTRDirectInitNotifier(repository, ref);
});

// PayTR iFrame Token Provider (optional)
class PayTRIframeTokenNotifier extends StateNotifier<AsyncValue<PayTRIframeInitResponse?>> {
  final PayTRRepository _repository;
  final Ref _ref;

  PayTRIframeTokenNotifier(this._repository, this._ref) : super(const AsyncValue.data(null));

  Future<void> getIframeToken(String orderId) async {
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

      // Get PayTR iFrame token
      final iframeResponse = await _repository.getIframeToken(
        orderId: orderId,
        cartItems: cartItems,
        userProfile: userProfile,
        currentAddress: currentAddress,
      );

      state = AsyncValue.data(iframeResponse);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void clearToken() {
    state = const AsyncValue.data(null);
  }
}

final paytrIframeTokenProvider = StateNotifierProvider<PayTRIframeTokenNotifier, AsyncValue<PayTRIframeInitResponse?>>((ref) {
  final repository = ref.watch(paytrRepositoryProvider);
  return PayTRIframeTokenNotifier(repository, ref);
});

// Convenience providers
final paytrDirectInitDataProvider = Provider<PayTRDirectInitResponse?>((ref) {
  return ref.watch(paytrDirectInitProvider).when(
    data: (response) => response,
    loading: () => null,
    error: (error, stack) => null,
  );
});

final isPayTRLoadingProvider = Provider<bool>((ref) {
  return ref.watch(paytrDirectInitProvider).isLoading || 
         ref.watch(paytrIframeTokenProvider).isLoading;
});

// Legacy providers (deprecated)
@Deprecated('Use paytrDirectInitProvider instead')
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

@Deprecated('Use paytrDirectInitProvider instead')
final paytrTokenProvider = StateNotifierProvider<PayTRTokenNotifier, AsyncValue<PayTRTokenResponse?>>((ref) {
  final repository = ref.watch(paytrRepositoryProvider);
  return PayTRTokenNotifier(repository, ref);
});
