import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/admin_navigation.dart';
import '../widgets/admin_form_dialog.dart';
import '../../../../core/theme/app_theme.dart';
import 'admin_dashboard_page.dart';
import 'admin_categories_page.dart';
import 'admin_products_page.dart';
import 'admin_orders_page.dart';
import 'admin_appointments_page.dart';
import 'admin_discounts_page.dart';
import 'admin_services_page.dart';
import 'admin_comments_page.dart';
import 'admin_notifications_page.dart';
import '../../providers/admin_orders_provider.dart';
import '../../providers/admin_appointments_provider.dart';
import '../../providers/admin_discounts_provider.dart';
import '../../providers/admin_products_provider.dart';
import '../../providers/admin_categories_provider.dart';
import '../../providers/admin_services_provider.dart';
import '../../providers/admin_comments_provider.dart';
import '../../providers/admin_notifications_provider.dart';
import '../../models/admin_discount_model.dart';
import '../../../../core/models/order_model.dart';
import '../../../../core/models/appointment_model.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/models/service_model.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/models/comment_model.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../core/network/exceptions/api_exception.dart';
import '../../../../core/utils/order_utils.dart';
import '../../providers/admin_users_provider.dart';
import '../../../../features/auth/providers/auth_provider.dart';
import '../../../../core/providers/theme_provider.dart';

class AdminMainPage extends ConsumerStatefulWidget {
  const AdminMainPage({super.key});

