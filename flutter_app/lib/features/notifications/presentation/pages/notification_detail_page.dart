import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../core/models/notification_model.dart';
import '../../providers/notifications_provider.dart';

class NotificationDetailPage extends ConsumerStatefulWidget {
  final String notificationId;

  const NotificationDetailPage({
    super.key,
    required this.notificationId,
  });

  @override
  ConsumerState<NotificationDetailPage> createState() =>
      _NotificationDetailPageState();
}

class _NotificationDetailPageState
    extends ConsumerState<NotificationDetailPage> {
  @override
  void initState() {
    super.initState();
    // Load notification when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(notificationDetailProvider.notifier)
          .loadNotification(widget.notificationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationAsync = ref.watch(notificationDetailProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirim Detayı'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _showDeleteConfirmation(context),
          ),
        ],
      ),
      body: notificationAsync.when(
        data: (notification) {
          if (notification == null) {
            return const Center(child: Text('Bildirim bulunamadı'));
          }
          return _buildNotificationDetail(context, notification);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorState(context, error.toString()),
      ),
    );
  }

  Widget _buildNotificationDetail(
      BuildContext context, UserNotification notification) {
    final dateFormat = DateFormat('dd MMMM yyyy, HH:mm', 'tr_TR');
    final formattedDate = notification.createdAt != null
        ? dateFormat.format(notification.createdAt!)
        : '';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            notification.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          // Date and read status
          Row(
            children: [
              if (formattedDate.isNotEmpty) ...[
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: notification.isRead
                      ? Colors.grey[300]
                      : AppTheme.primaryOrange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  notification.isRead ? 'Okundu' : 'Okunmadı',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: notification.isRead
                        ? Colors.grey[700]
                        : AppTheme.primaryOrange,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Body
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              notification.body,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          // Type badge
          if (notification.type.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primaryNavy.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Tip: ${notification.type}',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.primaryNavy,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
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
            onPressed: () {
              ref
                  .read(notificationDetailProvider.notifier)
                  .loadNotification(widget.notificationId);
            },
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

  void _showDeleteConfirmation(BuildContext context) {
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
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                await ref
                    .read(notificationDetailProvider.notifier)
                    .deleteNotification();
                if (context.mounted) {
                  Navigator.of(context).pop(); // Go back to list
                  SnackBarService.showSnackBar(
                    context: context,
                    snackBar: const SnackBar(
                      content: Text('Bildirim silindi'),
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
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
}
