import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/admin_orders_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/order_model.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../core/network/exceptions/api_exception.dart';
import '../../../../core/utils/order_utils.dart';

class AdminOrdersPage extends ConsumerWidget {
  const AdminOrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersQueueAsync = ref.watch(adminOrdersQueueProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sipariş Yönetimi'),
        backgroundColor: AppTheme.primaryNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(adminOrdersQueueProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: ordersQueueAsync.when(
        data: (ordersQueue) => _buildOrdersQueue(context, ref, ordersQueue),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            _buildErrorWidget(context, ref, error.toString()),
      ),
    );
  }

  Widget _buildOrdersQueue(
      BuildContext context, WidgetRef ref, AdminOrdersQueueResponse ordersQueue) {
    if (ordersQueue.preparing.isEmpty && ordersQueue.shipped.isEmpty && ordersQueue.delivered.isEmpty) {
      return _buildEmptyState(context, ref);
    }

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            labelColor: AppTheme.primaryNavy,
            unselectedLabelColor: Colors.grey[600],
            indicatorColor: AppTheme.primaryOrange,
            tabs: [
              Tab(
                text: 'Hazırlanıyor (${ordersQueue.count.preparing})',
                icon: const Icon(Icons.shopping_bag),
              ),
              Tab(
                text: 'Kargoda (${ordersQueue.count.shipped})',
                icon: const Icon(Icons.local_shipping),
              ),
              Tab(
                text: 'Teslim Edilenler (${ordersQueue.count.delivered})',
                icon: const Icon(Icons.check_circle),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildOrdersList(context, ref, ordersQueue.preparing, 'Hazırlanan sipariş bulunmuyor'),
                _buildOrdersList(context, ref, ordersQueue.shipped, 'Kargoda sipariş bulunmuyor'),
                _buildOrdersList(context, ref, ordersQueue.delivered, 'Teslim edilen sipariş bulunmuyor'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(
      BuildContext context, WidgetRef ref, List<Order> orders, String emptyMessage) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
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
      onRefresh: () async {
        await ref.read(adminOrdersQueueProvider.notifier).refresh();
      },
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
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Sipariş #${order.id ?? 'Bilinmeyen'}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    if (order.payment != null) 
                      _buildPaymentStatusChip(order.payment!['status'] as String? ?? 'unknown'),
                    const SizedBox(width: 8),
                    _buildStatusChip(
                        order.status.displayName, _getStatusColor(order.status)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Order Items
            ...(order.items ?? []).map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppTheme.primaryNavy.withOpacity(0.1),
                        ),
                        child: item.imageUrl != null &&
                                item.imageUrl!.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  item.imageUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.inventory,
                                      color: AppTheme.primaryNavy,
                                      size: 20,
                                    );
                                  },
                                ),
                              )
                            : Icon(
                                Icons.inventory,
                                color: AppTheme.primaryNavy,
                                size: 20,
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name ?? 'Ürün Adı Yok',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Adet: ${item.quantity ?? 0}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '₺${item.total?.toStringAsFixed(2) ?? ((item.price ?? 0) * (item.quantity ?? 0)).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryOrange,
                        ),
                      ),
                    ],
                  ),
                )),

            const SizedBox(height: 12),

            // Order Total
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryNavy.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Toplam:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₺${order.totals?.grandTotal?.toStringAsFixed(2) ?? '0.00'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppTheme.primaryOrange,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Order Info
            Row(
              children: [
                Icon(Icons.person, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Müşteri: ${order.customer.fullName ?? order.userId ?? 'Bilinmeyen'}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  order.createdAt != null
                      ? '${order.createdAt!.day}/${order.createdAt!.month}/${order.createdAt!.year}'
                      : 'Tarih yok',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Actions
            _buildAdminActions(context, ref, order),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
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

  Widget _buildAdminActions(BuildContext context, WidgetRef ref, Order order) {
    return Column(
      children: [
        // Primary actions based on status
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _showOrderDetails(context, order),
                child: const Text('Detaylar'),
              ),
            ),
            const SizedBox(width: 8),
            if (order.status == const OrderStatus.preparing()) ...[
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showShipOrderDialog(context, ref, order),
                  icon: const Icon(Icons.local_shipping, size: 16),
                  label: const Text('Kargoya Ver'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryOrange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ] else if (order.status == const OrderStatus.shipped()) ...[
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _deliverOrder(context, ref, order),
                  icon: const Icon(Icons.check_circle, size: 16),
                  label: const Text('Teslim Et'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
        
        // Secondary actions
        if (order.status != const OrderStatus.delivered() && 
            order.status != const OrderStatus.canceled()) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showCancelOrderDialog(context, ref, order),
                  icon: const Icon(Icons.cancel, size: 16),
                  label: const Text('İptal Et'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showDeleteOrderDialog(context, ref, order),
                  icon: const Icon(Icons.delete, size: 16),
                  label: const Text('Sil'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Color _getStatusColor(OrderStatus status) {
    return status.when(
      preparing: () => Colors.orange,
      shipped: () => Colors.purple,
      delivered: () => Colors.green,
      canceled: () => Colors.red,
      paymentFailed: () => Colors.red,
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz sipariş yok',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Müşteriler sipariş verdiğinde burada görünecek',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, WidgetRef ref, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Hata Oluştu',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(adminOrdersQueueProvider.notifier).refresh();
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  void _showOrderDetails(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sipariş Detayları #${order.id}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Customer Info
              Text('Müşteri ID: ${order.userId}'),
              if (order.customer.fullName != null)
                Text('Müşteri: ${order.customer.fullName}'),
              if (order.customer.phone != null)
                Text('Telefon: ${order.customer.phone}'),
              if (order.customer.email != null)
                Text('Email: ${order.customer.email}'),
              if (order.customer.address != null) ...[
                const SizedBox(height: 8),
                const Text('Adres:', style: TextStyle(fontWeight: FontWeight.bold)),
                if (order.customer.address!.line1 != null)
                  Text(order.customer.address!.line1!),
                Text('${order.customer.address!.city ?? ''} ${order.customer.address!.postalCode ?? ''}'),
              ],
              const SizedBox(height: 16),
              // Status
              Text('Durum: ${order.status.displayName}'),
              // Shipping Info
              if (order.shipping.provider != null || order.shipping.trackingNumber != null) ...[
                const SizedBox(height: 8),
                const Text('Kargo Bilgileri:', style: TextStyle(fontWeight: FontWeight.bold)),
                if (order.shipping.provider != null)
                  Text('Firma: ${order.shipping.provider}'),
                if (order.shipping.trackingNumber != null)
                  Text('Takip No: ${order.shipping.trackingNumber}'),
                if (order.shipping.trackingUrl != null)
                  Text('Takip URL: ${order.shipping.trackingUrl}'),
                if (order.shipping.shippedAt != null)
                  Text('Kargoya Verilme: ${formatDateTime(order.shipping.shippedAt)}'),
                if (order.shipping.deliveredAt != null)
                  Text('Teslim Tarihi: ${formatDateTime(order.shipping.deliveredAt)}'),
              ],
              // Status History
              if (order.statusHistory != null && order.statusHistory!.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text('Durum Geçmişi:', style: TextStyle(fontWeight: FontWeight.bold)),
                ...order.statusHistory!.map((event) => Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '• ${event.status} - ${formatDateTime(event.at)}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    )),
              ],
              if (order.note != null && order.note!.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text('Not: ${order.note}'),
              ],
              const SizedBox(height: 16),
              const Text('Ürünler:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...order.items.map((item) => Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('• ${item.name} x${item.qty}'),
                  )),
              const SizedBox(height: 16),
              const Text('Toplamlar:', style: TextStyle(fontWeight: FontWeight.bold)),
              if (order.totals.subtotal != null)
                Text('Ara Toplam: ${formatMoney(order.totals.subtotal!)}'),
              if (order.totals.shipping != null && order.totals.shipping! > 0)
                Text('Kargo: ${formatMoney(order.totals.shipping!)}'),
              if (order.totals.tax != null && order.totals.tax! > 0)
                Text('Vergi: ${formatMoney(order.totals.tax!)}'),
              Text('Genel Toplam: ${formatMoney(order.totals.grandTotal)}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  void _showShipOrderDialog(BuildContext context, WidgetRef ref, Order order) {
    final trackingController = TextEditingController();
    final trackingUrlController = TextEditingController();
    String selectedProvider = 'MANUAL';
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Siparişi Kargoya Ver'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedProvider,
                    decoration: const InputDecoration(
                      labelText: 'Kargo Firması *',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'MANUAL', child: Text('Manuel')),
                      DropdownMenuItem(value: 'ARAS', child: Text('Aras Kargo')),
                      DropdownMenuItem(value: 'YURTICI', child: Text('Yurtiçi Kargo')),
                      DropdownMenuItem(value: 'MNG', child: Text('MNG Kargo')),
                      DropdownMenuItem(value: 'PTT', child: Text('PTT Kargo')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedProvider = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: trackingController,
                    decoration: const InputDecoration(
                      labelText: 'Takip Numarası *',
                      hintText: 'Kargo takip numarası',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Takip numarası zorunludur';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: trackingUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Takip URL (Opsiyonel)',
                      hintText: 'https://...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState?.validate() ?? false) {
                  Navigator.of(context).pop();
                  await _shipOrder(
                    context,
                    ref,
                    order,
                    trackingController.text.trim(),
                    selectedProvider,
                    trackingUrlController.text.trim(),
                  );
                }
              },
              child: const Text('Kargoya Ver'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _shipOrder(BuildContext context, WidgetRef ref, Order order, String trackingNumber, String provider, String trackingUrl) async {
    try {
      await ref.read(adminOrdersNotifierProvider.notifier).shipOrder(
        order.id,
        OrderShipRequest(
          trackingNumber: trackingNumber,
          provider: provider,
          trackingUrl: trackingUrl.isNotEmpty ? trackingUrl : null,
        ),
      );
      
      if (context.mounted) {
        // Liste güncellemesini bekle
        await ref.read(adminOrdersQueueProvider.notifier).refresh();
        
        SnackBarService.showSnackBar(context: context, snackBar: 
          const SnackBar(
            content: Text('Sipariş kargoya verildi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on ApiException catch (e) {
      if (context.mounted) {
        String errorMessage = 'Hata: ${e.message}';
        if (e.statusCode == 409) {
          errorMessage = 'Geçersiz durum geçişi: Bu sipariş kargoya verilemez';
        } else if (e.statusCode == 400) {
          errorMessage = 'Eksik bilgi: Takip numarası zorunludur';
        }
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text('Hata: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deliverOrder(BuildContext context, WidgetRef ref, Order order) async {
    try {
      await ref.read(adminOrdersNotifierProvider.notifier).deliverOrder(order.id);
      
      if (context.mounted) {
        // Liste güncellemesini bekle
        await ref.read(adminOrdersQueueProvider.notifier).refresh();
        
        SnackBarService.showSnackBar(context: context, snackBar: 
          const SnackBar(
            content: Text('Sipariş teslim edildi olarak işaretlendi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on ApiException catch (e) {
      if (context.mounted) {
        String errorMessage = 'Hata: ${e.message}';
        if (e.statusCode == 409) {
          errorMessage = 'Geçersiz durum geçişi: Bu sipariş teslim edilemez';
        }
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text('Hata: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showCancelOrderDialog(BuildContext context, WidgetRef ref, Order order) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Siparişi İptal Et'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'İptal Sebebi',
                hintText: 'İptal sebebini giriniz',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _cancelOrder(context, ref, order, reasonController.text);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('İptal Et'),
          ),
        ],
      ),
    );
  }

  Future<void> _cancelOrder(BuildContext context, WidgetRef ref, Order order, String reason) async {
    // Sipariş zaten iptal edilmişse işlem yapma
    if (order.status == const OrderStatus.canceled()) {
      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          const SnackBar(
            content: Text('Bu sipariş zaten iptal edilmiş'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    try {
      await ref.read(adminOrdersNotifierProvider.notifier).cancelOrder(
        order.id,
        OrderCancelRequest(reason: reason.isNotEmpty ? reason : null),
      );
      
      if (context.mounted) {
        // Liste güncellemesini bekle
        await ref.read(adminOrdersQueueProvider.notifier).refresh();
        
        SnackBarService.showSnackBar(context: context, snackBar: 
          const SnackBar(
            content: Text('Sipariş iptal edildi'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } on ApiException catch (e) {
      if (context.mounted) {
        String errorMessage = 'Hata: ${e.message}';
        if (e.statusCode == 409) {
          errorMessage = 'Bu sipariş zaten iptal edilmiş veya iptal edilemez durumda';
        }
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text('Hata: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showDeleteOrderDialog(BuildContext context, WidgetRef ref, Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Siparişi Sil'),
        content: const Text('Bu siparişi silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _deleteOrder(context, ref, order);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteOrder(BuildContext context, WidgetRef ref, Order order) async {
    try {
      await ref.read(adminOrdersNotifierProvider.notifier).deleteOrder(order.id);
      
      if (context.mounted) {
        // Liste güncellemesini bekle
        await ref.read(adminOrdersQueueProvider.notifier).refresh();
        
        SnackBarService.showSnackBar(context: context, snackBar: 
          const SnackBar(
            content: Text('Sipariş silindi'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text('Hata: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
