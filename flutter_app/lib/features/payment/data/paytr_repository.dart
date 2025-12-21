import '../../../core/models/paytr_model.dart';
import '../../../core/models/cart_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/models/address_model.dart' as address_model;
import 'paytr_api_service.dart';

class PayTRRepository {
  final PayTRApiService _apiService;

  PayTRRepository(this._apiService);

  /// Get PayTR Direct API init from cart and user data
  Future<PayTRDirectInitResponse> getDirectInit({
    required String orderId,
    required List<CartItem> cartItems,
    required UserProfile userProfile,
    required address_model.Address currentAddress,
    int installmentCount = 0,
    String? cardType,
  }) async {
    try {
      // Calculate total amount
      final totalAmount = cartItems.fold<double>(
        0.0,
        (sum, item) {
          final pricePerUnit = item.finalPrice ?? item.price;
          return sum + (pricePerUnit * item.qty);
        },
      );
      final normalizedAmount = _roundToTwoDecimals(totalAmount);

      // Build basket for PayTR
      final basket = cartItems
          .map((item) => PayTRBasketItem(
                name: item.title,
                price: _roundToTwoDecimals(item.finalPrice ?? item.price),
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

      // Debug info for QA/testing
      // ignore: avoid_print
      print(
        '[PayTR] Direct init ⇒ orderId=$orderId amount(TL)=$normalizedAmount basket=${basket.map((e) => '${e.name}:${e.price}x${e.quantity}').join(', ')}',
      );

      // Create PayTR Direct API request
      final request = PayTRDirectInitRequest(
        merchantOid: orderId,
        email: userProfile.email,
        paymentAmount: normalizedAmount,
        paymentType: 'card',
        installmentCount: installmentCount,
        currency: 'TL',
        non3d: 0, // 3D Secure enabled
        clientLang: 'tr',
        userName: userProfile.name,
        userAddress: addressString,
        userPhone: userProfile.phone,
        basket: basket,
        cardType: cardType,
        userIp: null, // Backend will handle this
        debugOn: 1,
      );

      final response = await _apiService.getDirectInit(request);
      // ignore: avoid_print
      print(
        '[PayTR] Direct init ⇐ orderId=$orderId payment_amount(kuruş)=${response.fields.paymentAmount}',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get PayTR iFrame token (optional)
  Future<PayTRIframeInitResponse> getIframeToken({
    required String orderId,
    required List<CartItem> cartItems,
    required UserProfile userProfile,
    required address_model.Address currentAddress,
  }) async {
    try {
      // Calculate total amount
      final totalAmount = cartItems.fold<double>(
        0.0,
        (sum, item) {
          final pricePerUnit = item.finalPrice ?? item.price;
          return sum + (pricePerUnit * item.qty);
        },
      );
      final normalizedAmount = _roundToTwoDecimals(totalAmount);

      // Build basket for PayTR
      final basket = cartItems
          .map((item) => PayTRBasketItem(
                name: item.title,
                price: _roundToTwoDecimals(item.finalPrice ?? item.price),
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

      // Create PayTR iFrame request
      final request = PayTRIframeInitRequest(
        merchantOid: orderId,
        email: userProfile.email,
        paymentAmount: normalizedAmount,
        userName: userProfile.name,
        userAddress: addressString,
        userPhone: userProfile.phone,
        basket: basket,
        userIp: null,
        debugOn: 1,
        noInstallment: 0,
        maxInstallment: 0,
        currency: 'TL',
      );

      return await _apiService.getIframeToken(request);
    } catch (e) {
      rethrow;
    }
  }

  /// Verify PayTR Direct API fields (debug only)
  Future<Map<String, dynamic>> verifyDirectInit(PayTRDirectInitFields fields) async {
    return await _apiService.verifyDirectInit(fields);
  }

  /// Get PayTR installments info
  Future<Map<String, dynamic>> getInstallments() async {
    return await _apiService.getInstallments();
  }

  // Legacy method (deprecated)
  @Deprecated('Use getDirectInit instead')
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
        (sum, item) {
          final pricePerUnit = item.finalPrice ?? item.price;
          return sum + (pricePerUnit * item.qty);
        },
      );
      final normalizedAmount = _roundToTwoDecimals(totalAmount);

      // Build basket for PayTR
      final basket = cartItems
          .map((item) => PayTRBasketItem(
                name: item.title,
                price: _roundToTwoDecimals(item.finalPrice ?? item.price),
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
        userName: userProfile.name ?? 'Kullanıcı',
        userAddress: addressString,
        userPhone: userProfile.phone ?? '',
        paymentAmount: normalizedAmount,
        currency: 'TL',
        basket: basket,
        userIp: null, // Backend will handle this
      );

      return await _apiService.getPaymentToken(request);
    } catch (e) {
      rethrow;
    }
  }

  double _roundToTwoDecimals(double value) =>
      value.isFinite ? double.parse(value.toStringAsFixed(2)) : 0.0;
}
