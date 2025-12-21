import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'navigation_service.dart';
import '../../features/notifications/presentation/pages/notifications_list_page.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  /// Initialize local notifications service
  static Future<void> initialize() async {
    if (_initialized) {
      debugPrint('LocalNotificationService already initialized');
      return;
    }

    try {
      // Android initialization settings
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/launcher_icon');

      // iOS initialization settings
      const DarwinInitializationSettings iosSettings =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      // Initialization settings
      const InitializationSettings initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      // Initialize the plugin
      final bool? initialized = await _notifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      if (initialized == true) {
        // Create notification channel for Android
        if (Platform.isAndroid) {
          await _createAndroidNotificationChannel();
        }

        _initialized = true;
        debugPrint('✅ LocalNotificationService initialized successfully');
      } else {
        debugPrint('❌ LocalNotificationService initialization failed');
      }
    } catch (e) {
      debugPrint('❌ LocalNotificationService initialization error: $e');
    }
  }

  /// Create Android notification channel
  static Future<void> _createAndroidNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // name
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Show notification from FCM message
  static Future<void> showNotification(RemoteMessage message) async {
    if (!_initialized) {
      await initialize();
    }

    try {
      final notification = message.notification;
      if (notification == null) {
        debugPrint('No notification payload in FCM message');
        return;
      }

      final androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        enableVibration: true,
        playSound: true,
        icon: '@mipmap/launcher_icon',
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      final notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      // Generate a unique notification ID
      final notificationId = message.messageId?.hashCode ?? 
          DateTime.now().millisecondsSinceEpoch.remainder(100000);

      await _notifications.show(
        notificationId,
        notification.title,
        notification.body,
        notificationDetails,
        payload: message.data.toString(),
      );

      debugPrint('✅ Local notification shown: ${notification.title}');
    } catch (e) {
      debugPrint('❌ Error showing local notification: $e');
    }
  }

  /// Show custom notification
  static Future<void> showCustomNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_initialized) {
      await initialize();
    }

    try {
      final androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        enableVibration: true,
        playSound: true,
        icon: '@mipmap/launcher_icon',
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      final notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );

      debugPrint('✅ Custom notification shown: $title');
    } catch (e) {
      debugPrint('❌ Error showing custom notification: $e');
    }
  }

  /// Update badge count
  static Future<void> updateBadge(int count) async {
    if (!_initialized) {
      await initialize();
    }

    try {
      if (Platform.isIOS) {
        // iOS badge update
        await _notifications
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(badge: true);
      }

      // Note: flutter_local_notifications doesn't directly set badge count
      // Badge will be managed by BadgeService using platform-specific methods
      debugPrint('Badge count update requested: $count');
    } catch (e) {
      debugPrint('❌ Error updating badge: $e');
    }
  }

  /// Handle notification tap
  static void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.payload}');
    
    // Navigate to notifications page
    final navigator = NavigationService.navigatorKey.currentState;
    if (navigator != null) {
      navigator.push(
        MaterialPageRoute(
          builder: (context) => const NotificationsListPage(),
        ),
      );
      debugPrint('Navigating to notifications page...');
    }
  }

  /// Cancel all notifications
  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  /// Cancel specific notification
  static Future<void> cancel(int id) async {
    await _notifications.cancel(id);
  }
}

