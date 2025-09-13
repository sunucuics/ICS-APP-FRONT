import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/payment_model.dart';
import '../../../../core/models/order_model.dart';
import '../../providers/payment_provider.dart';
import '../../../addresses/providers/addresses_provider.dart';
import '../../../cart/providers/cart_provider.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  final PaymentMethod paymentMethod;
  final double totalAmount;

  const CheckoutPage({
    super.key,
    required this.paymentMethod,
    required this.totalAmount,
  });

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  final _noteController = TextEditingController();
  bool _simulateSuccess = true;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentAddress = ref.watch(currentAddressDataProvider);
    final cartItems = ref.watch(cartItemsProvider);
    final checkoutAsync = ref.watch(checkoutProvider);
    final isProcessing = ref.watch(isCheckoutProcessingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Siparişi Tamamla'),
      ),
      body: checkoutAsync.when(
        data: (order) => _buildSuccessState(context, ref, order),
        loading: () => _buildLoadingState(context, ref),
        error: (error, stack) =>
            _buildErrorState(context, ref, error.toString()),
      ),
      bottomNavigationBar:
          !isProcessing ? _buildCheckoutButton(context, ref) : null,
    );
  }

  Widget _buildLoadingState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Siparişiniz işleniyor...',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Lütfen bekleyin, ödeme işlemi gerçekleştiriliyor.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, WidgetRef ref, Order? order) {
    if (order == null) {
      return _buildCheckoutForm(context, ref);
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Success Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),

            // Success Message
            Text(
              'Siparişiniz Başarıyla Alındı!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Order Details
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sipariş Detayları',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildOrderDetailRow(
                        'Sipariş No', order.id.substring(0, 8)),
                    _buildOrderDetailRow('Toplam Tutar',
                        '₺${order.totals?.grandTotal.toStringAsFixed(2) ?? '0.00'}'),
                    _buildOrderDetailRow(
                        'Ödeme Yöntemi', widget.paymentMethod.displayName),
                    _buildOrderDetailRow('Durum', order.status.displayName),
                    if (order.trackingNumber != null)
                      _buildOrderDetailRow('Takip No', order.trackingNumber!),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigate to orders list
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text('Ana Sayfaya Dön'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to order detail
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      // TODO: Navigate to order detail page
                    },
                    child: const Text('Siparişi Görüntüle'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),

            // Error Message
            Text(
              'Sipariş Alınamadı',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            Text(
              error,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Retry Button
            ElevatedButton(
              onPressed: () {
                ref.read(checkoutProvider.notifier).clearState();
              },
              child: const Text('Tekrar Dene'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutForm(BuildContext context, WidgetRef ref) {
    final currentAddress = ref.watch(currentAddressDataProvider);
    final cartItems = ref.watch(cartItemsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Address Section
          _buildAddressSection(context, ref, currentAddress),
          const SizedBox(height: 24),

          // Payment Method Section
          _buildPaymentMethodSection(context, ref),
          const SizedBox(height: 24),

          // Cart Items Section
          _buildCartItemsSection(context, ref, cartItems),
          const SizedBox(height: 24),

          // Order Note Section
          _buildOrderNoteSection(context, ref),
          const SizedBox(height: 24),

          // Test Options Section
          _buildTestOptionsSection(context, ref),
        ],
      ),
    );
  }

  Widget _buildAddressSection(
      BuildContext context, WidgetRef ref, dynamic currentAddress) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Teslimat Adresi',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (currentAddress != null) ...[
              Text(
                currentAddress.name ?? 'Adres',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                _formatAddress(currentAddress),
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ] else ...[
              Text(
                'Aktif adres bulunamadı',
                style: TextStyle(
                  color: Colors.red[600],
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to addresses page
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.add_location),
                label: const Text('Adres Ekle'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSection(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.paymentMethod.icon,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 8),
                Text(
                  'Ödeme Yöntemi',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.paymentMethod.displayName,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              _getPaymentMethodDescription(widget.paymentMethod),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItemsSection(
      BuildContext context, WidgetRef ref, List<dynamic> cartItems) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sipariş İçeriği',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ...cartItems.map((item) => _buildCartItem(context, item)),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Toplam',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '₺${widget.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, dynamic item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: const Icon(Icons.image_not_supported),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? 'Ürün',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  'Adet: ${item.quantity}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '₺${(item.price * item.quantity).toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderNoteSection(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sipariş Notu',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                hintText: 'Siparişinizle ilgili notlar...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestOptionsSection(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Test Seçenekleri',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Başarılı'),
                    subtitle: const Text('Ödeme başarılı'),
                    value: true,
                    groupValue: _simulateSuccess,
                    onChanged: (value) {
                      setState(() {
                        _simulateSuccess = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Başarısız'),
                    subtitle: const Text('Ödeme başarısız'),
                    value: false,
                    groupValue: _simulateSuccess,
                    onChanged: (value) {
                      setState(() {
                        _simulateSuccess = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context, WidgetRef ref) {
    final currentAddress = ref.watch(currentAddressDataProvider);
    final cartItems = ref.watch(cartItemsProvider);

    final canCheckout = currentAddress != null && cartItems.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                canCheckout ? () => _processCheckout(context, ref) : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              canCheckout
                  ? 'Siparişi Tamamla - ₺${widget.totalAmount.toStringAsFixed(2)}'
                  : 'Adres ve Sepet Kontrolü Gerekli',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  String _formatAddress(dynamic address) {
    final parts = <String>[];

    if (address.street != null) parts.add(address.street!);
    if (address.buildingNo != null) parts.add('No: ${address.buildingNo}');
    if (address.apartment != null) parts.add('Daire: ${address.apartment}');
    if (address.floor != null) parts.add('Kat: ${address.floor}');
    if (address.neighborhood != null) parts.add(address.neighborhood!);
    if (address.district != null) parts.add(address.district!);
    if (address.city != null) parts.add(address.city!);
    if (address.zipCode != null) parts.add(address.zipCode!);

    return parts.join(', ');
  }

  String _getPaymentMethodDescription(PaymentMethod method) {
    return method.when(
      creditCard: () => 'Kredi kartı ile güvenli ödeme',
      debitCard: () => 'Banka kartı ile hızlı ödeme',
      bankTransfer: () => 'Banka havalesi ile ödeme',
      cashOnDelivery: () => 'Kapıda nakit ödeme',
      digitalWallet: () => 'Dijital cüzdan ile ödeme',
      mock: () => 'Test ödeme sistemi (Geliştirme)',
    );
  }

  Future<void> _processCheckout(BuildContext context, WidgetRef ref) async {
    final order = await ref.read(checkoutProvider.notifier).processCheckout(
          paymentMethod: widget.paymentMethod,
          orderNote: _noteController.text.trim().isEmpty
              ? null
              : _noteController.text.trim(),
          simulatePaymentSuccess: _simulateSuccess,
        );

    if (order != null && context.mounted) {
      // Success is handled in the build method
    }
  }
}
