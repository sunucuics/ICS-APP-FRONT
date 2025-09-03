import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required String productId,
    required String title,
    String? description,
    String? image,
    required double price,
    double? finalPrice,
    required int stock,
    String? categoryName,
    required int qty,
    required double baseSubtotal,
    required double totalBase,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    // Manual parsing to avoid freezed conflicts
    return CartItem(
      productId: json['product_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image: json['image'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      finalPrice: (json['final_price'] as num?)?.toDouble() ?? 0.0,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      categoryName: json['category_name'] as String?,
      qty: (json['qty'] as num?)?.toInt() ?? 1,
      baseSubtotal: (json['base_subtotal'] as num?)?.toDouble() ?? 0.0,
      totalBase: (json['total_base'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

@freezed
class Cart with _$Cart {
  const factory Cart({
    required String userId,
    @Default([]) List<CartItem> items,
    @Default(0) int totalQuantity,
    @Default(0.0) double totalBase,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) {
    // Manual parsing to avoid freezed conflicts
    final itemsList = json['items'] as List<dynamic>? ?? [];
    final parsedItems = itemsList
        .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
        .toList();

    return Cart(
      userId: json['user_id'] as String? ?? '',
      items: parsedItems,
      totalQuantity: (json['total_quantity'] as num?)?.toInt() ?? 0,
      totalBase: (json['total_base'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

@freezed
class CartTotal with _$CartTotal {
  const factory CartTotal({
    @Default(0) int totalQuantity,
    @Default(0.0) double totalPrice,
  }) = _CartTotal;

  factory CartTotal.fromJson(Map<String, dynamic> json) {
    // Manual parsing to avoid freezed conflicts
    return CartTotal(
      totalQuantity: (json['total_quantity'] as num?)?.toInt() ?? 0,
      totalPrice: (json['total_price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

@freezed
class AddToCartRequest with _$AddToCartRequest {
  const factory AddToCartRequest({
    required String productId,
    @Default(1) int quantity,
  }) = _AddToCartRequest;

  factory AddToCartRequest.fromJson(Map<String, dynamic> json) =>
      _$AddToCartRequestFromJson(json);
}

// Extension for correct JSON mapping
extension AddToCartRequestExtension on AddToCartRequest {
  Map<String, dynamic> toApiJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
    };
  }
}
