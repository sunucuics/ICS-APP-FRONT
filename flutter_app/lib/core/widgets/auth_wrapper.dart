import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/providers/anonymous_auth_provider.dart'
    as anonymous;
import '../../features/auth/presentation/pages/guest_welcome_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final anonymousAuthState = ref.watch(anonymous.authStateProvider);
    final anonymousUserAsync = ref.watch(anonymous.anonymousAuthProvider);

    // Check anonymous user directly
    final isAnonymousAuthenticated = anonymousUserAsync.when(
      data: (user) => user != null,
      loading: () => false,
      error: (error, stack) => false,
    );

    // Check if user is authenticated (either registered or anonymous)
    final isAnyAuthenticated =
        authState.isAuthenticated || isAnonymousAuthenticated;
    final isLoading = authState.isLoading || anonymousAuthState.isLoading;

    // AuthWrapper only handles widget rendering, navigation is handled by individual pages

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
      return const HomePage();
    } else {
      return const GuestWelcomePage();
    }
  }
}
