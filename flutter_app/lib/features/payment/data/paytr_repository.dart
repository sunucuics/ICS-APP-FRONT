import '../../../core/models/paytr_model.dart';
import '../../../core/models/cart_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/models/address_model.dart' as address_model;
import 'paytr_api_service.dart';

class PayTRRepository {
  final PayTRApiService _apiService;

  PayTRRepository(this._apiService);

  /// Get PayTR payment token from cart and user data
  Future<PayTRTokenResponse> getPaymentToken({
    required String orderId,
    required List<CartItem> cartItems,
    required UserProfile userProfile,
    required address_model.Address currentAddress,
  }) async {
    try {
      // Calculate total amount
      final totalAmount = cartItems.fold<double>(
        0.0,
        (sum, item) => sum + (item.finalPrice! * item.qty),
      );

      // Build basket for PayTR
      final basket = cartItems
          .map((item) => PayTRBasketItem(
                name: item.title,
                price: item.finalPrice!,
                quantity: item.qty,
              ))
          .toList();

      // Build address string
      final addressParts = <String>[];
      if (currentAddress.street != null) addressParts.add(currentAddress.street!);
      if (currentAddress.buildingNo != null) addressParts.add('No: ${currentAddress.buildingNo}');
      if (currentAddress.apartment != null) addressParts.add('Daire: ${currentAddress.apartment}');
      if (currentAddress.floor != null) addressParts.add('Kat: ${currentAddress.floor}');
      if (currentAddress.neighborhood != null) addressParts.add(currentAddress.neighborhood!);
      if (currentAddress.district != null) addressParts.add(currentAddress.district!);
      if (currentAddress.city != null) addressParts.add(currentAddress.city!);
      if (currentAddress.zipCode != null) addressParts.add(currentAddress.zipCode!);

      final addressString = addressParts.join(', ');

      // Create PayTR request
      final request = PayTRTokenRequest(
        merchantOid: orderId,
        email: userProfile.email,
        userName: userProfile.name,
        userAddress: addressString,
        userPhone: userProfile.phone,
        paymentAmount: totalAmount,
        currency: 'TL',
        basket: basket,
        userIp: null, // Backend will handle this
      );

      return await _apiService.getPaymentToken(request);
    } catch (e) {
      rethrow;
    }
  }
}
