import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/anonymous_auth_service.dart';
import '../services/mock_anonymous_auth_service.dart';

// Anonymous Auth Service Provider - Using Mock for development
final anonymousAuthServiceProvider = Provider<MockAnonymousAuthService>((ref) {
  return MockAnonymousAuthService();
});

// Current User Provider - Using MockUser
final currentUserProvider = StreamProvider<MockUser?>((ref) {
  final authService = ref.read(anonymousAuthServiceProvider);
  return authService.authStateChanges;
});

// Auth State Provider - Using MockUser
final authStateProvider = Provider<AuthState>((ref) {
  final userAsync = ref.watch(currentUserProvider);

  return userAsync.when(
    data: (user) {
      if (user == null) {
        return const AuthState.unauthenticated();
      } else if (user.isAnonymous) {
        return AuthState.anonymous(user);
      } else {
        return AuthState.authenticated(user);
      }
    },
    loading: () => const AuthState.loading(),
    error: (error, stack) => AuthState.error(error.toString()),
  );
});

// Anonymous Auth Notifier - Using MockUser
class AnonymousAuthNotifier extends StateNotifier<AsyncValue<MockUser?>> {
  final MockAnonymousAuthService _authService;

  AnonymousAuthNotifier(this._authService) : super(const AsyncValue.loading()) {
    _initializeAuth();
  }

  void _initializeAuth() {
    _authService.authStateChanges.listen((user) {
      state = AsyncValue.data(user);
    });
  }

  Future<void> signInAnonymously() async {
    try {
      state = const AsyncValue.loading();
      final user = await _authService.signInAnonymously();
      state = AsyncValue.data(user);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> signOut() async {
    try {
      state = const AsyncValue.loading();
      await _authService.signOut();
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> linkWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      state = const AsyncValue.loading();
      final user = await _authService.linkWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = AsyncValue.data(user);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteAnonymousAccount() async {
    try {
      state = const AsyncValue.loading();
      await _authService.deleteAnonymousAccount();
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshToken() async {
    try {
      await _authService.refreshToken();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final anonymousAuthProvider =
    StateNotifierProvider<AnonymousAuthNotifier, AsyncValue<MockUser?>>((ref) {
  final authService = ref.read(anonymousAuthServiceProvider);
  return AnonymousAuthNotifier(authService);
});

// Convenience Providers
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    authenticated: (user) => true,
    anonymous: (user) => true,
    unauthenticated: () => false,
    loading: () => false,
    error: (error) => false,
  );
});

final isAnonymousProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    authenticated: (user) => false,
    anonymous: (user) => true,
    unauthenticated: () => false,
    loading: () => false,
    error: (error) => false,
  );
});

final currentUserDataProvider = Provider<MockUser?>((ref) {
  return ref.watch(currentUserProvider).when(
        data: (user) => user,
        loading: () => null,
        error: (error, stack) => null,
      );
});

final userTokenProvider = FutureProvider<String?>((ref) async {
  final authService = ref.read(anonymousAuthServiceProvider);
  return await authService.getIdToken();
});

final needsReauthProvider = Provider<bool>((ref) {
  final authService = ref.read(anonymousAuthServiceProvider);
  return authService.needsReauth;
});

// Auth State Enum
sealed class AuthState {
  const AuthState();

  const factory AuthState.loading() = _Loading;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.anonymous(MockUser user) = _Anonymous;
  const factory AuthState.authenticated(MockUser user) = _Authenticated;
  const factory AuthState.error(String message) = _Error;

  T when<T>({
    required T Function() loading,
    required T Function() unauthenticated,
    required T Function(MockUser user) anonymous,
    required T Function(MockUser user) authenticated,
    required T Function(String message) error,
  }) {
    return switch (this) {
      _Loading() => loading(),
      _Unauthenticated() => unauthenticated(),
      _Anonymous(user: final user) => anonymous(user),
      _Authenticated(user: final user) => authenticated(user),
      _Error(message: final message) => error(message),
    };
  }

  bool get isLoading => this is _Loading;
  bool get isUnauthenticated => this is _Unauthenticated;
  bool get isAnonymous => this is _Anonymous;
  bool get isAuthenticated => this is _Authenticated;
  bool get isError => this is _Error;

  MockUser? get user => switch (this) {
        _Anonymous(user: final user) ||
        _Authenticated(user: final user) =>
          user,
        _ => null,
      };

  String? get errorMessage => switch (this) {
        _Error(message: final message) => message,
        _ => null,
      };
}

class _Loading extends AuthState {
  const _Loading();
}

class _Unauthenticated extends AuthState {
  const _Unauthenticated();
}

class _Anonymous extends AuthState {
  final MockUser user;
  const _Anonymous(this.user);
}

class _Authenticated extends AuthState {
  final MockUser user;
  const _Authenticated(this.user);
}

class _Error extends AuthState {
  final String message;
  const _Error(this.message);
}
