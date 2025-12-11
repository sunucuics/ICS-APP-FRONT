import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FCMService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static String? _fcmToken;
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
  static const String _fcmTokenKey = 'fcm_token';

  // Callback for refreshing notifications when a message is received
  static VoidCallback? onNotificationReceived;

  /// Initialize FCM service
  static Future<void> initialize() async {
    try {
      // Request permission for notifications
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        debugPrint('User granted provisional permission');
      } else {
        debugPrint('User declined or has not accepted permission');
      }

      // Get FCM token
      await _getFCMToken();

      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((token) {
        _fcmToken = token;
        _saveTokenToStorage(token);
        debugPrint('FCM Token refreshed: $token');
      });

      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('Got a message whilst in the foreground!');
        debugPrint('Message data: ${message.data}');

        if (message.notification != null) {
          debugPrint(
              'Message also contained a notification: ${message.notification}');

          // Refresh notifications list when a notification is received
          if (onNotificationReceived != null) {
            onNotificationReceived!();
          }
        }
      });
    } catch (e) {
      debugPrint('FCM initialization error: $e');
    }
  }

  /// Get FCM token
  static Future<String?> getFCMToken() async {
    if (_fcmToken == null) {
      await _getFCMToken();
    }
    return _fcmToken;
  }

  /// Get FCM token from Firebase
  static Future<void> _getFCMToken() async {
    try {
      _fcmToken = await _firebaseMessaging.getToken();
      if (_fcmToken != null) {
        await _saveTokenToStorage(_fcmToken!);
        debugPrint('FCM Token: $_fcmToken');
      }
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
    }
  }

  /// Save token to secure storage
  static Future<void> _saveTokenToStorage(String token) async {
    try {
      await _secureStorage.write(key: _fcmTokenKey, value: token);
    } catch (e) {
      debugPrint('Error saving FCM token: $e');
    }
  }

  /// Get token from secure storage
  static Future<String?> getTokenFromStorage() async {
    try {
      return await _secureStorage.read(key: _fcmTokenKey);
    } catch (e) {
      debugPrint('Error getting FCM token from storage: $e');
      return null;
    }
  }

  /// Subscribe to topic
  static Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      debugPrint('Subscribed to topic: $topic');
    } catch (e) {
      debugPrint('Error subscribing to topic: $e');
    }
  }

  /// Unsubscribe from topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      debugPrint('Unsubscribed from topic: $topic');
    } catch (e) {
      debugPrint('Error unsubscribing from topic: $e');
    }
  }
}

/// Background message handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message: ${message.messageId}');
  debugPrint('Message data: ${message.data}');
  debugPrint('Message notification: ${message.notification?.title}');

  // Note: In background handler, we can't directly refresh the UI
  // The notification will be shown by the system, and when user opens the app,
  // the notifications list will be refreshed automatically
}
