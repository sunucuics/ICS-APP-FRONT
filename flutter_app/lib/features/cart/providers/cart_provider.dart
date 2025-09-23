import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/cart_model.dart';
import '../data/cart_repository.dart';
import '../../auth/services/mock_anonymous_auth_service.dart';

// Cart Repository Provider
final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository();
});

// Cart Provider - State Notifier for better cart management
class CartNotifier extends StateNotifier<AsyncValue<Cart>> {
  final CartRepository _repository;
  bool _isAddingToCart = false;

  CartNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadCart();
  }

  bool get isAddingToCart => _isAddingToCart;

  // Load cart from backend
  Future<void> loadCart() async {
    try {
      // Check if user is guest/anonymous - don't load cart for guest users
      final mockAuthService = MockAnonymousAuthService();
      if (mockAuthService.isAnonymous) {
        // Return empty cart for guest users
        state = AsyncValue.data(Cart(
          userId: mockAuthService.currentUser?.uid ?? 'guest',
          items: [],
          totalBase: 0.0,
          totalQuantity: 0,
        ));
        return;
      }

      state = const AsyncValue.loading();
      final cart = await _repository.getCart();
      state = AsyncValue.data(cart);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Add item to cart with optimistic UI
  Future<void> addToCart(String productId,
      {int quantity = 1, String? productTitle, double? productPrice}) async {
    if (_isAddingToCart) return; // Prevent multiple simultaneous requests

    // Check if user is guest/anonymous - don't allow adding to cart for guest users
    final mockAuthService = MockAnonymousAuthService();
    if (mockAuthService.isAnonymous) {
      throw Exception(
          'Misafir kullanıcılar sepete ürün ekleyemez. Lütfen hesap oluşturun.');
    }

    _isAddingToCart = true;
    try {
      // Optimistic update - immediately update UI
      final currentCart = state.valueOrNull;
      if (currentCart != null) {
        // Check if item already exists in cart
        final existingItemIndex = currentCart.items.indexWhere(
          (item) => item.productId == productId,
        );

        List<CartItem> updatedItems;
        if (existingItemIndex != -1) {
          // Update existing item quantity
          final existingItem = currentCart.items[existingItemIndex];
          updatedItems = List.from(currentCart.items);
          updatedItems[existingItemIndex] = existingItem.copyWith(
            qty: existingItem.qty + quantity,
            baseSubtotal: (existingItem.qty + quantity) * existingItem.price,
            totalBase: (existingItem.qty + quantity) * existingItem.price,
          );
        } else {
          // Add new item with product details if available
          final newItem = CartItem(
            productId: productId,
            title: productTitle ?? 'Loading...',
            price: productPrice ?? 0.0,
            stock: 0,
            qty: quantity,
            baseSubtotal: (productPrice ?? 0.0) * quantity,
            totalBase: (productPrice ?? 0.0) * quantity,
          );
          updatedItems = [...currentCart.items, newItem];
        }

        // Calculate new totals
        final newTotalQuantity =
            updatedItems.fold(0, (sum, item) => sum + item.qty);
        final newTotalBase =
            updatedItems.fold(0.0, (sum, item) => sum + item.totalBase);

        // Update state optimistically
        state = AsyncValue.data(currentCart.copyWith(
          items: updatedItems,
          totalQuantity: newTotalQuantity,
          totalBase: newTotalBase,
        ));
      }

      // Make API call
      await _repository.addToCart(productId, quantity: quantity);

      // Reload cart to get accurate data from server
      await loadCart();
    } catch (error, stackTrace) {
      // Revert optimistic update on error
      await loadCart();
      state = AsyncValue.error(error, stackTrace);
    } finally {
      _isAddingToCart = false;
    }
  }

  // Remove item from cart with optimistic UI
  Future<void> removeFromCart(String productId) async {
    // Check if user is guest/anonymous - don't allow removing from cart for guest users
    final mockAuthService = MockAnonymousAuthService();
    if (mockAuthService.isAnonymous) {
      throw Exception(
          'Misafir kullanıcılar sepetten ürün çıkaramaz. Lütfen hesap oluşturun.');
    }

    try {
      // Optimistic update - immediately update UI
      final currentCart = state.valueOrNull;
      if (currentCart != null) {
        final updatedItems = currentCart.items
            .where((item) => item.productId != productId)
            .toList();

        // Calculate new totals
        final newTotalQuantity =
            updatedItems.fold(0, (sum, item) => sum + item.qty);
        final newTotalBase =
            updatedItems.fold(0.0, (sum, item) => sum + item.totalBase);

        // Update state optimistically
        state = AsyncValue.data(currentCart.copyWith(
          items: updatedItems,
          totalQuantity: newTotalQuantity,
          totalBase: newTotalBase,
        ));
      }

      // Make API call
      await _repository.removeFromCart(productId);

      // Reload cart to get accurate data from server
      await loadCart();
    } catch (error, stackTrace) {
      // Revert optimistic update on error
      await loadCart();
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Clear entire cart with optimistic UI
  Future<void> clearCart() async {
    // Check if user is guest/anonymous - don't allow clearing cart for guest users
    final mockAuthService = MockAnonymousAuthService();
    if (mockAuthService.isAnonymous) {
      throw Exception(
          'Misafir kullanıcılar sepeti temizleyemez. Lütfen hesap oluşturun.');
    }

    try {
      // Optimistic update - immediately clear UI
      final currentCart = state.valueOrNull;
      if (currentCart != null) {
        state = AsyncValue.data(currentCart.copyWith(
          items: [],
          totalQuantity: 0,
          totalBase: 0.0,
        ));
      }

      // Make API call
      await _repository.clearCart();

      // Reload cart to confirm
      await loadCart();
    } catch (error, stackTrace) {
      // Revert optimistic update on error
      await loadCart();
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Refresh cart data
  Future<void> refresh() async {
    await loadCart();
  }
}

// Cart State Notifier Provider
final cartProvider =
    StateNotifierProvider<CartNotifier, AsyncValue<Cart>>((ref) {
  final repository = ref.read(cartRepositoryProvider);
  return CartNotifier(repository);
});

// Cart Total Provider - separate provider for just totals
final cartTotalProvider = FutureProvider.autoDispose<CartTotal>((ref) {
  final repository = ref.read(cartRepositoryProvider);
  return repository.getCartTotal();
});

// Convenience providers
final cartItemsProvider = Provider<List<CartItem>>((ref) {
  return ref.watch(cartProvider).when(
        data: (cart) => cart.items,
        loading: () => <CartItem>[],
        error: (error, stack) => <CartItem>[],
      );
});

final cartItemCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).when(
        data: (cart) => cart.totalQuantity,
        loading: () => 0,
        error: (error, stack) => 0,
      );
});

final cartTotalAmountProvider = Provider<double>((ref) {
  return ref.watch(cartProvider).when(
        data: (cart) => cart.totalBase,
        loading: () => 0.0,
        error: (error, stack) => 0.0,
      );
});

// Loading state provider for cart operations
final cartLoadingProvider = Provider<bool>((ref) {
  return ref.watch(cartProvider.notifier).isAddingToCart;
});

// Helper to add item to cart from anywhere in the app
final addToCartProvider = Provider<
    Future<void> Function(String,
        {int quantity, String? productTitle, double? productPrice})>((ref) {
  return (String productId,
      {int quantity = 1, String? productTitle, double? productPrice}) async {
    await ref.read(cartProvider.notifier).addToCart(productId,
        quantity: quantity,
        productTitle: productTitle,
        productPrice: productPrice);
  };
});
