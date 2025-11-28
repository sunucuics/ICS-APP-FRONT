import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/models/order_model.dart';
import '../../providers/orders_provider.dart';
import 'order_detail_page.dart';

class OrdersListPage extends ConsumerWidget {
  const OrdersListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Siparişlerim'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(ordersProvider.notifier).refresh(),
          ),
        ],
      ),
      body: ordersAsync.when(
        data: (ordersResponse) =>
            _buildOrdersContent(context, ref, ordersResponse),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            _buildErrorState(context, ref, error.toString()),
      ),
    );
  }

  Widget _buildOrdersContent(
      BuildContext context, WidgetRef ref, OrdersListResponse ordersResponse) {
    if (ordersResponse.items.isEmpty) {
      return _buildEmptyState(context);
    }

    // Filter orders by status
    final preparingOrders = ordersResponse.items.where((order) => 
        order.status == const OrderStatus.preparing()).toList();
    final shippedOrders = ordersResponse.items.where((order) => 
        order.status == const OrderStatus.shipped()).toList();
    final deliveredOrders = ordersResponse.items.where((order) => 
        order.status == const OrderStatus.delivered()).toList();

    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: 'Tümü',
                icon: Icon(Icons.list),
              ),
              Tab(
                text: 'Hazırlanıyor',
                icon: Icon(Icons.shopping_bag),
              ),
              Tab(
                text: 'Kargoda',
                icon: Icon(Icons.local_shipping),
              ),
              Tab(
                text: 'Teslim Edildi',
                icon: Icon(Icons.check_circle),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildOrdersList(context, ref, ordersResponse.items, 'Sipariş bulunmuyor'),
                _buildOrdersList(context, ref, preparingOrders, 'Hazırlanan sipariş bulunmuyor'),
                _buildOrdersList(context, ref, shippedOrders, 'Kargoda sipariş bulunmuyor'),
                _buildOrdersList(context, ref, deliveredOrders, 'Teslim edilen sipariş bulunmuyor'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(BuildContext context, WidgetRef ref,
      List<Order> orders, String emptyMessage) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(ordersProvider.notifier).refresh(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _buildOrderCard(context, ref, order);
        },
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, WidgetRef ref, Order order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OrderDetailPage(orderId: order.id ?? ''),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sipariş #${(order.id ?? '').substring(0, 8)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Row(
                    children: [
                      if (order.payment != null) _buildPaymentStatusChip(order.payment!['status'] as String? ?? 'unknown'),
                      const SizedBox(width: 8),
                      _buildStatusChip(order.status),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Items preview
              if (order.items?.isNotEmpty == true) ...[
                Row(
                  children: [
                    // First item image
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      child: order.items?.isNotEmpty == true &&
                              _getFirstItemImage(order.items!.first) != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl:
                                    _getFirstItemImage(order.items!.first)!,
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
                    // Items info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (order.items?.length ?? 0) == 1
                                ? (order.items?.first.name ?? 'Ürün Adı Yok')
                                : '${order.items?.first.name ?? 'Ürün Adı Yok'} ve ${(order.items?.length ?? 0) - 1} ürün daha',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${order.items?.length ?? 0} ürün',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],

              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Total amount
                  if (order.totals != null)
                    Text(
                      '₺${order.totals?.grandTotal?.toStringAsFixed(2) ?? '0.00'}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    )
                  else
                    Text(
                      '₺${(order.items?.fold(0.0, (sum, item) => sum + (item.total ?? (item.price ?? 0) * (item.quantity ?? 0))) ?? 0.0).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),

                  // Date
                  Text(
                    _formatDate(order.createdAt),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              // Tracking info
              if (order.trackingNumber != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.local_shipping,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Takip No: ${order.trackingNumber}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(OrderStatus status) {
    Color chipColor = Colors.grey; // Default color
    Color textColor = Colors.white;

    switch (status) {
      case OrderStatus.preparing:
        chipColor = Colors.orange;
        break;
      case OrderStatus.shipped:
        chipColor = Colors.purple;
        break;
      case OrderStatus.delivered:
        chipColor = Colors.green;
        break;
      case OrderStatus.canceled:
        chipColor = Colors.red;
        break;
      case OrderStatus.paymentFailed:
        chipColor = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPaymentStatusChip(String paymentStatus) {
    Color chipColor;
    String displayText;
    IconData icon;

    switch (paymentStatus.toLowerCase()) {
      case 'paid':
        chipColor = Colors.green;
        displayText = 'Ödendi';
        icon = Icons.check_circle;
        break;
      case 'failed':
        chipColor = Colors.red;
        displayText = 'Başarısız';
        icon = Icons.cancel;
        break;
      case 'pending':
        chipColor = Colors.orange;
        displayText = 'Beklemede';
        icon = Icons.schedule;
        break;
      default:
        chipColor = Colors.grey;
        displayText = 'Bilinmiyor';
        icon = Icons.help;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: chipColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: chipColor,
          ),
          const SizedBox(width: 2),
          Text(
            displayText,
            style: TextStyle(
              color: chipColor,
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz siparişiniz yok',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Mağazadan ürün satın alarak başlayabilirsiniz',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to catalog tab
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.store),
            label: const Text('Mağazaya Git'),
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
            'Siparişler yüklenemedi',
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
            onPressed: () => ref.read(ordersProvider.notifier).refresh(),
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  String? _getFirstItemImage(OrderItem item) {
    // First try to get image from imageUrl field
    if (item.imageUrl != null && item.imageUrl!.isNotEmpty) {
      return item.imageUrl;
    }

    // Then try to get first image from product.images array
    if (item.product != null && item.product!['images'] != null) {
      final images = item.product!['images'] as List<dynamic>?;
      if (images != null && images.isNotEmpty) {
        return images.first as String;
      }
    }

    return null;
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Bugün';
    } else if (difference.inDays == 1) {
      return 'Dün';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} gün önce';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
