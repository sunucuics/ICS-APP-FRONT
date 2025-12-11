import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/providers/anonymous_auth_provider.dart'
    as anonymous;
import '../../features/auth/presentation/pages/guest_welcome_page.dart';
import '../../features/home/presentation/pages/home_page.dart';

class AuthWrapper extends ConsumerStatefulWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    // Optimize: Check registered auth first (most common case)
    final authState = ref.watch(authProvider);

    // If registered user is authenticated, show HomePage immediately
    // No need to check anonymous auth
    if (authState.isAuthenticated) {
      return const HomePage();
    }

    // Only check anonymous auth if registered auth is not loading and not authenticated
    // This prevents unnecessary provider initialization
    if (!authState.isLoading) {
      final anonymousAuthState = ref.watch(anonymous.anonymousAuthProvider);

      // Handle anonymous user sign out - navigate to welcome page
      ref.listen(anonymous.anonymousAuthProvider, (previous, next) {
        if (!mounted) return;

        next.when(
          data: (user) {
            if (user == null && previous?.value != null) {
              // User signed out, navigate to welcome page
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const GuestWelcomePage(),
                    ),
                  );
                }
              });
            }
          },
          loading: () {},
          error: (error, stack) {
            // On error, show welcome page
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const GuestWelcomePage(),
                  ),
                );
              }
            });
          },
        );
      });

      // Show loading screen while checking anonymous authentication
      if (anonymousAuthState.isLoading) {
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

      // If anonymous user is authenticated, show HomePage
      if (anonymousAuthState.hasValue && anonymousAuthState.value != null) {
        return const HomePage();
      }
    } else {
      // Show loading screen while checking registered authentication
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

    // Show welcome page for unauthenticated users
    return const GuestWelcomePage();
  }
}
