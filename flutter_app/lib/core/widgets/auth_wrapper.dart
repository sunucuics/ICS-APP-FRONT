import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/providers/anonymous_auth_provider.dart'
    as anonymous;
import '../../features/auth/presentation/pages/guest_welcome_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final anonymousAuthState = ref.watch(anonymous.authStateProvider);
    final anonymousUserAsync = ref.watch(anonymous.anonymousAuthProvider);

    // Auto sign-in anonymously if not authenticated
    ref.listen(anonymous.anonymousAuthProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user == null && previous?.value != null) {
            // User signed out, navigate to login page
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              }
            });
          } else if (user == null) {
            // No user initially, try to sign in anonymously
            ref
                .read(anonymous.anonymousAuthProvider.notifier)
                .signInAnonymously();
          }
        },
        loading: () {},
        error: (error, stack) {
          // On error, try to sign in anonymously
          ref
              .read(anonymous.anonymousAuthProvider.notifier)
              .signInAnonymously();
        },
      );
    });

    // Check anonymous user directly
    final isAnonymousAuthenticated = anonymousUserAsync.when(
      data: (user) => user != null,
      loading: () => false,
      error: (error, stack) => false,
    );

    // Check if user is authenticated (either registered or anonymous)
    // If registered user is authenticated, ignore anonymous authentication
    final isAnyAuthenticated = authState.isAuthenticated ||
        (!authState.isAuthenticated && isAnonymousAuthenticated);
    final isLoading = authState.isLoading ||
        (!authState.isAuthenticated && anonymousAuthState.isLoading);

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
