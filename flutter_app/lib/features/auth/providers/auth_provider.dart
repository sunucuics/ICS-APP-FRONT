import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/models/user_model.dart';
import '../../../core/network/interceptors/auth_interceptor.dart';
import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/fcm_service.dart';
import '../../../core/services/token_storage_service.dart';
import '../../../core/utils/error_utils.dart';
import '../../../core/utils/logger.dart';
import '../data/auth_repository.dart';
import 'anonymous_auth_provider.dart' as anonymous;

// Admin provider imports — logout'ta invalidate etmek için
import '../../admin/providers/admin_notifications_provider.dart';
import '../../admin/providers/admin_dashboard_provider.dart';
import '../../admin/providers/admin_orders_provider.dart';
import '../../admin/providers/admin_products_provider.dart';
import '../../admin/providers/admin_services_provider.dart';
import '../../admin/providers/admin_appointments_provider.dart';
import '../../admin/providers/admin_categories_provider.dart';
import '../../admin/providers/admin_discounts_provider.dart';
import '../../admin/providers/admin_settings_provider.dart';
import '../../admin/providers/admin_users_provider.dart';
import '../../admin/providers/admin_comments_provider.dart';

// Auth Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// Auth State
@immutable
class AuthState {
  final UserProfile? user;
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    UserProfile? user,
    bool? isLoading,
    String? error,
    bool? isAuthenticated,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

// Auth State Notifier
class AuthNotifier extends StateNotifier<AuthState> with WidgetsBindingObserver {
  final AuthRepository _authRepository;
  final Ref _ref;
  bool _isInitialized = false;
  bool _isLoggingIn = false;
  bool _isLoadingProfile = false; // Guard: çift _loadUserProfile() çağrısını önler

  /// Initialization completer - splash screen bu future'ı bekler.
  /// _checkInitialAuthStatus() tamamlandığında complete olur.
  final Completer<void> _initCompleter = Completer<void>();
  Future<void> get initialized => _initCompleter.future;

  AuthNotifier(this._authRepository, this._ref) : super(const AuthState()) {
    WidgetsBinding.instance.addObserver(this);
    _listenToAuthStateChanges();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// App lifecycle: background → foreground geçişinde proaktif token refresh.
  /// Token expired ise interceptor'ın 401→refresh döngüsünü beklemek yerine
  /// burada önceden refresh yapar → kullanıcı "yavaş" hissetmez.
  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
    if (lifecycleState == AppLifecycleState.resumed && state.isAuthenticated) {
      AppLogger.debug('AuthProvider: App resumed, checking token freshness...');
      _proactiveTokenRefresh();
    }
  }

  /// Background'dan dönüşte token expired veya expire'a yakınsa sessizce yenile.
  Future<void> _proactiveTokenRefresh() async {
    try {
      final shouldRefresh = await TokenStorageService.shouldRefreshToken();
      if (!shouldRefresh) return;

      final refreshToken = await TokenStorageService.getRefreshToken();
      if (refreshToken == null) return;

      AppLogger.debug('AuthProvider: Proactive token refresh on app resume...');
      await _authRepository.refreshToken(refreshToken);
      AppLogger.success('AuthProvider: Proactive token refresh successful');
    } catch (e) {
      // Sessiz hata - interceptor gerekirse 401'de tekrar deneyecek
      AppLogger.warning('AuthProvider: Proactive refresh failed (non-critical)', e);
    }
  }

  // Listen to Firebase auth state changes
  void _listenToAuthStateChanges() {
    try {
      FirebaseAuthService.authStateChanges.listen((User? firebaseUser) async {
        AppLogger.debug(
            'AuthProvider: Firebase auth state changed - User: ${firebaseUser?.uid ?? 'null'}');
        if (firebaseUser != null) {
          // User is signed in via Firebase
          // Guard: login sırasında veya zaten profil yükleniyorsa atla
          if (!_isLoggingIn && !_isLoadingProfile && !state.isAuthenticated) {
            await _loadUserProfile();
          }
        } else {
          // User is signed out from Firebase
          // Token varsa oturumu koru (token-based auth çalışmaya devam eder)
          final hasTokens = await TokenStorageService.hasTokens();
          if (!hasTokens) {
            AppLogger.debug('AuthProvider: User signed out, no tokens found');
            state = const AuthState(isAuthenticated: false);
          } else {
            AppLogger.debug('AuthProvider: Firebase user null but tokens exist, keeping session');
          }
        }
      });

      // Check current auth status immediately on startup
      _checkInitialAuthStatus();
    } catch (e) {
      AppLogger.error('Firebase auth state listener setup failed', e);
      _checkAuthStatusManually();
    }
  }

