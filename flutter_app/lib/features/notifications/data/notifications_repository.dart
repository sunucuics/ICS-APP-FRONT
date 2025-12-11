import '../../../core/models/notification_model.dart';
import 'notifications_api_service.dart';

class NotificationsRepository {
  final NotificationsApiService _apiService;

  NotificationsRepository(this._apiService);

  /// Get all notifications for the current user
  Future<List<UserNotification>> getNotifications() async {
    return await _apiService.getNotifications();
  }

  /// Get a specific notification by ID
  Future<UserNotification> getNotification(String id) async {
    return await _apiService.getNotification(id);
  }

  /// Mark a notification as read
  Future<void> markAsRead(String id) async {
    return await _apiService.markAsRead(id);
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    return await _apiService.markAllAsRead();
  }

  /// Delete a notification
  Future<void> deleteNotification(String id) async {
    return await _apiService.deleteNotification(id);
  }
}
