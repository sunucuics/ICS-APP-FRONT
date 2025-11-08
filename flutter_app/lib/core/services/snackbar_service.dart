import 'package:flutter/material.dart';

/// Centralized helper to display SnackBars safely even when the original
/// BuildContext is no longer active (e.g. dialog contexts that get popped).
class SnackBarService {
  SnackBarService._();

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  /// Shows the provided [snackBar]. If a [context] is supplied and still has an
  /// active [ScaffoldMessenger], it will be used; otherwise the global key will
  /// handle displaying the SnackBar.
  static void showSnackBar({
    required SnackBar snackBar,
    BuildContext? context,
  }) {
    final messenger =
        context != null ? ScaffoldMessenger.maybeOf(context) : null;

    if (messenger != null) {
      messenger.showSnackBar(snackBar);
      return;
    }

    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  /// Convenience helper for simple text messages.
  static void showMessage(
    String message, {
    BuildContext? context,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    showSnackBar(
      context: context,
      snackBar: SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
}