  // Check initial auth status when provider is created
  Future<void> _checkInitialAuthStatus() async {
    if (_isInitialized) return;

    try {
      AppLogger.debug('AuthProvider: Checking initial auth status...');

      // Hızlı kontrol - sadece token varlığı (ağ çağrısı YOK, anında döner)
      final hasTokens = await TokenStorageService.hasTokens();

      AppLogger.debug('AuthProvider: Initial auth - hasTokens: $hasTokens');

      if (hasTokens) {
        // Proaktif token refresh: expired veya expire'a yakınsa ÖNCE refresh yap
        // Bu sayede _loadUserProfile() valid token ile çalışır,
        // interceptor'ın 401→refresh→retry döngüsüne gerek kalmaz → daha hızlı startup
        try {
          final shouldRefresh = await TokenStorageService.shouldRefreshToken();
          if (shouldRefresh) {
            AppLogger.debug('AuthProvider: Token needs refresh on startup, refreshing proactively...');
            final refreshToken = await TokenStorageService.getRefreshToken();
            if (refreshToken != null) {
              await _authRepository.refreshToken(refreshToken);
              AppLogger.success('AuthProvider: Proactive startup refresh successful');
            }
          }
        } catch (e) {
          // Proaktif refresh başarısız olursa devam et - interceptor halleder
          AppLogger.warning('AuthProvider: Proactive startup refresh failed (non-critical)', e);
        }

        // Token var → profil yükle
        await _loadUserProfile();
      } else {
        // Token yok → Firebase kontrolü
        final isFirebaseSignedIn = FirebaseAuthService.isSignedIn;
        if (isFirebaseSignedIn) {
          await _loadUserProfile();
        } else {
          state = const AuthState(isAuthenticated: false);
        }
      }

      _isInitialized = true;
    } catch (e) {
      AppLogger.error('Initial auth check failed', e);
      state = const AuthState(isAuthenticated: false);
      _isInitialized = true;
    } finally {
      // Splash screen'in beklemesini bitir - başarılı veya başarısız fark etmez
      if (!_initCompleter.isCompleted) {
        _initCompleter.complete();
      }
    }
  }

  // Fallback method for manual auth check
  Future<void> _checkAuthStatusManually() async {
    try {
      final hasTokens = await TokenStorageService.hasTokens();
      if (hasTokens) {
        await _loadUserProfile();
      } else {
        state = const AuthState(isAuthenticated: false);
      }
    } catch (e) {
      AppLogger.error('Manual auth check failed', e);
      state = const AuthState(isAuthenticated: false);
    }
  }

  /// Geçici hata mı (timeout, network) yoksa gerçek auth hatası mı kontrol et
  bool _isTemporaryError(dynamic error) => ErrorUtils.isTemporaryError(error);

