import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/models/order_model.dart';
import '../../providers/orders_provider.dart';

class OrderDetailPage extends ConsumerStatefulWidget {
  final String orderId;

  const OrderDetailPage({super.key, required this.orderId});

  @override
  ConsumerState<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends ConsumerState<OrderDetailPage> {
  @override
  void initState() {
    super.initState();
    // Load order detail when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderDetailProvider.notifier).loadOrderDetail(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderAsync = ref.watch(orderDetailProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sipariş #${widget.orderId.substring(0, 8)}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(orderDetailProvider.notifier).refresh(),
          ),
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () =>
                ref.read(orderDetailProvider.notifier).syncStatus(),
            tooltip: 'Durumu Güncelle',
          ),
        ],
      ),
      body: orderAsync.when(
        data: (order) => _buildOrderDetail(context, ref, order),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            _buildErrorState(context, ref, error.toString()),
      ),
    );
  }

  Widget _buildOrderDetail(BuildContext context, WidgetRef ref, Order order) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Card
          _buildStatusCard(context, order),
          const SizedBox(height: 16),

          // Tracking Info
          if (order.trackingNumber != null) ...[
            _buildTrackingCard(context, order),
            const SizedBox(height: 16),
          ],

          // Items List
          _buildItemsCard(context, order),
          const SizedBox(height: 16),

          // Address Info
          _buildAddressCard(context, order),
          const SizedBox(height: 16),

          // Totals
          if (order.totals != null) ...[
            _buildTotalsCard(context, order),
            const SizedBox(height: 16),
          ],

          // Notes
          if (order.note != null && order.note!.isNotEmpty) ...[
            _buildNotesCard(context, order),
            const SizedBox(height: 16),
          ],

          // Order Info
          _buildOrderInfoCard(context, order),
        ],
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, Order order) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sipariş Durumu',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildStatusChip(order.status),
                const Spacer(),
                if (order.status != const OrderStatus.teslimEdildi() &&
                    order.status != const OrderStatus.iptal())
                  ElevatedButton.icon(
                    onPressed: () =>
                        ref.read(orderDetailProvider.notifier).syncStatus(),
                    icon: const Icon(Icons.sync, size: 16),
                    label: const Text('Güncelle'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingCard(BuildContext context, Order order) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kargo Bilgileri',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.local_shipping,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.shippingProvider ?? 'Aras Kargo',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Takip No: ${order.trackingNumber}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (order.trackingNumber != null &&
                    !order.trackingNumber!.startsWith('FAKE-'))
                  IconButton(
                    icon: const Icon(Icons.open_in_new),
                    onPressed: () {
                      // TODO: Open tracking URL
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Takip sayfası yakında eklenecek')),
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsCard(BuildContext context, Order order) {
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
            ...order.items.map((item) => _buildOrderItem(context, item)),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, OrderItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Product image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: item.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl!,
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
                : const Icon(Icons.image_not_supported),
          ),
          const SizedBox(width: 12),
          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
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
          // Price
          Text(
            '₺${(item.total ?? item.price * item.quantity).toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, Order order) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Teslimat Adresi',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (order.address.name != null)
                        Text(
                          order.address.name!,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        _formatAddress(order.address),
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalsCard(BuildContext context, Order order) {
    final totals = order.totals!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sipariş Özeti',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildTotalRow('Ara Toplam', totals.subtotal),
            if (totals.discount > 0)
              _buildTotalRow('İndirim', -totals.discount, isDiscount: true),
            if (totals.shipping > 0) _buildTotalRow('Kargo', totals.shipping),
            if (totals.tax > 0) _buildTotalRow('KDV', totals.tax),
            const Divider(),
            _buildTotalRow(
              'Toplam',
              totals.grandTotal,
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount,
      {bool isDiscount = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.green : null,
            ),
          ),
          Text(
            '₺${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDiscount
                  ? Colors.green
                  : (isTotal ? Theme.of(context).primaryColor : null),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesCard(BuildContext context, Order order) {
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
            Text(
              order.note!,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoCard(BuildContext context, Order order) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sipariş Bilgileri',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Sipariş No', order.id),
            if (order.integrationCode != null)
              _buildInfoRow('Entegrasyon Kodu', order.integrationCode!),
            _buildInfoRow('Sipariş Tarihi', _formatDateTime(order.createdAt)),
            if (order.updatedAt != null)
              _buildInfoRow('Son Güncelleme', _formatDateTime(order.updatedAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
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

  Widget _buildStatusChip(OrderStatus status) {
    Color chipColor = Colors.grey; // Default color
    Color textColor = Colors.white;

    switch (status) {
      case OrderStatus.hazirlaniyor:
        chipColor = Colors.orange;
        break;
      case OrderStatus.siparisAlindi:
        chipColor = Colors.blue;
        break;
      case OrderStatus.kargoyaVerildi:
        chipColor = Colors.purple;
        break;
      case OrderStatus.yolda:
        chipColor = Colors.indigo;
        break;
      case OrderStatus.dagitimda:
        chipColor = Colors.teal;
        break;
      case OrderStatus.teslimEdildi:
        chipColor = Colors.green;
        break;
      case OrderStatus.iptal:
        chipColor = Colors.red;
        break;
      case OrderStatus.iade:
        chipColor = Colors.grey;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
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
            'Sipariş detayları yüklenemedi',
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
            onPressed: () => ref.read(orderDetailProvider.notifier).refresh(),
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  String _formatAddress(Address address) {
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

  String _formatDateTime(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
