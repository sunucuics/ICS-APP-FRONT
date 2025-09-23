import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../cart/providers/cart_provider.dart';
import '../../../../core/models/cart_model.dart';
import '../../../../core/theme/app_theme.dart';

class CartTab extends ConsumerWidget {
  const CartTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sepet'),
        actions: [
          // Cart item count badge
          cartAsync.when(
            data: (cart) => cart.items.isNotEmpty
                ? IconButton(
                    icon: Stack(
                      children: [
                        const Icon(Icons.shopping_cart),
                        if (cart.totalQuantity > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '${cart.totalQuantity}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                    onPressed: () {},
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          // Clear cart button
          cartAsync.when(
            data: (cart) => cart.items.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.delete_sweep),
                    onPressed: () => _showClearCartDialog(context, ref),
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: cartAsync.when(
        data: (cart) => cart.items.isEmpty
            ? _buildEmptyCart(context)
            : _buildCartContent(context, ref, cart),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            _buildErrorState(context, ref, error.toString()),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Sepetiniz boş',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Mağazadan ürün ekleyerek başlayabilirsiniz',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to catalog tab
              // Bu navigation logic'i parent widget'ta handle edilmeli
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mağaza sekmesine geçin')),
              );
            },
            icon: const Icon(Icons.store),
            label: const Text('Mağazaya Git'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, WidgetRef ref, Cart cart) {
    return Column(
      children: [
        // Cart items list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return _buildCartItemCard(context, ref, item, index);
            },
          ),
        ),
        // Cart summary
        _buildCartSummary(context, ref, cart),
      ],
    );
  }

  Widget _buildCartItemCard(
      BuildContext context, WidgetRef ref, CartItem item, int index) {
    final displayPrice = item.finalPrice ?? item.price;
    final hasDiscount =
        item.finalPrice != null && item.finalPrice! < item.price;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.black, // Dark background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryNavy, // Dark blue border
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryNavy.withOpacity(0.6), // Enhanced blue glow
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: AppTheme.primaryNavy.withOpacity(0.4),
            blurRadius: 40,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Product image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: item.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: item.image!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.image_not_supported),
                        ),
                      ),
                    )
                  : const Icon(Icons.image_not_supported, size: 32),
            ),
            const SizedBox(width: 12),
            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white, // White text for dark background
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.categoryName != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      item.categoryName!,
                      style: const TextStyle(
                        color: Colors.white70, // White70 for dark background
                        fontSize: 12,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  // Price
                  Row(
                    children: [
                      Text(
                        '₺${displayPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white, // White price text
                        ),
                      ),
                      if (hasDiscount) ...[
                        const SizedBox(width: 8),
                        Text(
                          '₺${item.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.white60, // White60 for dark background
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Quantity controls
                  Row(
                    children: [
                      // Decrease quantity
                      IconButton(
                        onPressed: item.qty > 1
                            ? () => _updateQuantity(
                                ref, item.productId, item.qty - 1)
                            : null,
                        icon: const Icon(Icons.remove),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          padding: const EdgeInsets.all(8),
                          minimumSize: const Size(32, 32),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${item.qty}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white, // White text for dark background
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Increase quantity
                      IconButton(
                        onPressed: item.qty < item.stock
                            ? () => _updateQuantity(
                                ref, item.productId, item.qty + 1)
                            : null,
                        icon: const Icon(Icons.add),
                        style: IconButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          padding: const EdgeInsets.all(8),
                          minimumSize: const Size(32, 32),
                        ),
                      ),
                      const Spacer(),
                      // Remove item
                      IconButton(
                        onPressed: () => _removeItem(ref, item.productId),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context, WidgetRef ref, Cart cart) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black, // Dark background
        border: Border(
          top: BorderSide(color: AppTheme.primaryNavy.withOpacity(0.3)),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryNavy.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Toplam (${cart.totalQuantity} ürün)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white, // White text for dark background
                ),
              ),
              Text(
                '₺${cart.totalBase.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text for dark background
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: cart.items.isNotEmpty
                  ? () => _proceedToCheckout(context, ref, cart)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryNavy, // Dark blue button
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 4,
                shadowColor: AppTheme.primaryNavy.withOpacity(0.4),
              ),
              child: const Text(
                'Siparişi Tamamla',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Sepet yüklenemedi',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => ref.read(cartProvider.notifier).refresh(),
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  void _updateQuantity(WidgetRef ref, String productId, int newQuantity) {
    // Bu implementasyon cart API'sine quantity update gönderecek
    // Şimdilik basit sepete ekleme yapıyoruz
    ref.read(cartProvider.notifier).addToCart(productId, quantity: 1);
  }

  void _removeItem(WidgetRef ref, String productId) {
    ref.read(cartProvider.notifier).removeFromCart(productId);
  }

  void _showClearCartDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sepeti Temizle'),
          content: const Text(
              'Tüm ürünleri sepetten çıkarmak istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(cartProvider.notifier).clearCart();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child:
                  const Text('Temizle', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _proceedToCheckout(BuildContext context, WidgetRef ref, Cart cart) {
    // Şimdilik basit bir sipariş onay dialog'u gösterelim
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sipariş Özeti'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Toplam ${cart.totalQuantity} ürün'),
              const SizedBox(height: 8),
              Text(
                'Tutar: ₺${cart.totalBase.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Ödeme ve kargo entegrasyonu ileriki aşamada eklenecek.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Sipariş oluşturma özelliği yakında eklenecek'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              child: const Text('Onayla'),
            ),
          ],
        );
      },
    );
  }
}
