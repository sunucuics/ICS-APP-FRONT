import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'local_notification_service.dart';
import 'navigation_service.dart';
import '../../firebase_options.dart';
import '../../features/notifications/presentation/pages/notifications_list_page.dart';

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
  
  // Callback for updating FCM token to backend
  static Future<void> Function(String)? onTokenUpdate;

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
      _firebaseMessaging.onTokenRefresh.listen((token) async {
        _fcmToken = token;
        await _saveTokenToStorage(token);
        debugPrint('FCM Token refreshed: $token');
        
        // Update token to backend if user is authenticated
        if (onTokenUpdate != null) {
          try {
            await onTokenUpdate!(token);
            debugPrint('FCM Token updated to backend');
          } catch (e) {
            debugPrint('Error updating FCM token to backend: $e');
          }
        }
      });

      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        debugPrint('Got a message whilst in the foreground!');
        debugPrint('Message data: ${message.data}');

        if (message.notification != null) {
          debugPrint(
              'Message also contained a notification: ${message.notification}');

          // Show local notification for foreground messages
          await LocalNotificationService.showNotification(message);

          // Refresh notifications list when a notification is received
          if (onNotificationReceived != null) {
            onNotificationReceived!();
          }
        }
      });

      // Handle app opened from terminated state via notification tap
      // This is called when the app is completely closed and user taps on a notification
      RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        debugPrint('✅ App opened from terminated state via notification');
        _handleNotificationTap(initialMessage);
      }

      // Handle app opened from background state via notification tap
      // This is called when the app is in the background and user taps on a notification
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('✅ App opened from background state via notification');
        _handleNotificationTap(message);
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
        
        // Update token to backend if user is authenticated
        final user = FirebaseAuth.instance.currentUser;
        if (user != null && onTokenUpdate != null) {
          try {
            await onTokenUpdate!(_fcmToken!);
            debugPrint('FCM Token sent to backend on initialization');
          } catch (e) {
            debugPrint('Error updating FCM token to backend: $e');
          }
        }
      }
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
    }
  }
  
  /// Update FCM token to backend (call this when user logs in)
  static Future<void> updateTokenToBackend() async {
    final token = await getFCMToken();
    if (token != null && onTokenUpdate != null) {
      try {
        await onTokenUpdate!(token);
        debugPrint('FCM Token manually updated to backend');
      } catch (e) {
        debugPrint('Error manually updating FCM token to backend: $e');
      }
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

  /// Handle notification tap - navigates to notifications page
  /// Called when user taps on a notification (from terminated or background state)
  static void _handleNotificationTap(RemoteMessage message) {
    debugPrint('Notification tapped: ${message.notification?.title}');
    debugPrint('Notification data: ${message.data}');

    // Use a slight delay to ensure the app is fully initialized before navigating
    Future.delayed(const Duration(milliseconds: 500), () {
      final navigator = NavigationService.navigatorKey.currentState;
      if (navigator != null) {
        navigator.push(
          MaterialPageRoute(
            builder: (context) => const NotificationsListPage(),
          ),
        );
        debugPrint('✅ Navigating to notifications page from notification tap');
      } else {
        debugPrint('⚠️ Navigator not available for notification tap navigation');
      }
    });

    // Refresh notifications list
    if (onNotificationReceived != null) {
      onNotificationReceived!();
    }
  }
}

/// Background message handler
/// This handler runs in a separate isolate when the app is in the background or terminated
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    debugPrint('Handling a background message: ${message.messageId}');
    debugPrint('Message data: ${message.data}');
    debugPrint('Message notification: ${message.notification?.title}');

    // Initialize Firebase in background isolate
    // Check if Firebase is already initialized to avoid re-initialization errors
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      debugPrint('✅ Firebase initialized in background handler');
    } catch (e) {
      // Firebase might already be initialized, which is fine
      debugPrint('Firebase initialization in background handler: $e');
    }

    // Initialize LocalNotificationService in background isolate
    await LocalNotificationService.initialize();
    debugPrint('✅ LocalNotificationService initialized in background handler');

    // Show notification if notification payload exists
    if (message.notification != null) {
      await LocalNotificationService.showNotification(message);
      debugPrint('✅ Background notification shown: ${message.notification?.title}');
    } else {
      debugPrint('⚠️ Background message has no notification payload');
    }
  } catch (e, stackTrace) {
    debugPrint('❌ Error in background message handler: $e');
    debugPrint('Stack trace: $stackTrace');
  }
}
