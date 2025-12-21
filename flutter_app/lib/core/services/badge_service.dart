import 'package:flutter/foundation.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/notifications/providers/notifications_provider.dart';
import 'dart:io';

class BadgeService {
  static bool _initialized = false;
  static WidgetRef? _ref;

  /// Initialize badge service
  static Future<void> initialize() async {
    if (_initialized) {
      debugPrint('BadgeService already initialized');
      return;
    }

    try {
      // Check if badge is supported
      final isSupported = await FlutterAppBadger.isAppBadgeSupported();
      if (isSupported) {
        _initialized = true;
        debugPrint('✅ BadgeService initialized successfully');
      } else {
        debugPrint('⚠️ Badge is not supported on this device');
        _initialized = false;
      }
    } catch (e) {
      debugPrint('❌ BadgeService initialization error: $e');
      _initialized = false;
    }
  }

  /// Initialize with Riverpod ref to listen to notifications
  static Future<void> initializeWithRef(WidgetRef ref) async {
    await initialize();
    if (_initialized) {
      _ref = ref;
      _listenToNotifications(ref);
    }
  }

  /// Listen to unread notifications count and update badge
  static void _listenToNotifications(WidgetRef ref) {
    ref.listen<int>(
      unreadNotificationsCountProvider,
      (previous, next) {
        updateBadge(next);
      },
    );
  }

  /// Update badge count
  static Future<void> updateBadge(int count) async {
    if (!_initialized) {
      debugPrint('BadgeService not initialized, skipping badge update');
      return;
    }

    try {
      final isSupported = await FlutterAppBadger.isAppBadgeSupported();
      if (!isSupported) {
        debugPrint('Badge is not supported on this device');
        return;
      }

      if (count > 0) {
        await FlutterAppBadger.updateBadgeCount(count);
        debugPrint('✅ Badge updated to: $count');
      } else {
        await FlutterAppBadger.removeBadge();
        debugPrint('✅ Badge removed');
      }
    } catch (e) {
      debugPrint('❌ Error updating badge: $e');
    }
  }

  /// Remove badge
  static Future<void> removeBadge() async {
    if (!_initialized) {
      return;
    }

    try {
      await FlutterAppBadger.removeBadge();
      debugPrint('✅ Badge removed');
    } catch (e) {
      debugPrint('❌ Error removing badge: $e');
    }
  }

  /// Get current badge count (if supported)
  static Future<int?> getBadgeCount() async {
    if (!_initialized) {
      return null;
    }

    try {
      // Note: flutter_app_badger doesn't provide a method to get current badge count
      // We'll use the provider value instead
      if (_ref != null) {
        return _ref!.read(unreadNotificationsCountProvider);
      }
      return null;
    } catch (e) {
      debugPrint('❌ Error getting badge count: $e');
      return null;
    }
  }
}

