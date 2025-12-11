import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../core/services/fcm_service.dart';
import '../../providers/notifications_provider.dart';
import '../widgets/notification_card.dart';
import 'notification_detail_page.dart';

class NotificationsListPage extends ConsumerStatefulWidget {
  const NotificationsListPage({super.key});

  @override
  ConsumerState<NotificationsListPage> createState() =>
      _NotificationsListPageState();
}

class _NotificationsListPageState extends ConsumerState<NotificationsListPage> {
  @override
  void initState() {
    super.initState();
    // Set up FCM callback to refresh notifications when a new message arrives
    FCMService.onNotificationReceived = () {
      if (mounted) {
        ref.read(notificationsProvider.notifier).refresh();
      }
    };
  }

  @override
  void dispose() {
    // Clear callback when page is disposed
    FCMService.onNotificationReceived = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(notificationsProvider);
    final unreadCount = ref.watch(unreadNotificationsCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirimlerim'),
        actions: [
          if (unreadCount > 0)
            TextButton.icon(
              onPressed: () => _markAllAsRead(context, ref),
              icon: const Icon(Icons.done_all, size: 20),
              label: Text('Tümünü okundu işaretle ($unreadCount)'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(notificationsProvider.notifier).refresh(),
          ),
        ],
      ),
      body: notificationsAsync.when(
        data: (notifications) =>
            _buildNotificationsList(context, ref, notifications),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            _buildErrorState(context, ref, error.toString()),
      ),
    );
  }

  Widget _buildNotificationsList(
      BuildContext context, WidgetRef ref, List<dynamic> notifications) {
    if (notifications.isEmpty) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(notificationsProvider.notifier).refresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Dismissible(
            key: Key(notification.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              _deleteNotification(context, ref, notification.id);
            },
            child: NotificationCard(
              notification: notification,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NotificationDetailPage(notificationId: notification.id),
                  ),
                ).then((_) {
                  // Refresh list when returning from detail page
                  ref.read(notificationsProvider.notifier).refresh();
                });
              },
              onDelete: () =>
                  _showDeleteConfirmation(context, ref, notification.id),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz bildirim yok',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Yeni bildirimler burada görünecek',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
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
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'Hata oluştu',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => ref.read(notificationsProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh),
            label: const Text('Tekrar Dene'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryOrange,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _markAllAsRead(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(notificationsProvider.notifier).markAllAsRead();
      if (context.mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: const SnackBar(
            content: Text('Tüm bildirimler okundu olarak işaretlendi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: SnackBar(
            content: Text('Hata: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bildirimi Sil'),
        content: const Text('Bu bildirimi silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteNotification(context, ref, id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }

  void _deleteNotification(BuildContext context, WidgetRef ref, String id) {
    ref.read(notificationsProvider.notifier).deleteNotification(id).then((_) {
      if (context.mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: const SnackBar(
            content: Text('Bildirim silindi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }).catchError((e) {
      if (context.mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: SnackBar(
            content: Text('Hata: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }
}
