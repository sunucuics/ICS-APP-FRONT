import 'package:dio/dio.dart';
import '../../../core/models/notification_model.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/exceptions/api_exception.dart';

class NotificationsApiService {
  final Dio _dio;

  NotificationsApiService(this._dio);

  /// Get all notifications for the current user
  Future<List<UserNotification>> getNotifications() async {
    try {
      final response = await _dio.get(ApiEndpoints.notifications);

      if (response.data is List) {
        return (response.data as List)
            .map((json) =>
                UserNotification.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      return [];
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Get a specific notification by ID
  Future<UserNotification> getNotification(String id) async {
    try {
      final response = await _dio.get(ApiEndpoints.notification(id));
      return UserNotification.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Mark a notification as read
  Future<void> markAsRead(String id) async {
    try {
      await _dio.put(ApiEndpoints.notificationRead(id));
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      await _dio.put(ApiEndpoints.notificationsReadAll);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Delete a notification
  Future<void> deleteNotification(String id) async {
    try {
      await _dio.delete(ApiEndpoints.notification(id));
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
