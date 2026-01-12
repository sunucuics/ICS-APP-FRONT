import 'package:flutter/material.dart';
import '../../features/home/presentation/pages/home_page.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // Navigate to login screen
  static void navigateToLogin() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
  }

  // Navigate to home screen
  static void navigateToHome() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    }
  }

  // Navigate to welcome screen
  static void navigateToWelcome() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (route) => false);
    }
  }

  // Navigate to home screen and switch to specific tab
  // This method clears all routes and navigates directly to home with the desired tab
  static void navigateToHomeTab(int tabIndex) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      // Clear all routes and navigate to home
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      
      // After navigation, switch to the desired tab
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final homePageState = HomePageState.instance;
        if (homePageState != null) {
          homePageState.switchToTab(tabIndex);
        }
      });
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
