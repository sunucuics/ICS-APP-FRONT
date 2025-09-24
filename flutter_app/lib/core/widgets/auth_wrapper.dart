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
  void initState() {
    super.initState();
    // Android performance optimization - delay listener setup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _setupListeners();
      }
    });
  }

  void _setupListeners() {
    // Handle user sign out - navigate to welcome page
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
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // Check both registered user and anonymous user authentication
    final isLoading = authState.isLoading;
    final anonymousAuthState = ref.watch(anonymous.anonymousAuthProvider);

    if (isLoading || anonymousAuthState.isLoading) {
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

    // If registered user is authenticated, show HomePage
    if (authState.isAuthenticated) {
      return const HomePage();
    }
    
    // If anonymous user is authenticated, show HomePage
    if (anonymousAuthState.hasValue && anonymousAuthState.value != null) {
      return const HomePage();
    }
    
    // Show welcome page for unauthenticated users
    return const GuestWelcomePage();
  }
}
