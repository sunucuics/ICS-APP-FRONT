import 'dart:async';
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
  Timer? _loadingTimeoutTimer;
  bool _isTimedOut = false;

  @override
  void initState() {
    super.initState();
    // Güvenlik valfi: auth kontrolü 10 saniyeden uzun sürerse
    // kullanıcıyı sonsuz spinner'da bırakma — welcome sayfasına yönlendir
    _loadingTimeoutTimer = Timer(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          _isTimedOut = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _loadingTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Optimize: Check registered auth first (most common case)
    final authState = ref.watch(authProvider);

    // If registered user is authenticated, show HomePage immediately
    // No need to check anonymous auth
    if (authState.isAuthenticated) {
      _loadingTimeoutTimer?.cancel();
      return const HomePage();
    }

    // Only check anonymous auth if registered auth is not loading and not authenticated
    // This prevents unnecessary provider initialization
    if (!authState.isLoading) {
      _loadingTimeoutTimer?.cancel();

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
    } else if (!_isTimedOut) {
      // Show loading screen while checking registered authentication (max 10s)
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
    // _isTimedOut == true ve hâlâ loading → sonsuz spinner yerine welcome sayfasına düş

    // Show welcome page for unauthenticated users
    return const GuestWelcomePage();
  }
}
