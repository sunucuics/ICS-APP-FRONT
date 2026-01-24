import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/models/order_model.dart';
import '../../providers/orders_provider.dart';
import 'order_detail_page.dart';

class OrdersListPage extends ConsumerStatefulWidget {
  const OrdersListPage({super.key});

  @override
  ConsumerState<OrdersListPage> createState() => _OrdersListPageState();
}

class _OrdersListPageState extends ConsumerState<OrdersListPage> {
  // Scroll controllers for specific tab behavior if needed
  // For now, relying on notification listener is cleaner

  @override
  void initState() {
    super.initState();
    // Refresh orders when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(activeOrdersProvider.notifier).refresh();
      ref.read(pastOrdersProvider.notifier).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Siparişlerim'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Devam Eden'),
              Tab(text: 'Geçmiş'),
            ],
          ),
          actions: [
             IconButton(
               icon: const Icon(Icons.refresh),
               onPressed: () {
                 ref.read(activeOrdersProvider.notifier).refresh();
                 ref.read(pastOrdersProvider.notifier).refresh();
               },
             ),
          ],
        ),
        body: TabBarView(
          children: [
            _buildOrdersTab(context, ref, activeOrdersProvider, 'Aktif sipariş bulunmuyor'),
            _buildOrdersTab(context, ref, pastOrdersProvider, 'Geçmiş sipariş bulunmuyor'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersTab(
    BuildContext context, 
    WidgetRef ref, 
    StateNotifierProvider<PaginatedOrdersNotifier, PaginatedOrdersState> provider, 
    String emptyMessage
  ) {
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    // Initial loading
    if (state.isLoading && state.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // Error state (only if no items)
    if (state.error != null && state.items.isEmpty) {
      return _buildErrorState(context, () => notifier.refresh(), state.error.toString());
    }

    // Empty state
    if (state.items.isEmpty) {
      return _buildEmptyState(context);
    }

    // List with pagination
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (state.hasMore && 
            !state.isLoading && 
            scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) {
          notifier.loadMore();
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () => notifier.refresh(),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: state.items.length + (state.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == state.items.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final order = state.items[index];
            return _buildOrderCard(context, ref, order);
          },
        ),
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
              builder: (context) => OrderDetailPage(orderId: order.id),
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
                    'Sipariş #${order.id.substring(0, 8)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Row(
                    children: [
                      if (order.status == const OrderStatus.preparing() && 
                          order.payment?.status == 'awaiting')
                        _buildPaymentStatusChip('Ödeme Bekliyor')
                      else
                        _buildStatusChip(order.status),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Items preview
              if (order.items.isNotEmpty) ...[
                Row(
                  children: [
                    if (_getFirstItemImage(order.items.first) != null) ...[
                      // First item image
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: _getFirstItemImage(order.items.first)!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.image_not_supported),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    // Items info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (order.items.length) == 1
                                ? (order.items.first.name)
                                : '${order.items.first.name} ve ${(order.items.length) - 1} ürün daha',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${order.items.length} ürün',
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
                   Text(
                      '₺${(order.totals.grandTotal).toStringAsFixed(2)}',
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
              if (order.shipping.trackingNumber != null) ...[
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
                      'Takip No: ${order.shipping.trackingNumber}',
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
    Color chipColor = Colors.grey;
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

  Widget _buildPaymentStatusChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
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
              // Navigate to catalog or home (pop to root)
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            icon: const Icon(Icons.store),
            label: const Text('Mağazaya Git'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, VoidCallback onRetry, String error) {
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
            onPressed: onRetry,
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  String? _getFirstItemImage(OrderItem item) {
    if (item.imageUrl != null && item.imageUrl!.isNotEmpty) {
      return item.imageUrl;
    }
    // Try to get from product object if available
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
