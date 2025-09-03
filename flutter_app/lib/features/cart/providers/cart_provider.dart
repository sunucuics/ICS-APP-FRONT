import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/cart_model.dart';
import '../data/cart_repository.dart';

// Cart Repository Provider
final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository();
});

// Cart Provider - State Notifier for better cart management
class CartNotifier extends StateNotifier<AsyncValue<Cart>> {
  final CartRepository _repository;

  CartNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadCart();
  }

  // Load cart from backend
  Future<void> loadCart() async {
    try {
      state = const AsyncValue.loading();
      final cart = await _repository.getCart();
      state = AsyncValue.data(cart);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Add item to cart
  Future<void> addToCart(String productId, {int quantity = 1}) async {
    try {
      await _repository.addToCart(productId, quantity: quantity);
      // Reload cart to get updated data
      await loadCart();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Remove item from cart
  Future<void> removeFromCart(String productId) async {
    try {
      await _repository.removeFromCart(productId);
      // Reload cart to get updated data
      await loadCart();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Clear entire cart
  Future<void> clearCart() async {
    try {
      await _repository.clearCart();
      // Reload cart to get updated data
      await loadCart();
    } catch (error, stackTrace) {
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

// Helper to add item to cart from anywhere in the app
final addToCartProvider =
    Provider<Future<void> Function(String, {int quantity})>((ref) {
  return (String productId, {int quantity = 1}) async {
    await ref
        .read(cartProvider.notifier)
        .addToCart(productId, quantity: quantity);
  };
});
