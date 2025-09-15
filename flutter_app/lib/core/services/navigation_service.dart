import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Navigate to login screen
  static void navigateToLogin() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      context.go('/login');
    }
  }

  // Navigate to home screen
  static void navigateToHome() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      context.go('/home');
    }
  }

  // Show error dialog
  static void showErrorDialog(String message) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hata'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }
}
