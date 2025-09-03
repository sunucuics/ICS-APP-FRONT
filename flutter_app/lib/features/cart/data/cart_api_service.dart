import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/models/cart_model.dart';

class CartApiService {
  final ApiClient _apiClient = ApiClient.instance;

  // Get cart
  Future<Cart> getCart() async {
    final response = await _apiClient.get(ApiEndpoints.cart);
    return Cart.fromJson(response.data as Map<String, dynamic>);
  }

  // Get cart total only
  Future<CartTotal> getCartTotal() async {
    final response = await _apiClient.get(ApiEndpoints.cartTotal);
    return CartTotal.fromJson(response.data);
  }

  // Add item to cart
  Future<Map<String, dynamic>> addToCart(AddToCartRequest request) async {
    final response = await _apiClient.post(
      ApiEndpoints.cartItems,
      data: request.toApiJson(),
    );
    return response.data;
  }

  // Remove item from cart
  Future<Map<String, dynamic>> removeFromCart(String productId) async {
    final response = await _apiClient.delete(
      ApiEndpoints.cartItem(productId),
    );
    return response.data;
  }

  // Clear entire cart
  Future<void> clearCart() async {
    await _apiClient.delete(ApiEndpoints.cart);
  }
}
