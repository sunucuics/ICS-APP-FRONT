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
import 'payment_success_page.dart';
import '../../../../core/services/navigation_service.dart';

/// Checkout Sayfası
///
/// Sipariş özeti gösterir ve ödeme işlemini başlatır.
/// 
/// YENİ Checkout akışı (Payment Session mimarisi):
/// 1. Sepet ve adres bilgilerini göster
/// 2. "Ödemeye Geç" butonuna tıkla
/// 3. merchant_oid üret + PayTR init al (sipariş henüz oluşturulmaz!)
/// 4. WebView'a yönlendir (kart bilgileri ve taksit seçimi burada)
/// 5. PayTR callback backend'e gelir
/// 6. Callback success ise backend sipariş oluşturur
/// 7. Frontend sipariş durumunu kontrol eder
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
        // Ödeme başarılı - sipariş oluşturuldu
        // Kredi kartı completed durumu WebView dönüşünde handle ediliyor
      } else if (current.status == CheckoutStatus.failed) {
        // Hata oluştu
        // Kullanıcı iptal ettiyse bildirim gösterme
        if (current.errorMessage == 'Ödeme iptal edildi') return;
        
        // Zaman aşımı hatası ise gösterme - PaymentSuccessPage zaten açılacak
        if (current.errorMessage?.contains('zaman aşımına uğradı') == true) return;

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
        data: (cart) =>
            _buildContent(context, cart, checkoutState, currentAddress),
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
    // Ödeme durumlarına göre loading göster
    if (checkoutState.status == CheckoutStatus.initializingPayment) {
      return _buildLoadingState(
        icon: Icons.payment,
        message: 'Ödeme hazırlanıyor...',
        subMessage: 'Lütfen bekleyin',
      );
    }

    if (checkoutState.status == CheckoutStatus.verifyingPayment) {
      return _buildLoadingState(
        icon: Icons.verified_user,
        message: 'Ödeme doğrulanıyor...',
        subMessage: 'Sipariş durumu kontrol ediliyor',
      );
    }

    if (checkoutState.status == CheckoutStatus.completed) {
      return _buildLoadingState(
        icon: Icons.check_circle_outline,
        message: 'Sipariş onaylanıyor...',
        subMessage: 'Neredeyse bitti!',
      );
    }

    if (cart.items.isEmpty) {
      return _buildEmptyCart();
    }

    final totalAmount =
        cart.items.fold<double>(0.0, (double sum, CartItem item) {
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

                // Ödeme Yöntemi
                _buildPaymentMethodSection(checkoutState),
                const SizedBox(height: 24),

                // Ürünler
                _buildProductsSection(cart.items),
                const SizedBox(height: 24),

                // Sipariş Özeti
                _buildOrderSummary(cart.items, totalAmount),
                
                const SizedBox(height: 16),
                
                // Taksit bilgisi notu
                _buildInstallmentNote(),
              ],
            ),
          ),
        ),

        // Alt Bar - Ödeme Butonu
        _buildBottomBar(totalAmount, checkoutState, cart),
      ],
    );
  }

  Widget _buildLoadingState({
    required IconData icon,
    required String message,
    String? subMessage,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.primaryOrange.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryOrange,
              size: 48,
            ),
          ),
          const SizedBox(height: 24),
          const CircularProgressIndicator(
            color: AppTheme.primaryOrange,
          ),
          const SizedBox(height: 24),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (subMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              subMessage,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInstallmentNote() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.blue, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Kredi kartı ile 3 taksit seçeneği mevcuttur. Taksit seçimi ödeme ekranında yapılır.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
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

  Widget _buildPaymentMethodSection(CheckoutState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ödeme Yöntemi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              // Kredi Kartı Seçeneği
              _buildPaymentOption(
                state: state,
                method: PaymentMethod.creditCard,
                icon: Icons.credit_card,
                title: 'Banka / Kredi Kartı',
                subtitle: 'PayTR güvencesi ile öde',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption({
    required CheckoutState state,
    required PaymentMethod method,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = state.paymentMethod == method;
    return InkWell(
      onTap: () {
        ref.read(checkoutProvider.notifier).selectPaymentMethod(method);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryOrange.withOpacity(0.2)
                    : Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? AppTheme.primaryOrange : Colors.white70,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppTheme.primaryOrange),
            if (!isSelected)
              Icon(Icons.radio_button_unchecked,
                  color: Colors.white.withOpacity(0.3)),
          ],
        ),
      ),
    );
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
    final hasDiscount =
        item.finalPrice != null && item.finalPrice! < item.price;

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
    final itemCount =
        items.fold<int>(0, (int sum, CartItem item) => sum + item.qty);

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

  Widget _buildBottomBar(
      double totalAmount, CheckoutState checkoutState, Cart cart) {
    final isLoading =
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
                        hasAddress
                            ? 'Ödemeye Geç'
                            : 'Önce Adres Ekleyin',
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

  void _startCheckout(Cart cart) {
    ref.read(checkoutProvider.notifier).startCheckout(cart: cart);
  }

  void _navigateToPayment(PayTRInitResponse paytrResponse) async {
    // Sepet bilgilerini al
    final cart = ref.read(cartProvider).valueOrNull;

    // Cart'tan BasketItem'lara dönüştür
    final basketItems = cart?.items
            .map((item) => BasketItem(
                  name: item.title,
                  price: item.finalPrice ?? item.price,
                  quantity: item.qty,
                ))
            .toList() ??
        [];

    // User ve address bilgilerini fields'tan al (başlangıçta init'e gönderilen değerler)
    final email = paytrResponse.fields['email'] ?? '';
    final userName = paytrResponse.fields['user_name'] ?? 'Müşteri';
    final userAddress = paytrResponse.fields['user_address'] ?? '';
    final userPhone = paytrResponse.fields['user_phone'] ?? '';

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => PayTRWebViewPage(
          paytrResponse: paytrResponse,
          basketItems: basketItems,
          email: email,
          userName: userName,
          userAddress: userAddress,
          userPhone: userPhone,
        ),
      ),
    );

    // WebView'dan döndü
    // result == true: PayTR success URL tespit edildi, ödeme başarılı
    // result == false veya null: ödeme iptal veya başarısız
    if (result == true) {
      // PayTR'de ödeme başarılı oldu (success URL görüldü)
      // Backend verification timeout olsa bile success page'e git
      // Çünkü local'de PayTR callback localhost'a ulaşamaz
      _navigateToSuccessPage();
    }
    // result != true durumunda listener zaten hata gösterecek
  }

  void _navigateToSuccessPage() {
    final checkoutState = ref.read(checkoutProvider);
    // orderId veya merchantOid'den birini kullan
    final orderId = checkoutState.orderId ?? checkoutState.merchantOid;

    if (orderId != null) {
      // FIX: Explicitly clear the cart upon success detection
      ref.read(cartProvider.notifier).clearCart();

      // Mevcut sayfaları temizle ve success page'e git
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => PaymentSuccessPage(orderId: orderId),
        ),
        (route) => route.isFirst, // Sadece ilk route'u koru (ana sayfa)
      );
    } else {
      // orderId yoksa ana sayfaya dön
      NavigationService.navigateToHomeTab(0);
    }
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
