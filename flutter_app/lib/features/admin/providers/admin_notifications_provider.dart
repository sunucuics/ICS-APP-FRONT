import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import '../models/admin_notification_model.dart';
import 'admin_dashboard_provider.dart';
import '../../../../core/services/admin_notification_stream_service.dart';
import '../../../../core/utils/logger.dart';

final adminNotificationTemplatesProvider =
    FutureProvider<List<NotificationTemplate>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getNotificationTemplates();
});

final adminNotificationCampaignsProvider =
    FutureProvider<List<NotificationCampaign>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getNotificationCampaigns();
});

final adminUserSegmentsProvider =
    FutureProvider<List<UserSegment>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getUserSegments();
});

class AdminNotificationTemplatesNotifier
    extends StateNotifier<AsyncValue<List<NotificationTemplate>>> {
  final AdminRepository _repository;

  AdminNotificationTemplatesNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    _fetchTemplates();
  }

  Future<void> _fetchTemplates() async {
    state = const AsyncValue.loading();
    try {
      final templates = await _repository.getNotificationTemplates();
      state = AsyncValue.data(templates);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createTemplate(Map<String, dynamic> templateData) async {
    state = const AsyncValue.loading();
    try {
      await _repository.createNotificationTemplate(templateData);
      await _fetchTemplates();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateTemplate(
      String templateId, Map<String, dynamic> templateData) async {
    state = const AsyncValue.loading();
    try {
      await _repository.updateNotificationTemplate(templateId, templateData);
      await _fetchTemplates();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTemplate(String templateId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteNotificationTemplate(templateId);
      await _fetchTemplates();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> sendNotification(
    String title,
    String body,
    String? templateId,
    List<String> segments,
  ) async {
    try {
      final notificationRequest = NotificationRequest(
        title: title,
        body: body,
        templateId: templateId,
        userSegments: segments.isNotEmpty ? segments : null,
        sendImmediately: true,
      );
      await _repository.sendNotification(notificationRequest);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refresh() async {
    await _fetchTemplates();
  }
}

final adminNotificationTemplatesNotifierProvider = StateNotifierProvider<
    AdminNotificationTemplatesNotifier,
    AsyncValue<List<NotificationTemplate>>>((ref) {
  return AdminNotificationTemplatesNotifier(ref.watch(adminRepositoryProvider));
});

// ============================================================================
// Admin Panel Notifications (gelen bildirimler - randevu, sipariş vb.)
// ============================================================================

/// Okunmamış admin bildirim sayısı
final adminPanelUnreadCountProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getAdminPanelNotificationsUnreadCount();
});

/// Admin panel bildirimleri listesi
final adminPanelNotificationsProvider =
    FutureProvider<List<AdminPanelNotification>>((ref) async {
  final repository = ref.watch(adminRepositoryProvider);
  return await repository.getAdminPanelNotifications();
});

/// Admin panel bildirimleri için StateNotifier (CRUD işlemleri)
class AdminPanelNotificationsNotifier
    extends StateNotifier<AsyncValue<List<AdminPanelNotification>>> {
  final AdminRepository _repository;
  final Ref _ref;
  final AdminNotificationStreamService _streamService;
  StreamSubscription<SSEEvent>? _streamSubscription;
  bool _isStreamActive = false;

  AdminPanelNotificationsNotifier(
    this._repository,
    this._ref,
    this._streamService,
  ) : super(const AsyncValue.loading()) {
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    state = const AsyncValue.loading();
    try {
      final notifications = await _repository.getAdminPanelNotifications();
      state = AsyncValue.data(notifications);
      
      // Start SSE stream if not already active
      if (!_isStreamActive) {
        _startSSEStream();
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Start SSE stream for real-time notifications
  void _startSSEStream() {
    if (_isStreamActive) return;

    _isStreamActive = true;
    _streamService.start().catchError((e) {
      // Log error but don't fail
      AppLogger.error('Failed to start SSE stream', e);
    });

    _streamSubscription = _streamService.eventStream.listen(
      (event) {
        _handleSSEEvent(event);
      },
      onError: (error) {
        AppLogger.error('SSE stream error', error);
        _isStreamActive = false;
        // Try to reconnect after a delay
        Future.delayed(const Duration(seconds: 5), () {
          if (!_isStreamActive) {
            _startSSEStream();
          }
        });
      },
    );
  }

  /// Handle SSE events
  void _handleSSEEvent(SSEEvent event) {
    switch (event.type) {
      case SSEEventType.connected:
        AppLogger.info('SSE stream connected');
        break;

      case SSEEventType.notification:
        // New notification received
        if (event.data != null) {
          try {
            final notification = AdminPanelNotification.fromJson(event.data!);
            
            // Add to current state (handle all states: loading, error, data)
            final currentNotifications = state.valueOrNull ?? [];
            
            // Check if notification already exists (avoid duplicates)
            if (!currentNotifications.any((n) => n.id == notification.id)) {
              final updated = [notification, ...currentNotifications];
              state = AsyncValue.data(updated);
              
              // Invalidate unread count
              _ref.invalidate(adminPanelUnreadCountProvider);
              
              AppLogger.info('New notification added via SSE: ${notification.id} - ${notification.title}');
            }
          } catch (e) {
            AppLogger.error('Error parsing notification from SSE', e);
          }
        }
        break;

      case SSEEventType.notificationUpdated:
        // Notification updated (e.g., marked as read)
        if (event.data != null) {
          final notificationId = event.data!['id'] as String?;
          final isRead = event.data!['is_read'] as bool? ?? false;
          
          if (notificationId != null) {
            state.whenData((notifications) {
              final updated = notifications.map((n) {
                if (n.id == notificationId) {
                  return n.copyWith(
                    isRead: isRead,
                    readAt: isRead ? DateTime.now() : null,
                  );
                }
                return n;
              }).toList();
              state = AsyncValue.data(updated);
              
              // Invalidate unread count
              _ref.invalidate(adminPanelUnreadCountProvider);
            });
          }
        }
        break;

      case SSEEventType.unreadCount:
        // Unread count updated
        if (event.data != null) {
          final count = event.data!['count'] as int?;
          if (count != null) {
            // Invalidate unread count provider to refresh
            _ref.invalidate(adminPanelUnreadCountProvider);
          }
        }
        break;

      case SSEEventType.heartbeat:
        // Heartbeat - connection is alive
        break;

      case SSEEventType.error:
        AppLogger.error('SSE error: ${event.data}');
        break;
    }
  }

  /// Stop SSE stream
  void stopSSEStream() {
    _isStreamActive = false;
    _streamSubscription?.cancel();
    _streamSubscription = null;
    _streamService.stop();
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await _repository.markAdminPanelNotificationAsRead(notificationId);
      // Update local state
      state.whenData((notifications) {
        final updated = notifications.map((n) {
          if (n.id == notificationId) {
            return AdminPanelNotification(
              id: n.id,
              title: n.title,
              body: n.body,
              type: n.type,
              isRead: true,
              createdAt: n.createdAt,
              readAt: DateTime.now(),
              data: n.data,
            );
          }
          return n;
        }).toList();
        state = AsyncValue.data(updated);
      });
      // Refresh unread count
      _ref.invalidate(adminPanelUnreadCountProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await _repository.markAllAdminPanelNotificationsAsRead();
      // Update local state
      state.whenData((notifications) {
        final updated = notifications.map((n) {
          return AdminPanelNotification(
            id: n.id,
            title: n.title,
            body: n.body,
            type: n.type,
            isRead: true,
            createdAt: n.createdAt,
            readAt: DateTime.now(),
            data: n.data,
          );
        }).toList();
        state = AsyncValue.data(updated);
      });
      // Refresh unread count
      _ref.invalidate(adminPanelUnreadCountProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await _repository.deleteAdminPanelNotification(notificationId);
      // Update local state
      state.whenData((notifications) {
        final updated =
            notifications.where((n) => n.id != notificationId).toList();
        state = AsyncValue.data(updated);
      });
      // Refresh unread count
      _ref.invalidate(adminPanelUnreadCountProvider);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async {
    await loadNotifications();
    _ref.invalidate(adminPanelUnreadCountProvider);
  }
}

final adminNotificationStreamServiceProvider =
    Provider<AdminNotificationStreamService>((ref) {
  final service = AdminNotificationStreamService();
  // Cleanup when provider is disposed
  ref.onDispose(() {
    service.dispose();
  });
  return service;
});

final adminPanelNotificationsNotifierProvider = StateNotifierProvider<
    AdminPanelNotificationsNotifier,
    AsyncValue<List<AdminPanelNotification>>>((ref) {
  final repository = ref.watch(adminRepositoryProvider);
  final streamService = ref.watch(adminNotificationStreamServiceProvider);
  final notifier = AdminPanelNotificationsNotifier(repository, ref, streamService);
  
  // Cleanup when provider is disposed
  ref.onDispose(() {
    notifier.stopSSEStream();
  });
  
  return notifier;
});