  /// Profil yükle - BASİTLEŞTİRİLMİŞ versiyon
  ///
  /// Sadece TEK bir getCurrentUser() çağrısı yapar.
  /// Token refresh işlemi auth interceptor tarafından otomatik yapılır (401 → refresh → retry).
  /// Manuel refresh/retry fallback YOK - interceptor'a güveniyoruz.
  /// Timeout YOK - Dio'nun kendi 30s timeout'u yeterli, interceptor'u yarıda kesmez.
  Future<void> _loadUserProfile() async {
    // Guard: zaten yükleniyorsa tekrar çağırma (çift çağrı önleme)
    if (_isLoadingProfile) {
      AppLogger.debug('AuthProvider: Profile already loading, skipping duplicate call');
      return;
    }
    _isLoadingProfile = true;

    // Don't set loading if already authenticated (prevents UI flicker)
    if (!state.isAuthenticated) {
      state = state.copyWith(isLoading: true, error: null);
    }

    try {
      // TEK çağrı - interceptor 401 gelirse otomatik refresh + retry yapacak
      // Timeout YOK - Dio'nun 30s timeout'u interceptor'un refresh+retry döngüsünü kapsar
      final user = await _authRepository.getCurrentUser();

      if (user != null) {
        state = state.copyWith(
          user: user,
          isAuthenticated: true,
          isLoading: false,
        );

        // Update FCM token to backend (fire-and-forget)
        FCMService.updateTokenToBackend().catchError((e) {
          AppLogger.warning('Failed to update FCM token after profile load', e);
        });
      } else {
        // user == null → backend erişilemedi veya kullanıcı bulunamadı
        // Zaten authenticated ise oturumu koru
        if (state.isAuthenticated && state.user != null) {
          AppLogger.warning('AuthProvider: Profile reload failed, keeping existing session');
          state = state.copyWith(isLoading: false);
          return;
        }

        // Token varsa geçici hata olabilir, oturumu koru (loading kapat)
        final hasTokens = await TokenStorageService.hasTokens();
        if (hasTokens) {
          AppLogger.warning('AuthProvider: Profile null but tokens exist, keeping session');
          state = state.copyWith(isLoading: false);
          return;
        }

        // Token da yok - gerçekten giriş yapılmamış
        state = state.copyWith(isAuthenticated: false, isLoading: false);
      }
    } catch (e) {
      AppLogger.error('AuthProvider: Error loading profile', e);

      // Geçici hata (timeout, network) → oturumu koru
      if (_isTemporaryError(e)) {
        AppLogger.warning('AuthProvider: Temporary error, keeping session');
        if (state.isAuthenticated && state.user != null) {
          state = state.copyWith(isLoading: false);
          return;
        }
        final hasTokens = await TokenStorageService.hasTokens();
        if (hasTokens) {
          state = state.copyWith(isLoading: false);
          return;
        }
      }

      // Gerçek auth hatası → oturumu kapat
      AppLogger.error('AuthProvider: Auth error, signing out...', e);
      await FirebaseAuthService.signOut();
      await TokenStorageService.clearTokens();
      state = state.copyWith(
        error: e.toString(),
        isAuthenticated: false,
        isLoading: false,
      );
    } finally {
      _isLoadingProfile = false;
    }
  }

  // Login
  Future<bool> login(String email, String password) async {
    AppLogger.info(
        'AuthProvider - Starting login for: ${AppLogger.maskEmail(email)}');

    // Eski oturumdan kalan interceptor state'ini temizle
    // Admin logout → customer login geçişinde kalan stale state'i önler
    AuthInterceptor.reset();

    state = state.copyWith(isLoading: true, error: null);
    _isLoggingIn = true;

    try {
      AppLogger.debug('AuthProvider - Calling auth repository login...');
      final response = await _authRepository.login(email, password);
      AppLogger.success(
          'AuthProvider - Login successful, user: ${AppLogger.maskEmail(response.user.email ?? '')}');
      AppLogger.debug('AuthProvider - User ID: ${response.userId}');
      AppLogger.debug(
          'AuthProvider - Token exists: ${response.idToken.isNotEmpty}');

      // Update state with successful login
      state = state.copyWith(
        user: response.user,
        isAuthenticated: true,
        isLoading: false,
        error: null,
      );

      // Clear anonymous authentication when user logs in
      try {
        await _ref.read(anonymous.anonymousAuthProvider.notifier).signOut();
        AppLogger.debug('AuthProvider - Anonymous auth cleared');
      } catch (e) {
        AppLogger.warning('AuthProvider - Error clearing anonymous auth', e);
      }

      // Update FCM token to backend after successful login
      // (Login already updates it, but this ensures it's updated)
      FCMService.updateTokenToBackend().catchError((e) {
        AppLogger.warning('Failed to update FCM token after login', e);
      });

      AppLogger.success('AuthProvider - Login completed successfully');
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('AuthProvider - Login failed', e, stackTrace);
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
      return false;
    } finally {
      _isLoggingIn = false;
    }
  }

