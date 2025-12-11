import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/providers/anonymous_auth_provider.dart'
    as anonymous;
import '../../features/auth/presentation/pages/guest_welcome_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    // Logo animation controller - optimized for faster startup
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Text animation controller - optimized for faster startup
    _textController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Logo scale animation
    _logoScale = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    // Logo opacity animation
    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    // Text opacity animation
    _textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    ));

    // Text slide animation
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));

    _startAnimations();
  }

  void _startAnimations() async {
    // Pre-load SharedPreferences while animations run
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('is_first_time') ?? true;

    // Start logo animation
    final logoAnimation = _logoController.forward();

    // Start text animation with minimal delay
    final textAnimation = Future.delayed(
      const Duration(milliseconds: 200),
      () => _textController.forward(),
    );

    // Wait for animations to complete and ensure minimum 1 second splash
    await Future.wait([
      logoAnimation,
      textAnimation,
      Future.delayed(const Duration(milliseconds: 1000)), // Minimum splash time
    ]);

    if (!mounted) return;
    _navigateToNextScreen(isFirstTime);
  }

  void _navigateToNextScreen(bool isFirstTime) {
    if (!mounted) return;

    if (isFirstTime) {
      // First time user - go to onboarding
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    } else {
      // Returning user - check auth and navigate accordingly
      _checkAuthAndNavigate();
    }
  }

  void _checkAuthAndNavigate() {
    if (!mounted) return;

    // Check auth state immediately (providers should be ready by now)
    final authState = ref.read(authProvider);
    final anonymousAuthState = ref.read(anonymous.anonymousAuthProvider);

    // Check if user is authenticated (either registered or anonymous)
    if (authState.isAuthenticated ||
        (anonymousAuthState.hasValue && anonymousAuthState.value != null)) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      // If not authenticated, navigate to welcome page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const GuestWelcomePage(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF0F1115),
                    const Color(0xFF1A1D23),
                    const Color(0xFF171A20),
                  ]
                : [
                    const Color(0xFFF6F7F9),
                    const Color(0xFFE8F0FE),
                    const Color(0xFFF1F3F4),
                  ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo Section
                AnimatedBuilder(
                  animation: _logoController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _logoScale.value,
                      child: Opacity(
                        opacity: _logoOpacity.value,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryOrange
                                    .withValues(alpha: 0.3),
                                blurRadius: 20,
                                spreadRadius: 5,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/ics_logo.jpg',
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                // Fallback to gradient and icon if logo not found
                                return Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        AppTheme.primaryOrange,
                                        AppTheme.secondaryOrange,
                                        AppTheme.lightOrange,
                                      ],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.brush,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                // Text Section
                AnimatedBuilder(
                  animation: _textController,
                  builder: (context, child) {
                    return SlideTransition(
                      position: _textSlide,
                      child: Opacity(
                        opacity: _textOpacity.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'INNOVA CRAFT STUDIO',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? Colors.white
                                    : const Color(0xFF111111),
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'El Yapımı Ürünler ve Sanat Eserleri',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: isDark
                                    ? const Color(0xFFB7C1CE)
                                    : const Color(0xFF5F6B7A),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 60),

                // Loading Indicator
                AnimatedBuilder(
                  animation: _textController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _textOpacity.value,
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryOrange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.primaryOrange,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
