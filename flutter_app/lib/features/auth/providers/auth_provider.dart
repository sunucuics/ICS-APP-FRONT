import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/fcm_service.dart';
import '../../../core/services/token_storage_service.dart';
import '../../../core/utils/logger.dart';
import '../data/auth_repository.dart';
import 'anonymous_auth_provider.dart' as anonymous;

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
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final Ref _ref;
  bool _isInitialized = false;
  bool _isLoggingIn = false;

  AuthNotifier(this._authRepository, this._ref) : super(const AuthState()) {
    _listenToAuthStateChanges();
  }

  // Listen to Firebase auth state changes
  void _listenToAuthStateChanges() {
    try {
      FirebaseAuthService.authStateChanges.listen((User? firebaseUser) async {
        AppLogger.debug(
            'AuthProvider: Firebase auth state changed - User: ${firebaseUser?.uid ?? 'null'}');
        if (firebaseUser != null) {
          // User is signed in
          if (!_isLoggingIn) {
            await _loadUserProfile();
          }
        } else {
          // User is signed out from Firebase
          // But check if we have tokens - token-based auth might still work
          final hasTokens = await TokenStorageService.hasTokens();
          if (!hasTokens) {
            // No tokens either, user is truly signed out
            AppLogger.debug('AuthProvider: User signed out, no tokens found, updating state');
            state = const AuthState(isAuthenticated: false);
          } else {
            // Firebase user is null but tokens exist
            // Don't immediately sign out - let _checkInitialAuthStatus handle it
            AppLogger.debug('AuthProvider: Firebase user null but tokens exist, keeping session');
            // If not yet initialized, _checkInitialAuthStatus will handle the auth flow
            // If already initialized and authenticated, keep the session
            if (_isInitialized && !state.isAuthenticated) {
              // Already initialized but not authenticated - try to load profile with tokens
              await _loadUserProfile();
            }
          }
        }
      });

      // Check current auth status immediately on startup (optimized)
      _checkInitialAuthStatus();
    } catch (e) {
      AppLogger.error('Firebase auth state listener setup failed', e);
      // Fallback to manual auth check
      _checkAuthStatusManually();
    }
  }

  // Check initial auth status when provider is created (optimized with timeout)
  Future<void> _checkInitialAuthStatus() async {
    if (_isInitialized) return;

    try {
      AppLogger.debug('AuthProvider: Checking initial auth status...');

      // Fast check - just Firebase auth state (no API call)
      final isLoggedIn = await _authRepository
          .isLoggedIn()
          .timeout(const Duration(seconds: 2), onTimeout: () {
        AppLogger.warning('Auth check timeout, assuming not logged in');
        return false;
      });

      AppLogger.debug(
          'AuthProvider: Initial auth status - isLoggedIn: $isLoggedIn');

      if (isLoggedIn) {
        // Load user profile with timeout
        await _loadUserProfile();
      } else {
        state = const AuthState(isAuthenticated: false);
      }

      _isInitialized = true;
    } catch (e) {
      AppLogger.error('Initial auth check failed', e);
      state = const AuthState(isAuthenticated: false);
      _isInitialized = true;
    }
  }

  // Fallback method for manual auth check
  Future<void> _checkAuthStatusManually() async {
    try {
      final isLoggedIn = await _authRepository.isLoggedIn();
      if (isLoggedIn) {
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
  bool _isTemporaryError(dynamic error) {
    final errorStr = error.toString().toLowerCase();
    return errorStr.contains('timeout') ||
        errorStr.contains('connection') ||
        errorStr.contains('network') ||
        errorStr.contains('socket') ||
        errorStr.contains('receive_timeout') ||
        errorStr.contains('send_timeout') ||
        errorStr.contains('connection_timeout') ||
        errorStr.contains('no_internet');
  }

  // Load user profile when Firebase user is authenticated (optimized with timeout)
  Future<void> _loadUserProfile() async {
    // Don't set loading if already authenticated (prevents UI flicker)
    if (!state.isAuthenticated) {
      state = state.copyWith(isLoading: true, error: null);
    }

    try {
      // Add timeout to prevent blocking on slow network
      // 15s - mobil ağda backend + Firebase doğrulama zinciri yavaş olabilir
      final user = await _authRepository
          .getCurrentUser()
          .timeout(const Duration(seconds: 15), onTimeout: () {
        AppLogger.warning('User profile load timeout');
        return null;
      });

      if (user != null) {
        state = state.copyWith(
          user: user,
          isAuthenticated: true,
          isLoading: false,
        );
        
        // Update FCM token to backend when user profile is loaded
        // This ensures token is updated even if login didn't trigger it
        FCMService.updateTokenToBackend().catchError((e) {
          AppLogger.warning('Failed to update FCM token after profile load', e);
        });
      } else {
        // user == null → timeout veya backend erişilemedi
        // Eğer zaten authenticated ise oturumu KORU (geçici hata olabilir)
        if (state.isAuthenticated && state.user != null) {
          AppLogger.warning('AuthProvider: Profile reload failed but user already authenticated, keeping session');
          state = state.copyWith(isLoading: false);
          return;
        }

        // Token varsa ama user profile çekilemiyorsa, token refresh deneyebiliriz
        final hasTokens = await TokenStorageService.hasTokens();
        if (hasTokens) {
          AppLogger.debug('AuthProvider: Token exists but user profile failed, attempting token refresh...');
          try {
            final refreshToken = await TokenStorageService.getRefreshToken();
            if (refreshToken != null) {
              await _authRepository.refreshToken(refreshToken);
              // Token yenilendi, tekrar user profile çekmeyi dene
              final retryUser = await _authRepository.getCurrentUser();
              if (retryUser != null) {
                state = state.copyWith(
                  user: retryUser,
                  isAuthenticated: true,
                  isLoading: false,
                );
                return;
              }
            }
          } catch (refreshError) {
            AppLogger.warning('AuthProvider: Token refresh failed', refreshError);
            // Geçici hata ise oturumu koru
            if (_isTemporaryError(refreshError)) {
              AppLogger.warning('AuthProvider: Temporary error during refresh, keeping session');
              state = state.copyWith(isLoading: false);
              return;
            }
          }
        }

        // Token yok veya gerçek auth hatası - oturumu kapat
        AppLogger.warning(
            'AuthProvider: No valid session found. Signing out...');
        await FirebaseAuthService.signOut();
        await TokenStorageService.clearTokens();
        state = state.copyWith(
          isAuthenticated: false,
          isLoading: false,
          error: 'User profile not found. Please try again.',
        );
      }
    } catch (e) {
      // Geçici hata ise (timeout, network) oturumu KORU
      if (_isTemporaryError(e)) {
        AppLogger.warning('AuthProvider: Temporary error loading profile, keeping session', e);
        // Zaten authenticated ise state'i koru
        if (state.isAuthenticated && state.user != null) {
          state = state.copyWith(isLoading: false);
          return;
        }
        // İlk yükleme ise token'lar varsa authenticated kabul et
        final hasTokens = await TokenStorageService.hasTokens();
        if (hasTokens) {
          state = state.copyWith(isLoading: false);
          return;
        }
      }

      // Gerçek auth hatası (401) - token refresh dene
      final hasTokens = await TokenStorageService.hasTokens();
      if (hasTokens && e.toString().contains('401')) {
        AppLogger.debug('AuthProvider: 401 error, attempting token refresh...');
        try {
          final refreshToken = await TokenStorageService.getRefreshToken();
          if (refreshToken != null) {
            await _authRepository.refreshToken(refreshToken);
            // Token yenilendi, tekrar user profile çekmeyi dene
            final retryUser = await _authRepository.getCurrentUser();
            if (retryUser != null) {
              state = state.copyWith(
                user: retryUser,
                isAuthenticated: true,
                isLoading: false,
              );
              return;
            }
          }
        } catch (refreshError) {
          AppLogger.warning('AuthProvider: Token refresh failed', refreshError);
          // Geçici hata ise yine oturumu koru
          if (_isTemporaryError(refreshError)) {
            AppLogger.warning('AuthProvider: Temporary error during 401 refresh, keeping session');
            state = state.copyWith(isLoading: false);
            return;
          }
        }
      }

      // Gerçek auth hatası ve refresh başarısız - oturumu kapat
      AppLogger.error('AuthProvider: Auth error, signing out...', e);
      await FirebaseAuthService.signOut();
      await TokenStorageService.clearTokens();
      state = state.copyWith(
        error: e.toString(),
        isAuthenticated: false,
        isLoading: false,
      );
    }
  }

  // Login
  Future<bool> login(String email, String password) async {
    AppLogger.info(
        'AuthProvider - Starting login for: ${AppLogger.maskEmail(email)}');
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

      // Immediately update state to logged out since logout was successful
      state = const AuthState(isAuthenticated: false, isLoading: false);
      AppLogger.debug('AuthProvider - State updated to logged out');
    } catch (e) {
      // Even if logout fails, update state to not loading
      AppLogger.error('AuthProvider - Logout error', e);
      state = state.copyWith(isLoading: false, error: e.toString());
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
