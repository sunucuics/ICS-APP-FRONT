import '../../../core/models/cart_model.dart';
import '../../../core/network/api_endpoints.dart';
import 'cart_api_service.dart';

class CartRepository {
  final CartApiService _apiService = CartApiService();

  // Get cart
  Future<Cart> getCart() async {
    try {
      return await _apiService.getCart();
    } catch (e) {
      // Only print in debug mode
      if (ApiEndpoints.isDebug) {
        print('Error fetching cart: $e');
      }
      // Return empty cart as fallback
      return const Cart(
        userId: '',
        items: [],
        totalQuantity: 0,
        totalBase: 0.0,
      );
    }
  }

  // Get cart total
  Future<CartTotal> getCartTotal() async {
    try {
      return await _apiService.getCartTotal();
    } catch (e) {
      // Only print in debug mode
      if (ApiEndpoints.isDebug) {
        print('Error fetching cart total: $e');
      }
      rethrow;
    }
  }

  // Add item to cart
  Future<void> addToCart(String productId, {int quantity = 1}) async {
    try {
      final request =
          AddToCartRequest(productId: productId, quantity: quantity);
      await _apiService.addToCart(request);
    } catch (e) {
      // Only print in debug mode
      if (ApiEndpoints.isDebug) {
        print('Error adding to cart: $e');
      }
      rethrow;
    }
  }

  // Remove item from cart
  Future<void> removeFromCart(String productId) async {
    try {
      await _apiService.removeFromCart(productId);
    } catch (e) {
      // Only print in debug mode
      if (ApiEndpoints.isDebug) {
        print('Error removing from cart: $e');
      }
      rethrow;
    }
  }

  // Clear cart
  Future<void> clearCart() async {
    try {
      await _apiService.clearCart();
    } catch (e) {
      // Only print in debug mode
      if (ApiEndpoints.isDebug) {
        print('Error clearing cart: $e');
      }
      rethrow;
    }
  }
}
