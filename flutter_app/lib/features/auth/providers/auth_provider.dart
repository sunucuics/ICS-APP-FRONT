import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/models/user_model.dart';
import '../../../core/services/firebase_auth_service.dart';
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

  AuthNotifier(this._authRepository, this._ref) : super(const AuthState()) {
    _listenToAuthStateChanges();
  }

  // Listen to Firebase auth state changes
  void _listenToAuthStateChanges() {
    try {
      FirebaseAuthService.authStateChanges.listen((User? firebaseUser) async {
        print(
            '🔐 AuthProvider: Firebase auth state changed - User: ${firebaseUser?.uid}');
        if (firebaseUser != null) {
          // User is signed in
          await _loadUserProfile();
        } else {
          // User is signed out
          print('🔐 AuthProvider: User signed out, updating state');
          state = const AuthState(isAuthenticated: false);
        }
      });

      // Also check current auth status immediately on startup
      _checkInitialAuthStatus();
    } catch (e) {
      print('❌ Firebase auth state listener setup failed: $e');
      // Fallback to manual auth check
      _checkAuthStatusManually();
    }
  }

  // Check initial auth status when provider is created
  Future<void> _checkInitialAuthStatus() async {
    try {
      print('🔐 AuthProvider: Checking initial auth status...');
      final isLoggedIn = await _authRepository.isLoggedIn();
      print('🔐 AuthProvider: Initial auth status - isLoggedIn: $isLoggedIn');

      if (isLoggedIn) {
        await _loadUserProfile();
      } else {
        state = const AuthState(isAuthenticated: false);
      }
    } catch (e) {
      print('❌ Initial auth check failed: $e');
      state = const AuthState(isAuthenticated: false);
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
      print('❌ Manual auth check failed: $e');
      state = const AuthState(isAuthenticated: false);
    }
  }

  // Load user profile when Firebase user is authenticated
  Future<void> _loadUserProfile() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        state = state.copyWith(
          user: user,
          isAuthenticated: true,
          isLoading: false,
        );
      } else {
        // Firebase user exists but backend user fetch failed
        // This means the user was created in Firebase but not in backend
        // Sign out from Firebase to clean up the state
        print(
            '⚠️ Firebase user exists but backend user not found. Signing out...');
        await FirebaseAuthService.signOut();
        state = state.copyWith(
          isAuthenticated: false,
          isLoading: false,
          error: 'User profile not found. Please try again.',
        );
      }
    } catch (e) {
      // If there's an error, also sign out to clean up the state
      print('⚠️ Error loading user profile: $e. Signing out...');
      await FirebaseAuthService.signOut();
      state = state.copyWith(
        error: e.toString(),
        isAuthenticated: false,
        isLoading: false,
      );
    }
  }

  // Login
  Future<bool> login(String email, String password) async {
    print('🔐 AuthProvider - Starting login for: $email');
    state = state.copyWith(isLoading: true, error: null);

    try {
      print('🔐 AuthProvider - Calling auth repository login...');
      final response = await _authRepository.login(email, password);
      print('🔐 AuthProvider - Login successful, user: ${response.user.email}');
      print('🔐 AuthProvider - User ID: ${response.userId}');
      print('🔐 AuthProvider - Token exists: ${response.idToken.isNotEmpty}');

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
        print('🔐 AuthProvider - Anonymous auth cleared');
      } catch (e) {
        print('🔐 AuthProvider - Error clearing anonymous auth: $e');
      }

      print('🔐 AuthProvider - Login completed successfully');
      return true;
    } catch (e) {
      print('🔐 AuthProvider - Login failed: $e');
      print('🔐 AuthProvider - Error type: ${e.runtimeType}');
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
      return false;
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

    try {
      await _authRepository.register(
        name: name,
        phone: phone,
        email: email,
        password: password,
      );

      // Firebase auth state change will automatically update the state
      // No need to manually update state here

      return true;
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
      return false;
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
    print('🔐 AuthProvider - Starting logout process');
    state = state.copyWith(isLoading: true);

    try {
      print('🔐 AuthProvider - Calling auth repository logout...');
      await _authRepository.logout();
      print('🔐 AuthProvider - Logout successful');

      // Immediately update state to logged out since logout was successful
      state = const AuthState(isAuthenticated: false, isLoading: false);
      print('🔐 AuthProvider - State updated to logged out');
    } catch (e) {
      // Even if logout fails, update state to not loading
      print('🔐 AuthProvider - Logout error: $e');
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
      print('Failed to refresh user: $e');
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
