import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/admin_repository.dart';
import '../models/admin_notification_model.dart';
import 'admin_dashboard_provider.dart';

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

  AdminPanelNotificationsNotifier(this._repository, this._ref)
      : super(const AsyncValue.loading()) {
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    state = const AsyncValue.loading();
    try {
      final notifications = await _repository.getAdminPanelNotifications();
      state = AsyncValue.data(notifications);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
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

final adminPanelNotificationsNotifierProvider = StateNotifierProvider<
    AdminPanelNotificationsNotifier,
    AsyncValue<List<AdminPanelNotification>>>((ref) {
  final repository = ref.watch(adminRepositoryProvider);
  return AdminPanelNotificationsNotifier(repository, ref);
});
