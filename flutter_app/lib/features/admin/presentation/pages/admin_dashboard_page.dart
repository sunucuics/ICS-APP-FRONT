import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/admin_dashboard_provider.dart';
import '../../providers/admin_provider.dart';
import '../../providers/admin_notifications_provider.dart';
import '../../models/admin_notification_model.dart';
import '../widgets/admin_stats_card.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../features/auth/providers/auth_provider.dart';
import 'admin_products_page.dart';
import 'admin_categories_page.dart';
import 'admin_discounts_page.dart';
import 'admin_services_page.dart';
import 'admin_orders_page.dart';
import 'admin_appointments_page.dart';
import 'admin_comments_page.dart';
import '../../../../core/services/snackbar_service.dart';

// Content widget for use in AdminMainPage
class AdminDashboardPageContent extends ConsumerWidget {
  final Function(int)? onNavigateToTab;
  
  const AdminDashboardPageContent({super.key, this.onNavigateToTab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardDataAsync = ref.watch(adminDashboardDataProvider);
    final navigateCallback = onNavigateToTab;

    return dashboardDataAsync.when(
      data: (dashboardData) =>
          _buildDashboardContent(context, ref, dashboardData, navigateCallback),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) =>
          _buildErrorWidget(context, error.toString(), ref),
    );
  }