  @override
  ConsumerState<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends ConsumerState<AdminMainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return AdminDashboardPageContent(
          onNavigateToTab: _onItemTapped,
        );
      case 1:
        return const AdminCategoriesPageContent();
      case 2:
        return const AdminProductsPageContent();
      case 3:
        return _buildOrdersContent();
      case 4:
        return const AdminAppointmentsPageContent();
      case 5:
        return const AdminDiscountsPageContent();
      case 6:
        return const AdminServicesPageContent();
      case 7:
        return const AdminUsersPageContent();
      case 8:
        return const AdminCommentsPageContent();
      case 9:
        return const AdminNotificationsPageContent();
      default:
        return AdminDashboardPageContent(
          onNavigateToTab: _onItemTapped,
        );
    }
  }

  Widget _buildOrdersContent() {
    final ordersQueueAsync = ref.watch(adminOrdersQueueProvider);

    return ordersQueueAsync.when(
      data: (ordersQueue) => _buildOrdersQueue(ordersQueue),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorWidget(error.toString()),
    );
  }

  Widget _buildOrdersQueue(AdminOrdersQueueResponse ordersQueue) {
    if (ordersQueue.preparing.isEmpty && 
        ordersQueue.shipped.isEmpty && 
        ordersQueue.delivered.isEmpty) {
      return _buildEmptyState();
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
                _buildOrdersList(ordersQueue.preparing, 'Hazırlanan sipariş bulunmuyor'),
                _buildOrdersList(ordersQueue.shipped, 'Kargoda sipariş bulunmuyor'),
                _buildOrdersList(ordersQueue.delivered, 'Teslim edilen sipariş bulunmuyor'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Order> orders, String emptyMessage) {
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
          return _buildOrderCard(order);
        },
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        child: item.imageUrl != null && item.imageUrl!.isNotEmpty
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
                              'Adet: ${item.qty ?? 0}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '₺${item.total?.toStringAsFixed(2) ?? ((item.price ?? 0) * (item.qty ?? 0)).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryOrange,
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 12),
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
            _buildAdminActions(order),
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
          Icon(icon, size: 12, color: chipColor),
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

  Widget _buildAdminActions(Order order) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _showOrderDetails(order),
                child: const Text('Detaylar'),
              ),
            ),
            const SizedBox(width: 8),
            if (order.status == const OrderStatus.preparing()) ...[
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showShipOrderDialog(order),
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
                  onPressed: () => _deliverOrder(order),
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
        if (order.status != const OrderStatus.delivered() && 
            order.status != const OrderStatus.canceled()) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showCancelOrderDialog(order),
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
                  onPressed: () => _showDeleteOrderDialog(order),
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

  Widget _buildEmptyState() {
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
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
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

  void _showOrderDetails(Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sipariş Detayları #${order.id}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Müşteri ID: ${order.userId}'),
              if (order.customer.fullName != null)
                Text('Müşteri: ${order.customer.fullName}'),
              if (order.customer.phone != null)
                Text('Telefon: ${order.customer.phone}'),
              if (order.customer.email != null)
                Text('Email: ${order.customer.email}'),
              const SizedBox(height: 16),
              Text('Durum: ${order.status.displayName}'),
              const SizedBox(height: 16),
              const Text('Ürünler:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...order.items.map((item) => Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('• ${item.name} x${item.qty}'),
                  )),
              const SizedBox(height: 16),
              Text('Toplam: ${formatMoney(order.totals.grandTotal)}',
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

  void _showShipOrderDialog(Order order) {
    final trackingController = TextEditingController();
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
                  await _shipOrder(order, trackingController.text.trim(), selectedProvider);
                }
              },
              child: const Text('Kargoya Ver'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _shipOrder(Order order, String trackingNumber, String provider) async {
    try {
      await ref.read(adminOrdersNotifierProvider.notifier).shipOrder(
        order.id,
        OrderShipRequest(
          trackingNumber: trackingNumber,
          provider: provider,
        ),
      );
      
      if (mounted) {
        await ref.read(adminOrdersQueueProvider.notifier).refresh();
        SnackBarService.showSnackBar(
          context: context,
          snackBar: const SnackBar(
            content: Text('Sipariş kargoya verildi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on ApiException catch (e) {
      if (mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: SnackBar(
            content: Text('Hata: ${e.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: SnackBar(
            content: Text('Hata: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deliverOrder(Order order) async {
    try {
      await ref.read(adminOrdersNotifierProvider.notifier).deliverOrder(order.id);
      
      if (mounted) {
        await ref.read(adminOrdersQueueProvider.notifier).refresh();
        SnackBarService.showSnackBar(
          context: context,
          snackBar: const SnackBar(
            content: Text('Sipariş teslim edildi olarak işaretlendi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: SnackBar(
            content: Text('Hata: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showCancelOrderDialog(Order order) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Siparişi İptal Et'),
        content: TextField(
          controller: reasonController,
          decoration: const InputDecoration(
            labelText: 'İptal Sebebi',
            hintText: 'İptal sebebini giriniz',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _cancelOrder(order, reasonController.text);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('İptal Et'),
          ),
        ],
      ),
    );
  }

  Future<void> _cancelOrder(Order order, String reason) async {
    if (order.status == const OrderStatus.canceled()) {
      if (mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: const SnackBar(
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
      
      if (mounted) {
        await ref.read(adminOrdersQueueProvider.notifier).refresh();
        SnackBarService.showSnackBar(
          context: context,
          snackBar: const SnackBar(
            content: Text('Sipariş iptal edildi'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: SnackBar(
            content: Text('Hata: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showDeleteOrderDialog(Order order) {
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
              await _deleteOrder(order);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteOrder(Order order) async {
    try {
      await ref.read(adminOrdersNotifierProvider.notifier).deleteOrder(order.id);
      
      if (mounted) {
        await ref.read(adminOrdersQueueProvider.notifier).refresh();
        SnackBarService.showSnackBar(
          context: context,
          snackBar: const SnackBar(
            content: Text('Sipariş silindi'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: SnackBar(
            content: Text('Hata: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showSettingsDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Ayarlar'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Theme Selection Section
                const Text(
                  'Tema Seçimi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildThemeSelection(ref),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showLogoutDialog(context, ref);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Çıkış Yap'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildThemeSelection(WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final themeNotifier = ref.read(themeModeProvider.notifier);

    return Column(
      children: [
        _buildThemeOption(
          ref,
          ThemeMode.system,
          'Sistem Teması',
          'Cihaz ayarlarına göre tema seç',
          Icons.settings_suggest,
          themeMode,
          themeNotifier,
        ),
        const SizedBox(height: 8),
        _buildThemeOption(
          ref,
          ThemeMode.light,
          'Açık Tema',
          'Her zaman açık tema kullan',
          Icons.light_mode,
          themeMode,
          themeNotifier,
        ),
        const SizedBox(height: 8),
        _buildThemeOption(
          ref,
          ThemeMode.dark,
          'Koyu Tema',
          'Her zaman koyu tema kullan',
          Icons.dark_mode,
          themeMode,
          themeNotifier,
        ),
      ],
    );
  }

  Widget _buildThemeOption(
    WidgetRef ref,
    ThemeMode mode,
    String title,
    String subtitle,
    IconData icon,
    ThemeMode currentMode,
    ThemeModeNotifier notifier,
  ) {
    final isSelected = currentMode == mode;

    return InkWell(
      onTap: () {
        notifier.setThemeMode(mode);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppTheme.primaryOrange : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected
              ? AppTheme.primaryOrange.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.primaryOrange : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? AppTheme.primaryOrange : null,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppTheme.primaryOrange,
              ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Çıkış Yap'),
          content: const Text(
            'Admin panelinden çıkmak istediğinizden emin misiniz?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _performLogout(context, ref);
              },
              child: const Text(
                'Çıkış Yap',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _performLogout(BuildContext context, WidgetRef ref) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      // Perform logout - navigation will be handled by the auth state listener
      await ref.read(authProvider.notifier).logout();

      // Close loading dialog after logout completes
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      // Close loading dialog first
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show error message
      if (context.mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: SnackBar(
            content: Text('Çıkış yapılırken hata oluştu: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to auth state changes and navigate when user logs out
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous?.isAuthenticated == true && next.isAuthenticated == false) {
        // User has logged out, navigate to login page
        if (context.mounted) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Paneli',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppTheme.primaryNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (_selectedIndex == 3) // Orders page
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.read(adminOrdersQueueProvider.notifier).refresh();
              },
            ),
          if (_selectedIndex == 4) // Appointments page
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.read(adminAppointmentsNotifierProvider.notifier).refresh();
              },
            ),
          if (_selectedIndex == 5) // Discounts page
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.read(adminDiscountsNotifierProvider.notifier).refresh();
              },
            ),
          if (_selectedIndex == 6) // Services page
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.read(adminServicesNotifierProvider.notifier).refresh();
              },
            ),
          if (_selectedIndex == 8) // Comments page
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.read(adminCommentsProvider.notifier).refresh();
              },
            ),
          // Settings icon - always visible
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => _showSettingsDialog(context, ref),
          ),
        ],
      ),
      body: _buildContent(),
      bottomNavigationBar: AdminNavigation(
        currentIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

// Placeholder widgets for pages that don't have Content widgets yet
class AdminAppointmentsPageContent extends ConsumerWidget {
  const AdminAppointmentsPageContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsAsync = ref.watch(adminAppointmentsNotifierProvider);

    return appointmentsAsync.when(
      data: (appointments) =>
          _buildAppointmentsList(context, ref, appointments),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) =>
          _buildErrorWidget(context, ref, error.toString()),
    );
  }

  Widget _buildAppointmentsList(BuildContext context, WidgetRef ref,
      List<AppointmentWithDetails> appointments) {
    if (appointments.isEmpty) {
      return _buildEmptyState(context, ref);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(adminAppointmentsNotifierProvider.notifier).refresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return _buildAppointmentCard(context, ref, appointment);
        },
      ),
    );
  }

  Widget _buildAppointmentCard(
      BuildContext context, WidgetRef ref, AppointmentWithDetails appointment) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appointment Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Randevu #${appointment.id}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                _buildStatusChip(
                    appointment.status, _getStatusColor(appointment.status)),
              ],
            ),

            const SizedBox(height: 12),

            // Service Info
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppTheme.primaryNavy.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.work,
                    color: AppTheme.primaryNavy,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.service?.title ?? 'Hizmet bilgisi yok',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      if (appointment.service?.price != null)
                        Text(
                          'Fiyat: ₺${appointment.service!.price!.toStringAsFixed(2)}',
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

            // Date and Time
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryNavy.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.access_time,
                      size: 20, color: AppTheme.primaryNavy),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tarih: ${_formatDate(appointment.start)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Saat: ${_formatTime(appointment.start)}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Customer Info
            Row(
              children: [
                Icon(Icons.person, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Müşteri: ${appointment.user?.name ?? appointment.user?.email ?? appointment.user?.phone ?? appointment.userId ?? 'Bilinmiyor'}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                if (appointment.notes != null && appointment.notes!.isNotEmpty)
                  Icon(Icons.note, size: 16, color: Colors.grey[600]),
              ],
            ),

            if (appointment.notes != null && appointment.notes!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  appointment.notes!,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 12),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                        _showAppointmentDetails(context, appointment),
                    child: const Text('Detaylar'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        _showStatusUpdateDialog(context, ref, appointment),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Durum Güncelle'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
      case 'approved':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime dateTime) {
    final localDate = dateTime.isUtc ? dateTime.toLocal() : dateTime;
    return '${localDate.day}/${localDate.month}/${localDate.year}';
  }

  String _formatTime(DateTime dateTime) {
    final localDate = dateTime.isUtc ? dateTime.toLocal() : dateTime;
    return '${localDate.hour.toString().padLeft(2, '0')}:${localDate.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz randevu yok',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Müşteriler randevu aldığında burada görünecek',
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
              ref.read(adminAppointmentsNotifierProvider.notifier).refresh();
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  void _showAppointmentDetails(
      BuildContext context, AppointmentWithDetails appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Randevu Detayları #${appointment.id}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Müşteri: ${appointment.user?.name ?? appointment.user?.email ?? appointment.user?.phone ?? appointment.userId ?? 'Bilinmiyor'}'),
              if (appointment.user?.id != null)
                Text('Müşteri ID: ${appointment.user!.id}'),
              if (appointment.user?.email != null)
                Text('Email: ${appointment.user!.email}'),
              if (appointment.user?.phone != null)
                Text('Telefon: ${appointment.user!.phone}'),
              Text('Durum: ${appointment.status}'),
              Text(
                  'Başlangıç: ${_formatDate(appointment.start)} ${_formatTime(appointment.start)}'),
              Text(
                  'Bitiş: ${_formatDate(appointment.end)} ${_formatTime(appointment.end)}'),
              if (appointment.service != null) ...[
                const SizedBox(height: 16),
                const Text('Hizmet:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Ad: ${appointment.service!.title}'),
                if (appointment.service!.price != null)
                  Text(
                      'Fiyat: ₺${appointment.service!.price!.toStringAsFixed(2)}'),
              ],
              if (appointment.notes != null &&
                  appointment.notes!.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text('Notlar:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(appointment.notes!),
              ],
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

  void _showStatusUpdateDialog(
      BuildContext context, WidgetRef ref, AppointmentWithDetails appointment) {
    final statuses = ['pending', 'approved', 'cancelled'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Randevu Durumu Güncelle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: statuses.map((status) {
            return ListTile(
              title: Text(_getStatusDisplayName(status)),
              leading: Radio<String>(
                value: status,
                groupValue: appointment.status,
                onChanged: (value) {
                  if (value != null) {
                    Navigator.of(context).pop();
                    ref
                        .read(adminAppointmentsNotifierProvider.notifier)
                        .updateAppointmentStatus(appointment.id, value);
                  }
                },
              ),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
        ],
      ),
    );
  }

  String _getStatusDisplayName(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Beklemede';
      case 'approved':
        return 'Onaylandı';
      case 'cancelled':
        return 'İptal Edildi';
      default:
        return status;
    }
  }
}

class AdminDiscountsPageContent extends ConsumerWidget {
  const AdminDiscountsPageContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discountsAsync = ref.watch(adminDiscountsNotifierProvider);

    return Stack(
      children: [
        discountsAsync.when(
          data: (discounts) => _buildDiscountsList(context, ref, discounts),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) =>
              _buildErrorWidget(context, ref, error.toString()),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Consumer(
            builder: (context, ref, child) {
              final productsAsync = ref.watch(adminProductsNotifierProvider);
              final categoriesAsync = ref.watch(adminCategoriesProvider);
              final isLoading =
                  productsAsync.isLoading || categoriesAsync.isLoading;

              return FloatingActionButton(
                onPressed: isLoading
                    ? null
                    : () => _showAddDiscountDialog(context, ref),
                backgroundColor:
                    isLoading ? Colors.grey : AppTheme.primaryOrange,
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(Icons.add, color: Colors.white),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDiscountsList(
      BuildContext context, WidgetRef ref, List<AdminDiscount> discounts) {
    if (discounts.isEmpty) {
      return _buildEmptyState(context, ref);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(adminDiscountsNotifierProvider.notifier).refresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: discounts.length,
        itemBuilder: (context, index) {
          final discount = discounts[index];
          return _buildDiscountCard(context, ref, discount);
        },
      ),
    );
  }

  Widget _buildDiscountCard(
      BuildContext context, WidgetRef ref, AdminDiscount discount) {
    final now = DateTime.now();
    final isActive = discount.active &&
        (discount.startAt == null || now.compareTo(discount.startAt!) >= 0) &&
        (discount.endAt == null || now.compareTo(discount.endAt!) < 0);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Discount Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'İndirim #${discount.id.substring(0, 8)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildStatusChip(
                  isActive ? 'Aktif' : 'Pasif',
                  isActive ? Colors.green : Colors.red,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Discount Details
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryNavy.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'İndirim Oranı:',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '%${discount.percentage.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.primaryOrange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hedef:',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${discount.targetType == 'product' ? 'Ürün' : 'Kategori'}: ${discount.targetId ?? 'Tümü'}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Date Range
            if (discount.startAt != null || discount.endAt != null)
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    'Başlangıç: ${discount.startAt != null ? _formatDate(discount.startAt!) : 'Sınırsız'}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Bitiş: ${discount.endAt != null ? _formatDate(discount.endAt!) : 'Sınırsız'}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

            if (discount.description != null &&
                discount.description!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  discount.description!,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 12),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _showDiscountDetails(context, discount),
                    child: const Text('Detaylar'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        _showEditDiscountDialog(context, ref, discount),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Düzenle'),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () =>
                      _showDeleteConfirmation(context, ref, discount),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_offer_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz indirim eklenmemiş',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'İlk indiriminizi eklemek için + butonuna tıklayın',
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
              ref.read(adminDiscountsNotifierProvider.notifier).refresh();
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  void _showAddDiscountDialog(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.read(adminProductsNotifierProvider);
    final categoriesAsync = ref.read(adminCategoriesProvider);

    productsAsync.when(
      data: (products) => categoriesAsync.when(
        data: (categories) =>
            _showDiscountFormDialog(context, ref, null, products, categories),
        loading: () => SnackBarService.showSnackBar(context: context, snackBar: 
          const SnackBar(content: Text('Kategoriler yükleniyor...')),
        ),
        error: (error, stack) => SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(content: Text('Kategori hatası: $error')),
        ),
      ),
      loading: () => SnackBarService.showSnackBar(context: context, snackBar: 
        const SnackBar(content: Text('Ürünler yükleniyor...')),
      ),
      error: (error, stack) => SnackBarService.showSnackBar(context: context, snackBar: 
        SnackBar(content: Text('Ürün hatası: $error')),
      ),
    );
  }

  String _getTargetDisplayValue(
      String targetId, String targetType, List<Product> products, List<Category> categories) {
    if (targetType == 'product') {
      final product = products.firstWhere(
        (p) => p.id == targetId,
        orElse: () => products.first,
      );
      return '${product.id} - ${product.title}';
    } else if (targetType == 'category') {
      final category = categories.firstWhere(
        (c) => c.id == targetId,
        orElse: () => categories.first,
      );
      return '${category.id} - ${category.name}';
    }
    return targetId;
  }

  void _showEditDiscountDialog(
      BuildContext context, WidgetRef ref, AdminDiscount discount) {
    final productsAsync = ref.read(adminProductsNotifierProvider);
    final categoriesAsync = ref.read(adminCategoriesProvider);

    productsAsync.when(
      data: (products) => categoriesAsync.when(
        data: (categories) =>
            _showDiscountFormDialog(context, ref, discount, products, categories),
        loading: () => SnackBarService.showSnackBar(context: context, snackBar: 
          const SnackBar(content: Text('Kategoriler yükleniyor...')),
        ),
        error: (error, stack) => SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(content: Text('Kategori hatası: $error')),
        ),
      ),
      loading: () => SnackBarService.showSnackBar(context: context, snackBar: 
        const SnackBar(content: Text('Ürünler yükleniyor...')),
      ),
      error: (error, stack) => SnackBarService.showSnackBar(context: context, snackBar: 
        SnackBar(content: Text('Ürün hatası: $error')),
      ),
    );
  }

  void _showDiscountFormDialog(
      BuildContext context, WidgetRef ref, AdminDiscount? discount,
      [List<Product>? products, List<Category>? categories]) {
    showDialog(
      context: context,
      builder: (context) => AdminFormDialog(
        title: discount == null ? 'Yeni İndirim Ekle' : 'İndirim Düzenle',
        initialData: discount != null && products != null && categories != null
            ? {
                'İndirim Adı': 'İndirim #${discount.id.substring(0, 8)}',
                'İndirim Oranı': discount.percentage.toString(),
                'Hedef Tip': discount.targetType,
                'Hedef ID': discount.targetId != null
                    ? _getTargetDisplayValue(
                        discount.targetId!,
                        discount.targetType,
                        products!,
                        categories!,
                      )
                    : '',
                'Açıklama': discount.description ?? '',
              }
            : discount != null
                ? {
                    'İndirim Adı': 'İndirim #${discount.id.substring(0, 8)}',
                    'İndirim Oranı': discount.percentage.toString(),
                    'Hedef Tip': discount.targetType,
                    'Hedef ID': discount.targetId ?? '',
                    'Açıklama': discount.description ?? '',
                  }
                : null,
        fields: [
          AdminFormField(
            label: 'İndirim Adı',
            hint: 'İndirim adını girin',
            isRequired: true,
          ),
          AdminFormField(
            label: 'İndirim Oranı (%)',
            hint: 'İndirim oranını girin (örn: 10)',
            isRequired: true,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
            ],
          ),
          AdminFormField(
            label: 'Hedef Tip',
            hint: 'Hedef tip seçin',
            isRequired: true,
            dropdownOptions: const ['product', 'category'],
          ),
          AdminFormField(
            label: 'Hedef ID',
            hint: products != null && categories != null
                ? 'Hedef seçin (opsiyonel)'
                : 'Hedef ürün/kategori seçin (opsiyonel)',
            dropdownOptions: const [], // Will be populated dynamically
          ),
          AdminFormField(
            label: 'Başlangıç Tarihi',
            hint: 'Başlangıç tarihini seçin',
            isDateField: true,
          ),
          AdminFormField(
            label: 'Bitiş Tarihi',
            hint: 'Bitiş tarihini seçin',
            isDateField: true,
          ),
          AdminFormField(
            label: 'Açıklama',
            hint: 'İndirim açıklaması (opsiyonel)',
            maxLines: 3,
          ),
        ],
        dynamicDropdowns: products != null && categories != null
            ? {
                'Hedef ID': (Map<String, String> currentValues) {
                  final targetType = currentValues['Hedef Tip'] ?? '';
                  if (targetType == 'product') {
                    return products!
                        .map((p) => '${p.id} - ${p.title}')
                        .toList();
                  } else if (targetType == 'category') {
                    return categories!
                        .map((c) => '${c.id} - ${c.name}')
                        .toList();
                  }
                  return <String>[];
                },
              }
            : null,
        onSave: (data) async {
          // Tarih parsing
          DateTime? startDate;
          DateTime? endDate;

          if (data['Başlangıç Tarihi']?.isNotEmpty == true) {
            final startParts = data['Başlangıç Tarihi']!.split('/');
            if (startParts.length == 3) {
              startDate = DateTime(
                int.parse(startParts[2]), // year
                int.parse(startParts[1]), // month
                int.parse(startParts[0]), // day
              );
            }
          }

          if (data['Bitiş Tarihi']?.isNotEmpty == true) {
            final endParts = data['Bitiş Tarihi']!.split('/');
            if (endParts.length == 3) {
              endDate = DateTime(
                int.parse(endParts[2]), // year
                int.parse(endParts[1]), // month
                int.parse(endParts[0]), // day
              );
            }
          }

          // Extract ID from "ID - Name" format if present
          String? targetId;
          if (data['Hedef ID']?.isNotEmpty == true) {
            final targetIdValue = data['Hedef ID']!;
            if (targetIdValue.contains(' - ')) {
              targetId = targetIdValue.split(' - ').first;
            } else {
              targetId = targetIdValue;
            }
          }

          final discountData = DiscountCreateRequest(
            name: data['İndirim Adı']!,
            percentage: double.parse(data['İndirim Oranı (%)']!),
            targetType: data['Hedef Tip']!,
            targetId: targetId,
            startDate: startDate ?? DateTime.now(),
            endDate: endDate ?? DateTime.now().add(const Duration(days: 30)),
            isActive: true,
            description:
                data['Açıklama']?.isNotEmpty == true ? data['Açıklama'] : null,
          );

          if (discount == null) {
            try {
              await ref
                  .read(adminDiscountsNotifierProvider.notifier)
                  .createDiscount(discountData);
              // Ensure refresh after creation
              await ref
                  .read(adminDiscountsNotifierProvider.notifier)
                  .refresh();
            } catch (e) {
              rethrow;
            }
          } else {
            // Extract ID from "ID - Name" format if present
            String? targetId;
            if (data['Hedef ID']?.isNotEmpty == true) {
              final targetIdValue = data['Hedef ID']!;
              if (targetIdValue.contains(' - ')) {
                targetId = targetIdValue.split(' - ').first;
              } else {
                targetId = targetIdValue;
              }
            }

            final updateData = DiscountUpdateRequest(
              name: data['İndirim Adı'],
              percentage: double.parse(data['İndirim Oranı (%)']!),
              targetType: data['Hedef Tip'],
              targetId: targetId,
              description: data['Açıklama']?.isNotEmpty == true
                  ? data['Açıklama']
                  : null,
            );
            try {
              await ref
                  .read(adminDiscountsNotifierProvider.notifier)
                  .updateDiscount(discount.id, updateData);
              // Ensure refresh after update
              await ref
                  .read(adminDiscountsNotifierProvider.notifier)
                  .refresh();
            } catch (e) {
              rethrow;
            }
          }
        },
      ),
    );
  }

  void _showDiscountDetails(BuildContext context, AdminDiscount discount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('İndirim Detayları: #${discount.id.substring(0, 8)}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('İndirim Oranı: %${discount.percentage.toStringAsFixed(0)}'),
              Text('Hedef Tip: ${discount.targetType}'),
              if (discount.targetId != null)
                Text('Hedef ID: ${discount.targetId}'),
              Text(
                  'Başlangıç: ${discount.startAt != null ? _formatDate(discount.startAt!) : 'Sınırsız'}'),
              Text(
                  'Bitiş: ${discount.endAt != null ? _formatDate(discount.endAt!) : 'Sınırsız'}'),
              Text('Durum: ${discount.active ? 'Aktif' : 'Pasif'}'),
              if (discount.description != null)
                Text('Açıklama: ${discount.description}'),
              if (discount.createdAt != null)
                Text('Oluşturulma: ${_formatDate(discount.createdAt!)}'),
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

  void _showDeleteConfirmation(
      BuildContext context, WidgetRef ref, AdminDiscount discount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('İndirim Sil'),
        content: Text(
            'İndirim #${discount.id.substring(0, 8)} indirimini silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref
                  .read(adminDiscountsNotifierProvider.notifier)
                  .deleteDiscount(discount.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
}

class AdminServicesPageContent extends ConsumerWidget {
  const AdminServicesPageContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(adminServicesNotifierProvider);

    return Stack(
      children: [
        servicesAsync.when(
          data: (services) => _buildServicesList(context, ref, services),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) =>
              _buildErrorWidget(context, ref, error.toString()),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => _showAddServiceDialog(context, ref),
            backgroundColor: AppTheme.primaryOrange,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildServicesList(
      BuildContext context, WidgetRef ref, List<Service> services) {
    if (services.isEmpty) {
      return _buildEmptyState(context, ref);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(adminServicesNotifierProvider.notifier).refresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return _buildServiceCard(context, ref, service);
        },
      ),
    );
  }

  Widget _buildServiceCard(
      BuildContext context, WidgetRef ref, Service service) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Service Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppTheme.primaryNavy.withOpacity(0.1),
              ),
              child: service.image != null && service.image!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        service.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.work,
                            color: AppTheme.primaryNavy,
                            size: 30,
                          );
                        },
                      ),
                    )
                  : Icon(
                      Icons.work,
                      color: AppTheme.primaryNavy,
                      size: 30,
                    ),
            ),
            const SizedBox(width: 16),

            // Service Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (service.description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      service.description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildStatusChip(
                        !service.isDeleted ? 'Aktif' : 'Pasif',
                        !service.isDeleted ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      if (service.isUpcoming)
                        _buildStatusChip('Yakında', Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        'Tür: ${service.kind}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Actions
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    _showEditServiceDialog(context, ref, service);
                    break;
                  case 'delete':
                    _showDeleteConfirmation(context, ref, service);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      SizedBox(width: 8),
                      Text('Düzenle'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Sil', style: TextStyle(color: Colors.red)),
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

  Widget _buildStatusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.work_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz hizmet eklenmemiş',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'İlk hizmetinizi eklemek için + butonuna tıklayın',
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
              ref.read(adminServicesNotifierProvider.notifier).refresh();
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  void _showAddServiceDialog(BuildContext context, WidgetRef ref) {
    _showServiceFormDialog(context, ref, null);
  }

  void _showEditServiceDialog(
      BuildContext context, WidgetRef ref, Service service) {
    _showServiceFormDialog(context, ref, service);
  }

  void _showServiceFormDialog(
      BuildContext context, WidgetRef ref, Service? service) {
    showDialog(
      context: context,
      builder: (context) => AdminFormDialog(
        title: service == null ? 'Yeni Hizmet Ekle' : 'Hizmet Düzenle',
        initialData: service != null
            ? {
                'Hizmet Adı': service.title,
                'Açıklama': service.description,
                'Görsel': service.image ?? '',
                'Tür': service.kind,
              }
            : null,
        fields: [
          AdminFormField(
            label: 'Hizmet Adı',
            hint: 'Hizmet adını girin',
            isRequired: true,
          ),
          AdminFormField(
            label: 'Açıklama',
            hint: 'Hizmet açıklaması',
            isRequired: true,
            maxLines: 3,
          ),
          AdminFormField(
            label: 'Görsel',
            hint: service == null 
                ? 'Hizmet görseli seçin (zorunlu)' 
                : 'Yeni görsel seçin (opsiyonel)',
            isImageField: true,
            isRequired: service == null, // Required only for create
          ),
          AdminFormField(
            label: 'Tür',
            hint: 'Hizmet türü (service)',
            isRequired: true,
          ),
        ],
        onSave: (data) async {
          final serviceData = {
            'title': data['Hizmet Adı']!,
            'description': data['Açıklama']!,
            'image': data['Görsel_file']?.isNotEmpty == true
                ? data['Görsel_file']
                : null,
            'kind': data['Tür']!,
            'isUpcoming': service?.isUpcoming ?? false,
            'isDeleted': service?.isDeleted ?? false,
          };

          if (service == null) {
            await ref
                .read(adminServicesNotifierProvider.notifier)
                .createService(serviceData);
          } else {
            await ref
                .read(adminServicesNotifierProvider.notifier)
                .updateService(service.id, serviceData);
          }
        },
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, WidgetRef ref, Service service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hizmet Sil'),
        content: Text(
            '${service.title} hizmetini silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref
                  .read(adminServicesNotifierProvider.notifier)
                  .deleteService(service.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
}

class AdminCommentsPageContent extends ConsumerWidget {
  const AdminCommentsPageContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsAsync = ref.watch(adminCommentsProvider);

    return commentsAsync.when(
      data: (comments) => _buildCommentsList(context, ref, comments),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) =>
          _buildErrorWidget(context, ref, error.toString()),
    );
  }

  Widget _buildCommentsList(
      BuildContext context, WidgetRef ref, List<Comment> comments) {
    if (comments.isEmpty) {
      return _buildEmptyState(context, ref);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(adminCommentsProvider.notifier).refresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final comment = comments[index];
          return _buildCommentCard(context, ref, comment);
        },
      ),
    );
  }

  Widget _buildCommentCard(
      BuildContext context, WidgetRef ref, Comment comment) {
    final isApproved = !comment.isDeleted && !comment.isHidden;
    final isHidden = comment.isHidden;
    final isDeleted = comment.isDeleted;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    comment.content,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                _buildStatusChip(isApproved, isHidden, isDeleted),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '${comment.rating}/5',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.person,
                  color: Colors.grey[600],
                  size: 16,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    comment.userName != null && comment.userName!.isNotEmpty
                        ? comment.userName!
                        : 'Kullanıcı: ${comment.userId}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: comment.userName != null && comment.userName!.isNotEmpty
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  comment.targetType == 'product' ? Icons.shopping_bag : Icons.work,
                  color: Colors.grey[500],
                  size: 14,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    comment.targetName != null && comment.targetName!.isNotEmpty
                        ? '${comment.targetType == 'product' ? 'Ürün' : 'Hizmet'}: ${comment.targetName}'
                        : '${comment.targetType == 'product' ? 'Ürün' : 'Hizmet'}: ${comment.targetId}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                      fontWeight: comment.targetName != null && comment.targetName!.isNotEmpty
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (comment.createdAt != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.grey[500],
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(comment.createdAt!),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.end,
              spacing: 8,
              runSpacing: 8,
              children: [
                if (!isApproved)
                  ElevatedButton.icon(
                    onPressed: () => _approveComment(context, ref, comment.id),
                    icon: const Icon(Icons.check, size: 16),
                    label: const Text('Onayla'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                  ),
                ElevatedButton.icon(
                  onPressed: () => _deleteComment(context, ref, comment.id),
                  icon: const Icon(Icons.delete, size: 16),
                  label: const Text('Sil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(bool isApproved, bool isHidden, bool isDeleted) {
    if (isDeleted) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red),
        ),
        child: const Text(
          'Silinmiş',
          style: TextStyle(
            color: Colors.red,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    } else if (isHidden) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange),
        ),
        child: const Text(
          'Gizli',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    } else if (isApproved) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green),
        ),
        child: const Text(
          'Onaylı',
          style: TextStyle(
            color: Colors.green,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue),
        ),
        child: const Text(
          'Bekliyor',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.comment_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz yorum yok',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Kullanıcılar ürünlere yorum yaptığında burada görünecek',
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
              ref.read(adminCommentsProvider.notifier).refresh();
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  Future<void> _approveComment(
      BuildContext context, WidgetRef ref, String commentId) async {
    try {
      await ref.read(adminCommentsProvider.notifier).approveComment(commentId);
      if (context.mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: const SnackBar(
            content: Text('Yorum onaylandı'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: SnackBar(
            content: Text('Yorum onaylanırken hata oluştu: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteComment(
      BuildContext context, WidgetRef ref, String commentId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yorumu Sil'),
        content: const Text('Bu yorumu silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sil', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ref.read(adminCommentsProvider.notifier).deleteComment(commentId);
        if (context.mounted) {
          SnackBarService.showSnackBar(
            context: context,
            snackBar: const SnackBar(
              content: Text('Yorum silindi'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          SnackBarService.showSnackBar(
            context: context,
            snackBar: SnackBar(
              content: Text('Yorum silinirken hata oluştu: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  String _formatDate(DateTime date) {
    final localDate = date.isUtc ? date.toLocal() : date;
    return '${localDate.day}/${localDate.month}/${localDate.year} ${localDate.hour.toString().padLeft(2, '0')}:${localDate.minute.toString().padLeft(2, '0')}';
  }
}

class AdminNotificationsPageContent extends ConsumerStatefulWidget {
  const AdminNotificationsPageContent({super.key});

  @override
  ConsumerState<AdminNotificationsPageContent> createState() =>
      _AdminNotificationsPageContentState();
}

class _AdminNotificationsPageContentState
    extends ConsumerState<AdminNotificationsPageContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryNavy,
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: AppTheme.primaryOrange,
          tabs: const [
            Tab(text: 'Şablonlar', icon: Icon(Icons.description)),
            Tab(text: 'Kampanyalar', icon: Icon(Icons.campaign)),
            Tab(text: 'Gönder', icon: Icon(Icons.send)),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTemplatesTab(),
              _buildCampaignsTab(),
              _buildSendTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTemplatesTab() {
    final templatesAsync = ref.watch(adminNotificationTemplatesProvider);

    return templatesAsync.when(
      data: (templates) => _buildTemplatesList(templates),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorWidget(error.toString()),
    );
  }

  Widget _buildTemplatesList(templates) {
    if (templates.isEmpty) {
      return _buildEmptyState(
          'Henüz bildirim şablonu bulunmuyor.', Icons.description);
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(adminNotificationTemplatesProvider);
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: templates.length,
        itemBuilder: (context, index) {
          final template = templates[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppTheme.primaryOrange.withOpacity(0.1),
                child: Icon(
                  Icons.description,
                  color: AppTheme.primaryOrange,
                ),
              ),
              title: Text(
                template.name ?? template.title ?? 'Başlıksız',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(template.content ?? template.body ?? 'İçerik yok'),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _buildStatusChip(
                        template.type ?? template.templateType ?? 'email',
                        Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      _buildStatusChip(
                        template.isActive ? 'Aktif' : 'Pasif',
                        template.isActive ? Colors.green : Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      _showEditTemplateDialog(template);
                      break;
                    case 'delete':
                      _showDeleteTemplateConfirmation(template);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: AppTheme.primaryOrange),
                        SizedBox(width: 8),
                        Text('Düzenle'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Sil'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCampaignsTab() {
    final campaignsAsync = ref.watch(adminNotificationCampaignsProvider);

    return campaignsAsync.when(
      data: (campaigns) => _buildCampaignsList(campaigns),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorWidget(error.toString()),
    );
  }

  Widget _buildCampaignsList(campaigns) {
    if (campaigns.isEmpty) {
      return _buildEmptyState(
          'Henüz bildirim kampanyası bulunmuyor.', Icons.campaign);
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(adminNotificationCampaignsProvider);
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          final campaign = campaigns[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppTheme.primaryNavy.withOpacity(0.1),
                        child: Icon(
                          Icons.campaign,
                          color: AppTheme.primaryNavy,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              campaign.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              campaign.body,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildStatusChip(
                        campaign.status,
                        _getStatusColor(campaign.status),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCampaignMetric(
                          'Hedef',
                          campaign.targetCount.toString(),
                          Icons.people,
                          Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: _buildCampaignMetric(
                          'Gönderilen',
                          campaign.sentCount.toString(),
                          Icons.send,
                          Colors.green,
                        ),
                      ),
                      Expanded(
                        child: _buildCampaignMetric(
                          'Teslim',
                          campaign.deliveredCount.toString(),
                          Icons.check_circle,
                          Colors.orange,
                        ),
                      ),
                      Expanded(
                        child: _buildCampaignMetric(
                          'Açılan',
                          campaign.openedCount.toString(),
                          Icons.visibility,
                          Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSendTab() {
    return const _SendNotificationForm();
  }

  Widget _buildCampaignMetric(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String text, Color color) {
    return Chip(
      label: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
      backgroundColor: color,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => _showAddTemplateDialog(),
            icon: const Icon(Icons.add),
            label: const Text('Yeni Şablon Ekle'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryOrange,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          Text(
            'Hata oluştu: $error',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.invalidate(adminNotificationTemplatesProvider);
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'sending':
        return Colors.orange;
      case 'scheduled':
        return Colors.blue;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showAddTemplateDialog() {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    String selectedTemplateType = 'email';
    bool isActive = true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Yeni Şablon Ekle'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Şablon Başlığı',
                    border: OutlineInputBorder(),
                    hintText: 'Örn: Hoş Geldiniz Bildirimi',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: bodyController,
                  decoration: const InputDecoration(
                    labelText: 'Şablon İçeriği',
                    border: OutlineInputBorder(),
                    hintText: 'Bildirim içeriğini buraya yazın...',
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedTemplateType,
                  decoration: const InputDecoration(
                    labelText: 'Şablon Türü',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'email',
                      child: Text('E-posta'),
                    ),
                    DropdownMenuItem(
                      value: 'sms',
                      child: Text('SMS'),
                    ),
                    DropdownMenuItem(
                      value: 'push',
                      child: Text('Push Bildirimi'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedTemplateType = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: isActive,
                      onChanged: (value) {
                        setState(() {
                          isActive = value ?? true;
                        });
                      },
                    ),
                    const Text('Şablonu aktif olarak kaydet'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isEmpty ||
                    bodyController.text.isEmpty) {
                  SnackBarService.showSnackBar(
                      context: context,
                      snackBar: const SnackBar(
                        content: Text('Lütfen tüm alanları doldurun'),
                        backgroundColor: Colors.red,
                      ));
                  return;
                }

                try {
                  final templateData = {
                    'name': titleController.text,
                    'subject': titleController.text,
                    'body': bodyController.text,
                    'type': selectedTemplateType,
                    'is_active': isActive,
                  };

                  await ref
                      .read(adminNotificationTemplatesNotifierProvider.notifier)
                      .createTemplate(templateData);

                  if (mounted) {
                    Navigator.of(context).pop();
                    ref.invalidate(adminNotificationTemplatesProvider);
                    SnackBarService.showSnackBar(
                        context: context,
                        snackBar: const SnackBar(
                          content: Text('Şablon başarıyla oluşturuldu!'),
                          backgroundColor: Colors.green,
                        ));
                  }
                } catch (e) {
                  if (mounted) {
                    SnackBarService.showSnackBar(
                        context: context,
                        snackBar: SnackBar(
                          content: Text('Şablon oluşturma hatası: $e'),
                          backgroundColor: Colors.red,
                        ));
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryOrange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Oluştur'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditTemplateDialog(template) {
    final titleController =
        TextEditingController(text: template.name ?? template.title ?? '');
    final bodyController =
        TextEditingController(text: template.content ?? template.body ?? '');
    // Normalize template type - if invalid, default to 'email'
    String rawType = template.type ?? template.templateType ?? 'email';
    String selectedTemplateType = (rawType == 'email' || rawType == 'sms' || rawType == 'push')
        ? rawType
        : 'email';
    bool isActive = template.isActive;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Şablon Düzenle'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Şablon Başlığı',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: bodyController,
                  decoration: const InputDecoration(
                    labelText: 'Şablon İçeriği',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedTemplateType,
                  decoration: const InputDecoration(
                    labelText: 'Şablon Türü',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'email',
                      child: Text('E-posta'),
                    ),
                    DropdownMenuItem(
                      value: 'sms',
                      child: Text('SMS'),
                    ),
                    DropdownMenuItem(
                      value: 'push',
                      child: Text('Push Bildirimi'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedTemplateType = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: isActive,
                      onChanged: (value) {
                        setState(() {
                          isActive = value ?? true;
                        });
                      },
                    ),
                    const Text('Şablonu aktif olarak kaydet'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isEmpty ||
                    bodyController.text.isEmpty) {
                  SnackBarService.showSnackBar(
                      context: context,
                      snackBar: const SnackBar(
                        content: Text('Lütfen tüm alanları doldurun'),
                        backgroundColor: Colors.red,
                      ));
                  return;
                }

                try {
                  final templateData = {
                    'name': titleController.text,
                    'subject': titleController.text,
                    'body': bodyController.text,
                    'type': selectedTemplateType,
                    'is_active': isActive,
                  };

                  await ref
                      .read(adminNotificationTemplatesNotifierProvider.notifier)
                      .updateTemplate(template.id, templateData);

                  if (mounted) {
                    Navigator.of(context).pop();
                    ref.invalidate(adminNotificationTemplatesProvider);
                    SnackBarService.showSnackBar(
                        context: context,
                        snackBar: const SnackBar(
                          content: Text('Şablon başarıyla güncellendi!'),
                          backgroundColor: Colors.green,
                        ));
                  }
                } catch (e) {
                  if (mounted) {
                    SnackBarService.showSnackBar(
                        context: context,
                        snackBar: SnackBar(
                          content: Text('Şablon güncelleme hatası: $e'),
                          backgroundColor: Colors.red,
                        ));
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryOrange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Güncelle'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteTemplateConfirmation(template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Şablon Sil'),
        content: Text(
            '${template.name ?? template.title ?? 'Bu'} şablonunu silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref
                  .read(adminNotificationTemplatesNotifierProvider.notifier)
                  .deleteTemplate(template.id);
              ref.invalidate(adminNotificationTemplatesProvider);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
}

class _SendNotificationForm extends ConsumerStatefulWidget {
  const _SendNotificationForm();

  @override
  ConsumerState<_SendNotificationForm> createState() =>
      _SendNotificationFormState();
}

class _SendNotificationFormState extends ConsumerState<_SendNotificationForm> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  String? selectedTemplate;
  List<String> selectedSegments = [];

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final templatesAsync = ref.watch(adminNotificationTemplatesProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bildirim Gönder',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryNavy,
                        ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Başlık',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: bodyController,
                    decoration: const InputDecoration(
                      labelText: 'İçerik',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  templatesAsync.when(
                    data: (templates) => DropdownButtonFormField<String>(
                      value: selectedTemplate,
                      decoration: const InputDecoration(
                        labelText: 'Şablon Seç (Opsiyonel)',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        const DropdownMenuItem(
                            value: null, child: Text('Şablon kullanma')),
                        ...templates.map((template) => DropdownMenuItem(
                              value: template.id,
                              child: Text((template.name?.isNotEmpty == true)
                                  ? template.name!
                                  : (template.title?.isNotEmpty == true
                                      ? template.title!
                                      : 'Başlıksız')),
                            )),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedTemplate = value;
                          if (value != null) {
                            final template =
                                templates.firstWhere((t) => t.id == value);
                            titleController.text = (template.subject?.isNotEmpty == true)
                                ? template.subject!
                                : ((template.name?.isNotEmpty == true)
                                    ? template.name!
                                    : (template.title?.isNotEmpty == true
                                        ? template.title!
                                        : ''));
                            bodyController.text = (template.content?.isNotEmpty == true)
                                ? template.content!
                                : (template.body?.isNotEmpty == true
                                    ? template.body!
                                    : '');
                          } else {
                            titleController.clear();
                            bodyController.clear();
                          }
                        });
                      },
                    ),
                    loading: () => DropdownButtonFormField<String>(
                      value: null,
                      decoration: const InputDecoration(
                        labelText: 'Şablonlar yükleniyor...',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: null, child: Text('Yükleniyor...'))
                      ],
                      onChanged: null,
                    ),
                    error: (error, stack) => DropdownButtonFormField<String>(
                      value: null,
                      decoration: const InputDecoration(
                        labelText: 'Şablonlar yüklenemedi',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: null, child: Text('Hata oluştu'))
                      ],
                      onChanged: null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Hedef Kitle',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('Tüm Kullanıcılar'),
                        selected: selectedSegments.isEmpty,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedSegments.clear();
                            }
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Aktif Kullanıcılar'),
                        selected: selectedSegments.contains('active'),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedSegments.add('active');
                            } else {
                              selectedSegments.remove('active');
                            }
                          });
                        },
                      ),
                      FilterChip(
                        label: const Text('Yeni Kullanıcılar'),
                        selected: selectedSegments.contains('new'),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedSegments.add('new');
                            } else {
                              selectedSegments.remove('new');
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Test Bildirimi'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Başlık: ${titleController.text}'),
                                    const SizedBox(height: 8),
                                    Text('İçerik: ${bodyController.text}'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: const Text('Tamam'),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.send),
                          label: const Text('Test Gönder'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            try {
                              await ref
                                  .read(adminNotificationTemplatesNotifierProvider
                                      .notifier)
                                  .sendNotification(
                                    titleController.text,
                                    bodyController.text,
                                    selectedTemplate,
                                    selectedSegments,
                                  );

                              if (mounted) {
                                SnackBarService.showSnackBar(
                                    context: context,
                                    snackBar: const SnackBar(
                                      content: Text('Bildirim gönderildi!'),
                                      backgroundColor: Colors.green,
                                    ));
                                titleController.clear();
                                bodyController.clear();
                                setState(() {
                                  selectedTemplate = null;
                                  selectedSegments.clear();
                                });
                              }
                            } catch (e) {
                              if (mounted) {
                                SnackBarService.showSnackBar(
                                    context: context,
                                    snackBar: SnackBar(
                                      content: Text('Bildirim gönderme hatası: $e'),
                                      backgroundColor: Colors.red,
                                    ));
                              }
                            }
                          },
                          icon: const Icon(Icons.send),
                          label: const Text('Gönder'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryOrange,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class AdminUsersPageContent extends ConsumerWidget {
  const AdminUsersPageContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(adminUsersProvider);

    return usersAsync.when(
      data: (users) => _buildUsersList(context, ref, users),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorWidget(context, ref, error.toString()),
    );
  }

  Widget _buildUsersList(
      BuildContext context, WidgetRef ref, List<UserProfile> users) {
    if (users.isEmpty) {
      return _buildEmptyState(context, ref);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(adminUsersProvider.notifier).loadUsers();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return _buildUserCard(context, ref, user);
        },
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, WidgetRef ref, UserProfile user) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (user.name == null || user.name!.isEmpty) ? 'İsimsiz Kullanıcı' : user.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      if (user.phone != null && user.phone!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          user.phone!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            user.role == 'admin' ? 'Admin' : 'Müşteri',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor:
                              user.role == 'admin' ? Colors.red : Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () =>
                              _showRoleChangeDialog(context, ref, user),
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          tooltip: 'Rol Değiştir',
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (user.addresses.isNotEmpty)
                          IconButton(
                            onPressed: () =>
                                _showAddressDetailsDialog(context, user),
                            icon: const Icon(Icons.location_on,
                                color: Colors.green),
                            tooltip: 'Adres Detayları',
                          ),
                        IconButton(
                          onPressed: () =>
                              _showDeleteDialog(context, ref, user),
                          icon: const Icon(Icons.delete, color: Colors.red),
                          tooltip: 'Kullanıcıyı Sil',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            if (user.addresses.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text(
                'Adresler:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              ...user.addresses.take(2).map((address) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '${address.label ?? 'Adres'}: ${address.name ?? ''}, ${address.city ?? ''}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  )),
              if (user.addresses.length > 2)
                Text(
                  '... ve ${user.addresses.length - 2} adres daha',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz kullanıcı bulunmamaktadır',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
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
              ref.read(adminUsersProvider.notifier).loadUsers();
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  void _showRoleChangeDialog(
      BuildContext context, WidgetRef ref, UserProfile user) {
    String selectedRole = user.role;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Kullanıcı Rolünü Değiştir'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      '${(user.name == null || user.name!.isEmpty) ? 'Kullanıcı' : user.name} için rol seçin:'),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedRole,
                    decoration: const InputDecoration(
                      labelText: 'Rol',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'customer',
                        child: Text('Müşteri'),
                      ),
                      DropdownMenuItem(
                        value: 'admin',
                        child: Text('Admin'),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedRole = newValue;
                        });
                      }
                    },
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
                    await _updateUserRole(context, ref, user, selectedRole);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Güncelle'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAddressDetailsDialog(BuildContext context, UserProfile user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              '${(user.name == null || user.name!.isEmpty) ? 'Kullanıcı' : user.name} - Adres Detayları'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: user.addresses.length,
              itemBuilder: (context, index) {
                final address = user.addresses[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address.label ?? 'Adres ${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildAddressField('Adres Adı', address.name),
                        _buildAddressField('Şehir', address.city),
                        _buildAddressField('İlçe', address.district),
                        _buildAddressField('Mahalle', address.neighborhood),
                        _buildAddressField('Sokak', address.street),
                        _buildAddressField('Bina No', address.buildingNo),
                        _buildAddressField('Kat', address.floor),
                        _buildAddressField('Daire', address.apartment),
                        _buildAddressField('Posta Kodu', address.zipCode),
                        if (address.note != null && address.note!.isNotEmpty)
                          _buildAddressField('Not', address.note),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAddressField(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
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

  void _showDeleteDialog(
      BuildContext context, WidgetRef ref, UserProfile user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kullanıcıyı Sil'),
          content: Text(
            '${(user.name == null || user.name!.isEmpty) ? 'Bu kullanıcıyı' : user.name} silmek istediğinizden emin misiniz?\n\n'
            'Bu işlem geri alınamaz.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteUser(context, ref, user);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Sil'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateUserRole(BuildContext context, WidgetRef ref,
      UserProfile user, String newRole) async {
    try {
      await ref
          .read(adminUsersProvider.notifier)
          .updateUserRole(user.id, newRole);
      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text(
                '${(user.name == null || user.name!.isEmpty) ? 'Kullanıcı' : user.name} rolü ${newRole == 'admin' ? 'Admin' : 'Müşteri'} olarak güncellendi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text('Rol güncellenirken hata oluştu: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteUser(
      BuildContext context, WidgetRef ref, UserProfile user) async {
    try {
      await ref.read(adminUsersProvider.notifier).deleteUser(user.id);
      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text(
                '${(user.name == null || user.name!.isEmpty) ? 'Kullanıcı' : user.name} başarıyla silindi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text('Kullanıcı silinirken hata oluştu: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
