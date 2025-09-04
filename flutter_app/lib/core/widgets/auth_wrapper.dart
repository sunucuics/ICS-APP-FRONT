import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    // Debug: Print auth state
    print(
        '🔐 AuthWrapper - isAuthenticated: ${authState.isAuthenticated}, isLoading: ${authState.isLoading}, user: ${authState.user?.email}');

    if (authState.isLoading) {
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

    if (authState.isAuthenticated) {
      print('🔐 AuthWrapper - Navigating to HomePage');
      return const HomePage();
    } else {
      print('🔐 AuthWrapper - Navigating to LoginPage');
      return const LoginPage();
    }
  }
}
