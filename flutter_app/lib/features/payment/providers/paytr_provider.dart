import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../../../core/models/paytr_model.dart';
import '../../../core/models/order_model.dart';
import '../../../core/models/cart_model.dart';
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
    List<OrderItem>? orderItems,
    int installmentCount = 0,
    String? cardType,
  }) async {
    try {
      state = const AsyncValue.loading();

      // Determine basket source: order items (preferred) or current cart
      List<CartItem> basketItems;
      if (orderItems != null && orderItems.isNotEmpty) {
        basketItems = _mapOrderItemsToCartItems(orderItems);
      } else {
        final cartItems = _ref.read(cartItemsProvider);
        if (cartItems.isEmpty) {
          throw Exception('Sepetiniz boş. Lütfen ürün ekleyin.');
        }
        basketItems = cartItems;
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
        cartItems: basketItems,
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

  List<CartItem> _mapOrderItemsToCartItems(List<OrderItem> orderItems) {
    return orderItems.map((item) {
      final quantity = item.quantity ?? 1;
      final rawPrice =
          item.price ?? item.unitPrice ?? (item.total ?? item.lineTotal ?? 0.0);
      final price = rawPrice ?? 0.0;
      final computedFinal =
          item.total != null && quantity > 0 ? (item.total! / quantity) : null;
      final finalPrice = computedFinal ?? price;

      return CartItem(
        productId: item.productId ?? '',
        title: item.name ?? item.title ?? 'Ürün',
        description: item.product?['description'] as String?,
        image: item.imageUrl ?? item.product?['image_url'] as String?,
        price: price,
        finalPrice: finalPrice,
        stock: quantity,
        categoryName: item.product?['category_name'] as String?,
        qty: quantity,
        baseSubtotal: finalPrice * quantity,
        totalBase: finalPrice * quantity,
      );
    }).toList();
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
