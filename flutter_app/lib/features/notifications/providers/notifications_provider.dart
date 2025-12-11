import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/notification_model.dart';
import '../../../core/network/api_client.dart';
import '../data/notifications_api_service.dart';
import '../data/notifications_repository.dart';

// Repository Provider
final notificationsRepositoryProvider =
    Provider<NotificationsRepository>((ref) {
  final apiClient = ref.read(apiClientProvider);
  final apiService = NotificationsApiService(apiClient);
  return NotificationsRepository(apiService);
});

// Notifications List Provider
class NotificationsNotifier
    extends StateNotifier<AsyncValue<List<UserNotification>>> {
  final NotificationsRepository _repository;

  NotificationsNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      state = const AsyncValue.loading();
      final notifications = await _repository.getNotifications();
      state = AsyncValue.data(notifications);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadNotifications();
  }

  Future<void> markAsRead(String id) async {
    try {
      await _repository.markAsRead(id);
      // Update local state
      state = state.whenData((notifications) {
        return notifications.map((notification) {
          if (notification.id == id) {
            return notification.copyWith(isRead: true);
          }
          return notification;
        }).toList();
      });
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await _repository.markAllAsRead();
      // Update local state
      state = state.whenData((notifications) {
        return notifications
            .map((notification) => notification.copyWith(isRead: true))
            .toList();
      });
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteNotification(String id) async {
    try {
      await _repository.deleteNotification(id);
      // Update local state
      state = state.whenData((notifications) {
        return notifications
            .where((notification) => notification.id != id)
            .toList();
      });
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final notificationsProvider = StateNotifierProvider<NotificationsNotifier,
    AsyncValue<List<UserNotification>>>((ref) {
  final repository = ref.read(notificationsRepositoryProvider);
  return NotificationsNotifier(repository);
});

// Unread Notifications Count Provider
final unreadNotificationsCountProvider = Provider<int>((ref) {
  return ref.watch(notificationsProvider).when(
        data: (notifications) => notifications.where((n) => !n.isRead).length,
        loading: () => 0,
        error: (error, stack) => 0,
      );
});

// Notification Detail Provider
class NotificationDetailNotifier
    extends StateNotifier<AsyncValue<UserNotification?>> {
  final NotificationsRepository _repository;
  String? _currentNotificationId;

  NotificationDetailNotifier(this._repository)
      : super(const AsyncValue.data(null));

  Future<void> loadNotification(String id) async {
    if (_currentNotificationId == id && state.hasValue && state.value != null) {
      return; // Already loaded
    }

    try {
      state = const AsyncValue.loading();
      _currentNotificationId = id;
      final notification = await _repository.getNotification(id);

      // Automatically mark as read when opened
      if (!notification.isRead) {
        await _repository.markAsRead(id);
        state = AsyncValue.data(notification.copyWith(isRead: true));
      } else {
        state = AsyncValue.data(notification);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    if (_currentNotificationId != null) {
      await loadNotification(_currentNotificationId!);
    }
  }

  Future<void> deleteNotification() async {
    if (_currentNotificationId != null) {
      try {
        await _repository.deleteNotification(_currentNotificationId!);
        state = const AsyncValue.data(null);
      } catch (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }
}

final notificationDetailProvider = StateNotifierProvider<
    NotificationDetailNotifier, AsyncValue<UserNotification?>>((ref) {
  final repository = ref.read(notificationsRepositoryProvider);
  return NotificationDetailNotifier(repository);
});