  // Register
  Future<bool> register({
    required String name,
    String? phone,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    _isLoggingIn = true; // Use same flag to prevent authStateChanged from loading profile

    try {
      final response = await _authRepository.register(
        name: name,
        phone: phone,
        email: email,
        password: password,
      );

      // Use the returned user profile directly (not from authStateChanged)
      state = state.copyWith(
        user: response.user,
        isAuthenticated: true,
        isLoading: false,
        error: null,
      );

      // Clear anonymous authentication when user registers
      try {
        await _ref.read(anonymous.anonymousAuthProvider.notifier).signOut();
        AppLogger.debug('AuthProvider - Anonymous auth cleared after register');
      } catch (e) {
        AppLogger.warning('AuthProvider - Error clearing anonymous auth', e);
      }

      // Update FCM token to backend after successful registration
      FCMService.updateTokenToBackend().catchError((e) {
        AppLogger.warning('Failed to update FCM token after register', e);
      });

      return true;
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
      return false;
    } finally {
      _isLoggingIn = false;
    }
  }

  // Reset Password
  Future<bool> resetPassword(String email) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authRepository.resetPassword(email);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    AppLogger.debug('AuthProvider - Starting logout process');
    state = state.copyWith(isLoading: true);

    try {
      AppLogger.debug('AuthProvider - Calling auth repository logout...');
      await _authRepository.logout();
      AppLogger.success('AuthProvider - Logout successful');

      // Admin provider'larını ve SSE stream'lerini temizle.
      // Bu olmadan admin provider'lar bellekte kalır, SSE bağlantısı açık kalır
      // ve customer login sırasında arka planda admin endpoint'leri çağrılmaya devam eder.
      _invalidateAllAdminProviders();

      // Immediately update state to logged out since logout was successful
      state = const AuthState(isAuthenticated: false, isLoading: false);
      AppLogger.debug('AuthProvider - State updated to logged out');
    } catch (e) {
      // Even if logout fails, update state to not loading
      AppLogger.error('AuthProvider - Logout error', e);
      // Yine de admin state'ini temizle
      _invalidateAllAdminProviders();
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Tüm admin provider'larını invalidate et.
  /// Logout sırasında çağrılır — SSE stream, dashboard, orders vb. temizlenir.
  /// StateNotifierProvider'lar dispose olur, FutureProvider cache'leri silinir.
  void _invalidateAllAdminProviders() {
    AppLogger.debug('AuthProvider - Invalidating all admin providers...');
    try {
      // SSE stream ve bildirimler (en kritik — açık bağlantı)
      _ref.invalidate(adminPanelNotificationsNotifierProvider);
      _ref.invalidate(adminNotificationStreamServiceProvider);
      _ref.invalidate(adminNotificationTemplatesNotifierProvider);
      _ref.invalidate(adminNotificationTemplatesProvider);
      _ref.invalidate(adminNotificationCampaignsProvider);
      _ref.invalidate(adminUserSegmentsProvider);
      _ref.invalidate(adminPanelUnreadCountProvider);
      _ref.invalidate(adminPanelNotificationsProvider);

      // Dashboard
      _ref.invalidate(adminDashboardStatsProvider);
      _ref.invalidate(adminDashboardDataProvider);
      _ref.invalidate(adminDashboardRefreshProvider);

      // Orders
      _ref.invalidate(adminOrdersProvider);
      _ref.invalidate(adminOrdersNotifierProvider);
      _ref.invalidate(adminOrdersQueueProvider);
      _ref.invalidate(adminOrdersTestProvider);
      _ref.invalidate(adminEmailTestProvider);

      // Products, Services, Categories, Appointments
      _ref.invalidate(adminProductsProvider);
      _ref.invalidate(adminProductsNotifierProvider);
      _ref.invalidate(adminServicesProvider);
      _ref.invalidate(adminServicesNotifierProvider);
      _ref.invalidate(adminCategoriesProvider);
      _ref.invalidate(adminCategoriesNotifierProvider);
      _ref.invalidate(adminAppointmentsProvider);
      _ref.invalidate(adminAppointmentsNotifierProvider);

      // Discounts, Settings, Users, Comments
      _ref.invalidate(adminDiscountsProvider);
      _ref.invalidate(adminDiscountsNotifierProvider);
      _ref.invalidate(adminSystemSettingsProvider);
      _ref.invalidate(adminSettingsNotifierProvider);
      _ref.invalidate(adminEmailTemplatesProvider);
      _ref.invalidate(adminEmailTemplatesNotifierProvider);
      _ref.invalidate(adminUsersProvider);
      _ref.invalidate(adminCommentsProvider);

      AppLogger.success('AuthProvider - All admin providers invalidated');
    } catch (e) {
      AppLogger.warning('AuthProvider - Error invalidating admin providers', e);
    }
  }

  // Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  // Refresh user data
  Future<void> refreshUser() async {
    if (!state.isAuthenticated) return;

    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        state = state.copyWith(user: user);
      }
    } catch (e) {
      AppLogger.error('Failed to refresh user', e);
    }
  }
}

// Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthNotifier(authRepository, ref);
});

// Convenience providers
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isAuthenticated;
});

final currentUserProvider = Provider<UserProfile?>((ref) {
  return ref.watch(authProvider).user;
});

final authLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isLoading;
});

final authErrorProvider = Provider<String?>((ref) {
  return ref.watch(authProvider).error;
});