  Widget _buildDashboardContent(
      BuildContext context, WidgetRef ref, dashboardData, Function(int)? onNavigateToTab) {
    final stats = dashboardData.stats;

    return RefreshIndicator(
      onRefresh: () {
        // ignore: unused_result
        ref.refresh(adminDashboardDataProvider);
        return Future.value();
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryNavy,
                    AppTheme.primaryNavy.withOpacity(0.8)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hoş Geldiniz, Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bugün ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Recent Notifications Section (moved to top)
            _buildNotificationsSection(context, ref, onNavigateToTab),

            const SizedBox(height: 24),

            // Stats Cards
            const Text(
              'İstatistikler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                AdminStatsCard(
                  title: 'Toplam Kullanıcı',
                  value: stats.totalUsers.toString(),
                  icon: Icons.people,
                  color: Colors.blue,
                ),
                AdminStatsCard(
                  title: 'Toplam Sipariş',
                  value: stats.totalOrders.toString(),
                  icon: Icons.shopping_cart,
                  color: Colors.green,
                ),
                AdminStatsCard(
                  title: 'Toplam Gelir',
                  value: '₺${stats.totalRevenue.toStringAsFixed(2)}',
                  icon: Icons.attach_money,
                  color: Colors.orange,
                ),
                AdminStatsCard(
                  title: 'Aktif İndirim',
                  value: stats.activeDiscounts.toString(),
                  icon: Icons.local_offer,
                  color: Colors.purple,
                ),
                AdminStatsCard(
                  title: 'Bekleyen Yorum',
                  value: stats.pendingComments.toString(),
                  icon: Icons.comment,
                  color: Colors.red,
                ),
                AdminStatsCard(
                  title: 'Yaklaşan Randevu',
                  value: stats.upcomingAppointments.toString(),
                  icon: Icons.event,
                  color: Colors.teal,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Quick Actions
            const Text(
              'Hızlı İşlemler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.5,
              children: [
                _buildQuickActionCard(
                  context,
                  'Ürün Ekle',
                  Icons.add_box,
                  AppTheme.primaryOrange,
                  () {
                    // Navigate to Products tab (index 2)
                    onNavigateToTab?.call(2);
                  },
                ),
                _buildQuickActionCard(
                  context,
                  'Kategori Ekle',
                  Icons.category,
                  AppTheme.primaryNavy,
                  () {
                    // Navigate to Categories tab (index 1)
                    onNavigateToTab?.call(1);
                  },
                ),
                _buildQuickActionCard(
                  context,
                  'İndirim Ekle',
                  Icons.local_offer,
                  Colors.purple,
                  () {
                    // Navigate to Discounts tab (index 5)
                    onNavigateToTab?.call(5);
                  },
                ),
                _buildQuickActionCard(
                  context,
                  'Hizmet Ekle',
                  Icons.work,
                  Colors.teal,
                  () {
                    // Navigate to Services tab (index 6)
                    onNavigateToTab?.call(6);
                  },
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }

  Widget _buildNotificationsSection(
      BuildContext context, WidgetRef ref, Function(int)? onNavigateToTab) {
    final notificationsAsync = ref.watch(adminPanelNotificationsNotifierProvider);
    final unreadCountAsync = ref.watch(adminPanelUnreadCountProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text(
                  'Son Bildirimler',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                unreadCountAsync.when(
                  data: (count) => count > 0
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            count.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                // Navigate to Notifications tab (index 9)
                onNavigateToTab?.call(9);
              },
              child: const Text('Tümünü Gör'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        notificationsAsync.when(
          data: (notifications) {
            if (notifications.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.notifications_none,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Henüz bildirim yok',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Show last 5 notifications
            final recentNotifications = notifications.take(5).toList();

            return Column(
              children: recentNotifications.map((notification) {
                return _buildNotificationCard(context, ref, notification);
              }).toList(),
            );
          },
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, _) => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Bildirimler yüklenemedi: $error',
              style: TextStyle(color: Colors.red[700]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationCard(
      BuildContext context, WidgetRef ref, AdminPanelNotification notification) {
    final isUnread = !notification.isRead;
    final typeIcon = _getNotificationTypeIcon(notification.type);
    final typeColor = _getNotificationTypeColor(notification.type);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: isUnread ? 2 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isUnread
            ? BorderSide(color: typeColor.withOpacity(0.5), width: 1)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () {
          // Mark as read and navigate based on type
          ref
              .read(adminPanelNotificationsNotifierProvider.notifier)
              .markAsRead(notification.id);
          // Navigate based on notification type
          if (notification.type == 'appointment') {
            // Navigate to appointments
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(typeIcon, color: typeColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              fontWeight:
                                  isUnread ? FontWeight.bold : FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        if (isUnread)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.body,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (notification.createdAt != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        _formatTimeAgo(notification.createdAt!),
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getNotificationTypeIcon(String type) {
    switch (type) {
      case 'appointment':
        return Icons.event;
      case 'order':
        return Icons.shopping_cart;
      case 'comment':
        return Icons.comment;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationTypeColor(String type) {
    switch (type) {
      case 'appointment':
        return Colors.teal;
      case 'order':
        return Colors.green;
      case 'comment':
        return Colors.orange;
      default:
        return AppTheme.primaryNavy;
    }
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Az önce';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} dakika önce';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} saat önce';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} gün önce';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String error, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                ref.refresh(adminDashboardDataProvider);
              },
              child: const Text('Tekrar Dene'),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminDashboardPage extends ConsumerWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardDataAsync = ref.watch(adminDashboardDataProvider);
    final authState = ref.watch(authProvider);
    final isAdmin = ref.watch(isAdminProvider);

    // Debug: Print user info
    print('🔍 Admin Dashboard Debug:');
    print('   - isAuthenticated: ${authState.isAuthenticated}');
    print('   - isAdmin: $isAdmin');
    print('   - user: ${authState.user?.toJson()}');
    print('   - user role: ${authState.user?.role}');

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
        title: const Text('Admin Dashboard'),
        backgroundColor: AppTheme.primaryNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // ignore: unused_result
              ref.refresh(adminDashboardDataProvider);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context, ref),
          ),
        ],
      ),
      body: dashboardDataAsync.when(
        data: (dashboardData) =>
            _buildDashboardContent(context, ref, dashboardData),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            _buildErrorWidget(context, error.toString(), ref),
      ),
    );
  }

  Widget _buildDashboardContent(
      BuildContext context, WidgetRef ref, dashboardData) {
    final stats = dashboardData.stats;

    return RefreshIndicator(
      onRefresh: () {
        // ignore: unused_result
        ref.refresh(adminDashboardDataProvider);
        return Future.value();
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryNavy,
                    AppTheme.primaryNavy.withOpacity(0.8)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hoş Geldiniz, Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bugün ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Stats Cards
            const Text(
              'İstatistikler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                AdminStatsCard(
                  title: 'Toplam Kullanıcı',
                  value: stats.totalUsers.toString(),
                  icon: Icons.people,
                  color: Colors.blue,
                ),
                AdminStatsCard(
                  title: 'Toplam Sipariş',
                  value: stats.totalOrders.toString(),
                  icon: Icons.shopping_cart,
                  color: Colors.green,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminOrdersPage(),
                      ),
                    );
                  },
                ),
                AdminStatsCard(
                  title: 'Toplam Gelir',
                  value: '₺${stats.totalRevenue.toStringAsFixed(2)}',
                  icon: Icons.attach_money,
                  color: Colors.orange,
                ),
                AdminStatsCard(
                  title: 'Aktif İndirim',
                  value: stats.activeDiscounts.toString(),
                  icon: Icons.local_offer,
                  color: Colors.purple,
                ),
                AdminStatsCard(
                  title: 'Bekleyen Yorum',
                  value: stats.pendingComments.toString(),
                  icon: Icons.comment,
                  color: Colors.red,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminCommentsPage(),
                      ),
                    );
                  },
                ),
                AdminStatsCard(
                  title: 'Yaklaşan Randevu',
                  value: stats.upcomingAppointments.toString(),
                  icon: Icons.event,
                  color: Colors.teal,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminAppointmentsPage(),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Quick Actions
            const Text(
              'Hızlı İşlemler',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.5,
              children: [
                _buildQuickActionCard(
                  context,
                  'Ürün Ekle',
                  Icons.add_box,
                  AppTheme.primaryOrange,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminProductsPage(),
                      ),
                    );
                  },
                ),
                _buildQuickActionCard(
                  context,
                  'Kategori Ekle',
                  Icons.category,
                  AppTheme.primaryNavy,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminCategoriesPage(),
                      ),
                    );
                  },
                ),
                _buildQuickActionCard(
                  context,
                  'İndirim Ekle',
                  Icons.local_offer,
                  Colors.purple,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminDiscountsPage(),
                      ),
                    );
                  },
                ),
                _buildQuickActionCard(
                  context,
                  'Hizmet Ekle',
                  Icons.work,
                  Colors.teal,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminServicesPage(),
                      ),
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

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String error, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
            // Debug info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Debug Bilgisi:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                      'Kullanıcı Role: ${ref.read(authProvider).user?.role ?? 'null'}'),
                  Text('Admin Kontrolü: ${ref.read(isAdminProvider)}'),
                  Text(
                      'Authenticated: ${ref.read(authProvider).isAuthenticated}'),
                  const SizedBox(height: 8),
                  const Text(
                    'Not: Backend admin endpoint 403 hatası veriyor. Mock data kullanılıyor.',
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Refresh the data
                ref.refresh(adminDashboardDataProvider);
              },
              child: const Text('Tekrar Dene'),
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
          title: const Text('Çıkış Yap'),
          content: const Text(
              'Admin panelinden çıkmak istediğinizden emin misiniz?'),
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
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text('Çıkış yapılırken hata oluştu: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
