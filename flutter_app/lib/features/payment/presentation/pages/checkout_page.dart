import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/order_model.dart';
import '../../../../core/models/payment_model.dart';
import '../../../../core/models/paytr_model.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../addresses/presentation/pages/add_address_page.dart';
import '../../../addresses/providers/addresses_provider.dart';
import '../../../cart/providers/cart_provider.dart';
import '../../providers/payment_provider.dart';
import '../../providers/installment_provider.dart';
import '../widgets/installment_selection_widget.dart';
import 'paytr_direct_form_page.dart';

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
  bool _isPayTRFormOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(currentAddressDataProvider);
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<CheckoutState>(
      checkoutProvider,
      (previous, next) {
        if (!mounted) return;

        final movedToPaytr = next.requiresPayTR &&
            next.paytrInit != null &&
            next.checkoutId != null &&
            (!_isPayTRFormOpen ||
                previous?.checkoutId != next.checkoutId ||
                previous?.stage != next.stage);

        if (movedToPaytr) {
          _openPayTRForm(next.paytrInit!, next.checkoutId!);
        }

        if (previous?.stage != next.stage &&
            next.stage == CheckoutStage.failed &&
            next.errorMessage != null) {
          SnackBarService.showSnackBar(
            context: context,
            snackBar: SnackBar(
              content: Text(next.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );

    final checkoutState = ref.watch(checkoutProvider);
    final isProcessing = checkoutState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Siparişi Tamamla'),
      ),
      body: _buildBody(context, ref, checkoutState),
      bottomNavigationBar: (!isProcessing &&
              (checkoutState.stage == CheckoutStage.idle ||
                  checkoutState.stage == CheckoutStage.failed))
          ? _buildCheckoutButton(context, ref)
          : null,
    );
  }

  Widget _buildBody(
      BuildContext context, WidgetRef ref, CheckoutState checkoutState) {
    switch (checkoutState.stage) {
      case CheckoutStage.idle:
        return _buildCheckoutForm(context, ref);
      case CheckoutStage.loading:
        return _buildLoadingState(
          context,
          title: 'Siparişiniz hazırlanıyor',
          subtitle: 'Lütfen bekleyin, ödeme adımına yönlendirileceksiniz.',
        );
      case CheckoutStage.awaitingPayment:
        return _buildPendingPaymentState(context, ref, checkoutState);
      case CheckoutStage.awaitingConfirmation:
        return _buildAwaitingConfirmationState(context, ref, checkoutState);
      case CheckoutStage.completed:
        return _buildSuccessState(context, checkoutState.order);
      case CheckoutStage.failed:
        return _buildErrorState(
          context,
          checkoutState.errorMessage ?? 'İşlem sırasında bir hata oluştu.',
        );
    }
  }

  Widget _buildLoadingState(
    BuildContext context, {
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAwaitingConfirmationState(
    BuildContext context,
    WidgetRef ref,
    CheckoutState checkoutState,
  ) {
    final isTimedOut = checkoutState.pollTimedOut;
    final checkoutId = checkoutState.checkoutId;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Ödeme doğrulanıyor',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              isTimedOut
                  ? 'PayTR doğrulaması beklenenden uzun sürdü. Siparişinizi kontrol etmeye devam ediyoruz.'
                  : 'Ödemeniz PayTR tarafından doğrulanıyor...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            if (isTimedOut) ...[
              const SizedBox(height: 16),
              Text(
                'Bu durum genellikle birkaç dakika içinde sonuçlanır. Aşağıdan durumu yeniden kontrol edebilir veya Siparişlerim sayfasına gidebilirsiniz.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[700],
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: checkoutId == null
                    ? null
                    : () {
                        ref
                            .read(checkoutProvider.notifier)
                            .retryPaymentStatusCheck();
                      },
                icon: const Icon(Icons.refresh),
                label: const Text('Durumu Yeniden Kontrol Et'),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                icon: const Icon(Icons.receipt_long_outlined),
                label: const Text('Siparişlerimi Görüntüle'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, Order? order) {
    if (order == null) {
      return _buildLoadingState(
        context,
        title: 'Siparişiniz tamamlanıyor',
        subtitle: 'Sipariş detayları yükleniyor...',
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            Text(
              'Siparişiniz Başarıyla Alındı!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
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
                        'Sipariş No', (order.id ?? '').substring(0, 8)),
                    _buildOrderDetailRow('Toplam Tutar',
                        '₺${order.totals?.grandTotal?.toStringAsFixed(2) ?? '0.00'}'),
                    _buildOrderDetailRow('Durum', order.status.displayName),
                    if (order.trackingNumber != null)
                      _buildOrderDetailRow('Takip No', order.trackingNumber!),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text('Ana Sayfaya Dön'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      // TODO: Order detay sayfasına yönlendir
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

  Widget _buildErrorState(BuildContext context, String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              errorMessage,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ref.read(checkoutProvider.notifier).reset();
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

    // Calculate total amount for installment widget
    final totalAmount = cartItems.fold<double>(
      0.0,
      (sum, item) => sum + ((item.finalPrice ?? item.price) * item.qty),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAddressSection(context, ref, currentAddress),
          const SizedBox(height: 24),
          _buildPaymentMethodSection(context),
          const SizedBox(height: 24),
          // Installment selection widget (only for card payments)
          if (widget.paymentMethod == const PaymentMethod.creditCard() ||
              widget.paymentMethod == const PaymentMethod.debitCard()) ...[
            InstallmentSelectionWidget(
              baseAmount: totalAmount,
            ),
            const SizedBox(height: 24),
          ],
          _buildCartItemsSection(context, cartItems),
          const SizedBox(height: 24),
          _buildOrderNoteSection(),
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentAddress.name ?? 'Adres',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatAddress(currentAddress),
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _showAddressSelectionDialog(context, ref);
                    },
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Değiştir'),
                  ),
                ],
              ),
            ] else ...[
              Text(
                'Aktif adres bulunamadı',
                style: TextStyle(color: Colors.red[600]),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddAddressPage(),
                          ),
                        );
                        ref.invalidate(currentAddressDataProvider);
                      },
                      icon: const Icon(Icons.add_location),
                      label: const Text('Adres Ekle'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _showAddressSelectionDialog(context, ref);
                      },
                      icon: const Icon(Icons.list),
                      label: const Text('Adres Seç'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSection(BuildContext context) {
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

  Widget _buildCartItemsSection(BuildContext context, List<dynamic> cartItems) {
    final totalAmount = cartItems.fold<double>(
      0.0,
      (sum, item) => sum + ((item.finalPrice ?? item.price) * item.qty),
    );

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
                  '₺${totalAmount.toStringAsFixed(2)}',
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
            child: item.image != null && item.image!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.image!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                    ),
                  )
                : const Icon(Icons.image_not_supported),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title ?? 'Ürün',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  'Adet: ${item.qty}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '₺${((item.finalPrice ?? item.price) * item.qty).toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderNoteSection() {
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

  Widget _buildCheckoutButton(BuildContext context, WidgetRef ref) {
    final currentAddress = ref.watch(currentAddressDataProvider);
    final cartItems = ref.watch(cartItemsProvider);

    final totalAmount = cartItems.fold<double>(
      0.0,
      (sum, item) => sum + ((item.finalPrice ?? item.price) * item.qty),
    );

    final canCheckout = currentAddress != null && cartItems.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
            onPressed: canCheckout ? () => _startCheckout(context, ref) : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              canCheckout
                  ? 'Siparişi Tamamla - ₺${totalAmount.toStringAsFixed(2)}'
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

  Widget _buildPendingPaymentState(
      BuildContext context, WidgetRef ref, CheckoutState checkoutState) {
    final cartItems = ref.watch(cartItemsProvider);
    final order = checkoutState.order;
    final orderItems = order?.items;
    final totalAmount = order?.totals?.grandTotal ??
        cartItems.fold<double>(
          0.0,
          (sum, item) => sum + ((item.finalPrice ?? item.price) * item.qty),
        );
    final paymentStatusLabel =
        checkoutState.paymentStatus?.displayName ?? 'Bekleniyor';
    final pollInfo = checkoutState.pollAttempts > 0
        ? ' (Kontrol ${checkoutState.pollAttempts}. deneme)'
        : '';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lock_clock,
                color: Colors.orange,
                size: 42,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Ödeme Bekleniyor',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[700],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Ödeme durumu: $paymentStatusLabel$pollInfo\n'
              'Ödeme formu açılmalı ve kart bilgilerinizi girmeniz gerekiyor. '
              'Form kapanırsa yeniden açmak için aşağıdaki butonu kullanabilirsiniz.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sepet Özeti',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    if (order != null) ...[
                      _buildOrderDetailRow(
                          'Sipariş No', (order.id ?? '').substring(0, 8)),
                    ],
                    ...(orderItems != null && orderItems.isNotEmpty
                        ? orderItems.map(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${item.name ?? item.title ?? 'Ürün'} x${item.quantity ?? 1}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    '₺${_orderItemTotal(item).toStringAsFixed(2)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : cartItems.map(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${item.title} x${item.qty}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    '₺${((item.finalPrice ?? item.price) * item.qty).toStringAsFixed(2)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Toplam',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '₺${totalAmount.toStringAsFixed(2)}',
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
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                final checkoutState = ref.read(checkoutProvider);
                final init = checkoutState.paytrInit;
                final checkoutId = checkoutState.checkoutId;
                if (init != null && checkoutId != null) {
                  _openPayTRForm(init, checkoutId);
                }
              },
              icon: const Icon(Icons.credit_card),
              label: const Text('Ödeme Formunu Yeniden Aç'),
            ),
            const SizedBox(height: 12),
            if (checkoutState.pollTimedOut)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'Ödeme doğrulaması zaman aşımına uğradı. Siparişlerim sayfasından durumu kontrol edebilirsiniz.',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.red[700]),
                  textAlign: TextAlign.center,
                ),
              ),
            TextButton(
              onPressed: () {
                ref.read(checkoutProvider.notifier).reset();
              },
              child: const Text('Sepete Geri Dön'),
            ),
          ],
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

  double _orderItemTotal(OrderItem item) {
    final quantity = item.quantity ?? 1;
    if (item.total != null) return item.total!;
    if (item.lineTotal != null) return item.lineTotal!;
    final unitPrice = item.price ?? item.unitPrice ?? 0;
    return unitPrice * quantity;
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
    );
  }

  Future<void> _startCheckout(BuildContext context, WidgetRef ref) async {
    final note = _noteController.text.trim().isEmpty
        ? null
        : _noteController.text.trim();

    // Get selected installment count (defaults to 0 = single payment)
    final selectedInstallmentCount =
        ref.read(selectedInstallmentCountProvider);

    try {
      await ref.read(checkoutProvider.notifier).startCheckout(
            paymentMethod: widget.paymentMethod,
            orderNote: note,
            installmentCount: selectedInstallmentCount,
          );
    } catch (e) {
      if (!mounted) return;
      SnackBarService.showSnackBar(
        context: context,
        snackBar: SnackBar(
          content: Text('Ödeme hazırlığı başarısız: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _openPayTRForm(
      PayTRDirectInitResponse response, String checkoutId) async {
    _isPayTRFormOpen = true;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PayTRDirectFormPage(
          checkoutId: checkoutId,
          initResponse: response,
        ),
      ),
    );

    if (!mounted) return;
    _isPayTRFormOpen = false;
  }

  void _showAddressSelectionDialog(BuildContext parentContext, WidgetRef ref) {
    final addressesAsync = ref.watch(addressesProvider);

    showDialog(
      context: parentContext,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Teslimat Adresi Seç'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: addressesAsync.when(
            data: (addresses) => addresses.isEmpty
                ? const Center(
                    child: Text('Henüz adres eklenmemiş'),
                  )
                : ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Text(address.name ?? 'Adres'),
                          subtitle: Text(_formatAddress(address)),
                          trailing: IconButton(
                            icon: const Icon(Icons.check_circle),
                            onPressed: () async {
                              try {
                                await ref
                                    .read(currentAddressProvider.notifier)
                                    .setCurrentAddress(address.id!);

                                if (!mounted) return;
                                Navigator.of(dialogContext).pop();
                                SnackBarService.showSnackBar(
                                  context: parentContext,
                                  snackBar: const SnackBar(
                                    content: Text('Teslimat adresi seçildi'),
                                  ),
                                );
                              } catch (e) {
                                if (!mounted) return;
                                SnackBarService.showSnackBar(
                                  context: parentContext,
                                  snackBar: SnackBar(
                                    content: Text('Hata: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text('Hata: $error'),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('İptal'),
          ),
        ],
      ),
    );
  }
}
