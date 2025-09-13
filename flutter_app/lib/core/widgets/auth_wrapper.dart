import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/providers/anonymous_auth_provider.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/guest_welcome_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final anonymousAuthState = ref.watch(authStateProvider);

    // Debug: Print auth state
    print(
        '🔐 AuthWrapper - isAuthenticated: ${authState.isAuthenticated}, isLoading: ${authState.isLoading}, user: ${authState.user?.email}');
    print(
        '🔐 AuthWrapper - Anonymous: ${anonymousAuthState.isAnonymous}, isAuthenticated: ${anonymousAuthState.isAuthenticated}');

    // Check if user is authenticated (either registered or anonymous)
    final isAnyAuthenticated =
        authState.isAuthenticated || anonymousAuthState.isAuthenticated;
    final isLoading = authState.isLoading || anonymousAuthState.isLoading;

    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Yükleniyor...'),
            ],
          ),
        ),
      );
    }

    if (isAnyAuthenticated) {
      print('🔐 AuthWrapper - Navigating to HomePage');
      return const HomePage();
    } else {
      print('🔐 AuthWrapper - Navigating to GuestWelcomePage');
      return const GuestWelcomePage();
    }
  }
}
