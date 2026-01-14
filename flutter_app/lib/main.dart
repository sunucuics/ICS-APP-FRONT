import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/auth_wrapper.dart';
import 'core/services/navigation_service.dart';
import 'core/services/snackbar_service.dart';
import 'core/providers/theme_provider.dart';
import 'core/services/theme_service.dart';
import 'core/services/fcm_service.dart';
import 'core/services/local_notification_service.dart';
import 'core/services/badge_service.dart';
import 'core/services/android_performance_service.dart';
import 'core/services/image_cache_service.dart';
import 'core/services/crash_prevention_service.dart';
import 'core/services/memory_management_service.dart';
import 'core/utils/route_aware_refresh_mixin.dart';
import 'features/auth/data/auth_api_service.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/register_page.dart';
import 'features/auth/presentation/pages/guest_welcome_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'core/widgets/video_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Parallel initialization of Android services for better performance
  if (Platform.isAndroid) {
    await Future.wait([
      AndroidPerformanceService.initialize(),
      ImageCacheService.initialize(),
      CrashPreventionService.initialize(),
      MemoryManagementService.initialize(),
    ]);
  }

  WidgetsBinding.instance.addPostFrameCallback((_) {
    // Pre-warm the engine for better performance
    if (Platform.isAndroid) {
      // Additional Android-specific performance optimizations
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  });

  // Initialize theme service (non-blocking, SharedPreferences is fast)
  final themeService = ThemeService();
  themeService.initialize().catchError((e) {
    print('⚠️ Theme service initialization failed: $e');
  });

  // Firebase initialization with error handling (critical, must complete)
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase initialized successfully');

    // Initialize Local Notification Service (required for foreground notifications)
    LocalNotificationService.initialize().then((_) {
      print('✅ Local Notification Service initialized successfully');
    }).catchError((e) {
      print('⚠️ Local Notification Service initialization failed: $e');
    });

    // Initialize Badge Service
    BadgeService.initialize().then((_) {
      print('✅ Badge Service initialized successfully');
    }).catchError((e) {
      print('⚠️ Badge Service initialization failed: $e');
    });

    // Initialize FCM service in background (non-blocking)
    // Don't wait for it to complete before starting the app
    FCMService.initialize().then((_) {
      print('✅ FCM service initialized successfully');
      
      // Set up FCM token update callback to backend
      final authApiService = AuthApiService();
      FCMService.onTokenUpdate = (String token) async {
        try {
          await authApiService.updateFcmToken(token);
          print('✅ FCM token updated to backend');
        } catch (e) {
          print('⚠️ Failed to update FCM token to backend: $e');
        }
      };
    }).catchError((e) {
      print('⚠️ FCM service initialization failed: $e');
      print('⚠️ Continuing without FCM...');
    });
  } catch (e) {
    print('❌ Firebase initialization failed: $e');
    print('⚠️ Continuing without Firebase...');

    // Try to initialize FCM even if Firebase failed (might work in some cases)
    FCMService.initialize().catchError((e) {
      print('⚠️ FCM service initialization failed: $e');
    });
  }

  // Start the app immediately without waiting for non-critical services
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // Initialize BadgeService
    BadgeService.initialize().then((_) {
      // Initialize with ref after widget is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        BadgeService.initializeWithRef(ref);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    
    // Listen to notifications count changes and update badge
    // This must be called within build method
    BadgeService.listenToNotifications(ref);

    return MaterialApp(
      title: 'Innova Craft Studio',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode, // Dynamic theme mode based on user preference
      home: const VideoSplashScreen(),
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: SnackBarService.scaffoldMessengerKey,
      navigatorObservers: [routeObserver],
      // Performance optimizations
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler
                .noScaling, // Disable text scaling for better performance
          ),
          child: child!,
        );
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr', 'TR'), // Turkish
        Locale('en', 'US'), // English
      ],
      locale: const Locale('tr', 'TR'), // Default to Turkish
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/welcome': (context) => const GuestWelcomePage(),
      },
    );
  }
}
