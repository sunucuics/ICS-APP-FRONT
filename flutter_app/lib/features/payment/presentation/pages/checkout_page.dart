import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/price_utils.dart';
import '../../../../core/models/cart_model.dart';
import '../../../../core/models/address_model.dart';
import '../../../cart/providers/cart_provider.dart';
import '../../../addresses/providers/addresses_provider.dart';
import '../../models/paytr_models.dart';
import '../../providers/checkout_provider.dart';
import 'paytr_webview_page.dart';
import '../../../../core/services/navigation_service.dart';

/// Checkout Sayfası
///
/// Sipariş özeti gösterir ve ödeme işlemini başlatır.
/// Checkout akışı:
/// 1. Sepet ve adres bilgilerini göster
/// 2. "Ödemeye Geç" butonuna tıkla
/// 3. Sipariş oluştur + PayTR init al
/// 4. WebView'a yönlendir
/// 5. Ödeme sonucu bekle
class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  @override
  void initState() {
    super.initState();
    // Checkout state'i sıfırla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(checkoutProvider.notifier).reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartAsync = ref.watch(cartProvider);
    final checkoutState = ref.watch(checkoutProvider);
    final currentAddress = ref.watch(currentAddressDataProvider);

    // Checkout durumuna göre UI göster
    ref.listen<CheckoutState>(checkoutProvider, (previous, current) {
      if (!mounted) return;
      
      if (current.status == CheckoutStatus.awaitingPayment &&
          current.paytrResponse != null) {
        // PayTR response geldi, WebView'a yönlendir
        _navigateToPayment(current.paytrResponse!);
      } else if (current.status == CheckoutStatus.completed) {
        // Ödeme başarılı - sepet temizlendi
        _showSuccessDialog();
      } else if (current.status == CheckoutStatus.failed) {
        // Hata oluştu
        _showErrorSnackBar(current.errorMessage ?? 'Bir hata oluştu');
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Sipariş Özeti'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: cartAsync.when(
        data: (cart) => _buildContent(context, cart, checkoutState, currentAddress),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(error.toString()),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    Cart cart,
    CheckoutState checkoutState,
    Address? currentAddress,
  ) {
    // Ödeme doğrulanıyorsa veya tamamlandıysa loading göster
    if (checkoutState.status == CheckoutStatus.verifyingPayment ||
        checkoutState.status == CheckoutStatus.completed) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: AppTheme.primaryOrange,
            ),
            const SizedBox(height: 24),
            Text(
              checkoutState.status == CheckoutStatus.completed
                  ? 'Sipariş onaylanıyor...'
                  : 'Ödeme doğrulanıyor...',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    if (cart.items.isEmpty) {
      return _buildEmptyCart();
    }

    final totalAmount = cart.items.fold<double>(0.0, (double sum, CartItem item) {
      final price = item.finalPrice ?? item.price;
      return sum + (price * item.qty);
    });

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Teslimat Adresi
                _buildAddressSection(currentAddress),
                const SizedBox(height: 24),

                // Ürünler
                _buildProductsSection(cart.items),
                const SizedBox(height: 24),

                // Sipariş Özeti
                _buildOrderSummary(cart.items, totalAmount),
              ],
            ),
          ),
        ),

        // Alt Bar - Ödeme Butonu
        _buildBottomBar(totalAmount, checkoutState, cart),
      ],
    );
  }

  Widget _buildAddressSection(Address? currentAddress) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: AppTheme.primaryOrange),
              const SizedBox(width: 8),
              const Text(
                'Teslimat Adresi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (currentAddress != null)
                TextButton(
                  onPressed: () {
                    // Adres değiştirme sayfasına git
                    Navigator.pop(context);
                  },
                  child: const Text('Değiştir'),
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (currentAddress != null) ...[
            Text(
              currentAddress.label ?? 'Adres',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _buildAddressString(currentAddress),
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ] else ...[
            const Text(
              'Lütfen teslimat adresi ekleyin',
              style: TextStyle(
                color: AppTheme.errorRed,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _buildAddressString(Address address) {
    final parts = <String>[
      if (address.street != null) address.street!,
      if (address.buildingNo != null) 'No: ${address.buildingNo}',
      if (address.apartment != null) 'Daire: ${address.apartment}',
      if (address.neighborhood != null) address.neighborhood!,
      if (address.district != null) address.district!,
      if (address.city != null) address.city!,
    ];
    return parts.join(', ');
  }

  Widget _buildProductsSection(List<CartItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ürünler',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...items.map<Widget>((item) => _buildProductItem(item)).toList(),
      ],
    );
  }

  Widget _buildProductItem(CartItem item) {
    final price = item.finalPrice ?? item.price;
    final hasDiscount = item.finalPrice != null && item.finalPrice! < item.price;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          // Ürün resmi
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white.withOpacity(0.1),
            ),
            child: item.image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.image_not_supported,
                        color: Colors.white54,
                      ),
                    ),
                  )
                : const Icon(Icons.image_not_supported, color: Colors.white54),
          ),
          const SizedBox(width: 12),
          // Ürün bilgileri
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.qty} adet',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Fiyat
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatPrice(price * item.qty),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (hasDiscount)
                Text(
                  formatPrice(item.price * item.qty),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(List<CartItem> items, double totalAmount) {
    final itemCount = items.fold<int>(0, (int sum, CartItem item) => sum + item.qty);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryOrange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryOrange.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          _buildSummaryRow('Ürün Sayısı', '$itemCount adet'),
          const SizedBox(height: 8),
          _buildSummaryRow('Ara Toplam', formatPrice(totalAmount)),
          const SizedBox(height: 8),
          _buildSummaryRow('Kargo', 'Ücretsiz', valueColor: Colors.green),
          const Divider(color: Colors.white24, height: 24),
          _buildSummaryRow(
            'Toplam',
            formatPrice(totalAmount),
            isBold: true,
            valueColor: AppTheme.primaryOrange,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isBold = false, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? Colors.white,
            fontSize: isBold ? 18 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(double totalAmount, CheckoutState checkoutState, Cart cart) {
    final isLoading = checkoutState.status == CheckoutStatus.creatingOrder ||
        checkoutState.status == CheckoutStatus.initializingPayment ||
        checkoutState.status == CheckoutStatus.verifyingPayment;

    final currentAddress = ref.watch(currentAddressDataProvider);
    final hasAddress = currentAddress != null;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: AppTheme.primaryOrange.withOpacity(0.3)),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryOrange.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Toplam',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  formatPrice(totalAmount),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading || !hasAddress
                    ? null
                    : () => _startCheckout(cart),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryOrange,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey[800],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        hasAddress ? 'Ödemeye Geç' : 'Önce Adres Ekleyin',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 64,
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          const Text(
            'Sepetiniz boş',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Mağazaya Dön'),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: AppTheme.errorRed),
          const SizedBox(height: 16),
          Text(
            error,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Geri Dön'),
          ),
        ],
      ),
    );
  }

  void _startCheckout(cart) {
    ref.read(checkoutProvider.notifier).startCheckout(cart: cart);
  }

  void _navigateToPayment(PayTRInitResponse paytrResponse) async {
    await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => PayTRWebViewPage(paytrResponse: paytrResponse),
      ),
    );
    // verifyPayment zaten WebView içinde çağrıldı ve beklendi
    // Durum listener tarafından yakalanacak (completed veya failed)
  }

  void _showSuccessDialog() {
    final orderId = ref.read(checkoutProvider).orderId;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.grey[900],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 64,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Sipariş Onaylandı!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Ödemeniz alındı ve siparişiniz başarıyla oluşturuldu.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            if (orderId != null) ...[
              const SizedBox(height: 8),
              Text(
                'Sipariş No: $orderId',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext); // Dialog'u kapat
                    NavigationService.navigateToHomeTab(0); // Ana sayfaya dön
                  },
                  child: const Text('Ana Sayfa'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext); // Dialog'u kapat
                    // CheckoutPage'i kapat ve ana sayfaya dön, profile tab'ına geç (siparişler orada)
                    NavigationService.navigateToHomeTab(4);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryOrange,
                  ),
                  child: const Text(
                    'Siparişlerim',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.errorRed,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Tekrar Dene',
          textColor: Colors.white,
          onPressed: () {
            final cart = ref.read(cartProvider).valueOrNull;
            if (cart != null) {
              ref.read(checkoutProvider.notifier).reset();
              _startCheckout(cart);
            }
          },
        ),
      ),
    );
  }
}

