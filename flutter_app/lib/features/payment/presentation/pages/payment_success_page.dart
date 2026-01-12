import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/price_utils.dart';
import '../../../../core/utils/order_utils.dart';
import '../../../../core/models/order_model.dart';
import '../../../orders/providers/orders_provider.dart';
import '../../../orders/presentation/pages/orders_list_page.dart';
import '../../../../core/services/navigation_service.dart';

class PaymentSuccessPage extends ConsumerStatefulWidget {
  final String orderId;

  const PaymentSuccessPage({super.key, required this.orderId});

  @override
  ConsumerState<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends ConsumerState<PaymentSuccessPage> {
  @override
  void initState() {
    super.initState();
    // Sipariş detaylarını yükle
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderDetailProvider.notifier).loadOrderDetail(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderAsync = ref.watch(orderDetailProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PopScope(
      canPop: false, // Geri tuşunu engelle
      child: Scaffold(
        backgroundColor: colorScheme.background,
        appBar: AppBar(
          automaticallyImplyLeading: false, // Geri butonunu kaldır
          backgroundColor: colorScheme.surface,
          centerTitle: true,
          title: Text(
            'Sipariş Alındı',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: orderAsync.when(
          data: (order) => _buildContent(context, order),
          loading: () => _buildLoadingState(context),
          error: (error, stack) => _buildPendingState(context),
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: AppTheme.successGreen,
              size: 64,
            ),
          ),
          const SizedBox(height: 24),
          const CircularProgressIndicator(color: AppTheme.primaryOrange),
          const SizedBox(height: 24),
          Text(
            'Sipariş detayları yükleniyor...',
            style: TextStyle(color: colorScheme.onSurface, fontSize: 16),
          ),
        ],
      ),
    );
  }

  /// Local development'ta PayTR callback localhost'a ulaşamadığında
  /// sipariş detayları yüklenemez. Bu durumda kullanıcıya başarılı mesajı göster.
  Widget _buildPendingState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Başarı İkonu
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.successGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: AppTheme.successGreen,
                    size: 80,
                  ),
                ),
                const SizedBox(height: 24),

                Text(
                  'Teşekkürler!',
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ödemeniz başarıyla alındı.',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Sipariş No: ${widget.orderId}',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 14,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Bilgi Notu
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.withOpacity(0.3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline,
                          color: Colors.blue, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sipariş Onaylanıyor',
                              style: TextStyle(
                                color: colorScheme.onSurface,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Siparişiniz işleniyor. Sipariş detaylarını "Siparişlerim" sayfasından takip edebilirsiniz.',
                              style: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Alt Butonlar
        _buildBottomBar(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context, Order order) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Başarı İkonu
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.successGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: AppTheme.successGreen,
                    size: 80,
                  ),
                ),
                const SizedBox(height: 24),

                Text(
                  'Teşekkürler!',
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Siparişiniz başarıyla alındı.',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Sipariş No: ${order.id}',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 14,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Sipariş Özeti Kartı
                _buildSummarySection(context, order),
                const SizedBox(height: 24),

                // Teslimat Adresi
                _buildAddressSection(context, order),
                const SizedBox(height: 24),

                // Ürünler
                _buildProductsSection(context, order),
              ],
            ),
          ),
        ),

        // Alt Butonlar
        _buildBottomBar(context),
      ],
    );
  }

  Widget _buildSummarySection(BuildContext context, Order order) {
    final colorScheme = Theme.of(context).colorScheme;
    final totals = order.totals;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.primaryOrange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryOrange.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          _buildSummaryRow(context, 'Ara Toplam', totals.subtotal ?? 0),
          if ((totals.discount ?? 0) > 0)
            _buildSummaryRow(context, 'İndirim', -(totals.discount ?? 0),
                color: AppTheme.successGreen),
          _buildSummaryRow(context, 'Kargo', totals.shipping ?? 0,
              isFree: (totals.shipping ?? 0) == 0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: colorScheme.outline, height: 1),
          ),
          _buildSummaryRow(context, 'Genel Toplam', totals.grandTotal ?? 0,
              isBold: true, color: AppTheme.primaryOrange, isLarge: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, double amount,
      {bool isBold = false,
      Color? color,
      bool isFree = false,
      bool isLarge = false}) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: isLarge ? 18 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            isFree ? 'Ücretsiz' : formatPrice(amount),
            style: TextStyle(
              color: isFree ? AppTheme.successGreen : (color ?? colorScheme.onSurface),
              fontSize: isLarge ? 20 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection(BuildContext context, Order order) {
    if (order.address == null) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;
    final fullAddress = _formatAddress(order.address);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on_outlined,
                  color: AppTheme.primaryOrange, size: 20),
              const SizedBox(width: 8),
              Text(
                'Teslimat Adresi',
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            fullAddress,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  String _formatAddress(Address? address) {
    if (address == null) return '';
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

  Widget _buildProductsSection(BuildContext context, Order order) {
    final colorScheme = Theme.of(context).colorScheme;
    final items = order.items ?? [];
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ürünler',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) => _buildProductItem(context, items[index]),
        ),
      ],
    );
  }

  Widget _buildProductItem(BuildContext context, OrderItem item) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colorScheme.surfaceVariant,
            ),
            child: item.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Icon(
                          Icons.image_not_supported,
                          color: colorScheme.onSurfaceVariant),
                    ),
                  )
                : Icon(Icons.image_not_supported, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? '',
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.qty} adet',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            formatPrice((item.finalPrice ?? item.price ?? 0) * item.qty),
            style: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
            top: BorderSide(color: colorScheme.outline)),
      ),
      child: SafeArea(child: _buildActionButtons(context)),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Direkt Siparişlerim sayfasına git
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const OrdersListPage(),
                ),
                (route) => route.isFirst,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryOrange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Siparişlerim',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              // Ana sayfaya git
              NavigationService.navigateToHomeTab(0);
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: colorScheme.outline),
              ),
            ),
            child: Text(
              'Ana Sayfaya Dön',
              style: TextStyle(color: colorScheme.onSurface, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
