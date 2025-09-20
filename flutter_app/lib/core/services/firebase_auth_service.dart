import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static FirebaseAuth? _auth;

  static FirebaseAuth get _firebaseAuth {
    if (_auth == null) {
      try {
        _auth = FirebaseAuth.instance;
      } catch (e) {
        print('❌ Firebase Auth not available: $e');
        throw Exception('Firebase Auth not initialized');
      }
    }
    return _auth!;
  }

  // Get current user
  static User? get currentUser => _firebaseAuth.currentUser;

  // Get current user ID token (with automatic refresh)
  static Future<String?> getIdToken({bool forceRefresh = false}) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) return null;

      return await user.getIdToken(forceRefresh);
    } catch (e) {
      print('Error getting ID token: $e');
      return null;
    }
  }

  // Sign in with email and password
  static Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error signing in: $e');
      rethrow;
    }
  }

  // Create user with email and password
  static Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    print('🔥 Firebase: Attempting to create user with email: $email');
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('🔥 Firebase: User created successfully for email: $email');
      return result;
    } on FirebaseAuthException catch (e) {
      print('🔥 Firebase Auth Error: ${e.code} - ${e.message}');
      print('🔥 Firebase Auth Error Details: email=$email, code=${e.code}');

      // Convert Firebase errors to user-friendly messages
      switch (e.code) {
        case 'email-already-in-use':
          print('🔥 Firebase: Email already in use: $email');
          throw Exception('Bu e-posta zaten kayıtlı');
        case 'weak-password':
          print('🔥 Firebase: Weak password for email: $email');
          throw Exception('Şifre çok zayıf');
        case 'invalid-email':
          print('🔥 Firebase: Invalid email: $email');
          throw Exception('Geçersiz e-posta adresi');
        case 'operation-not-allowed':
          print('🔥 Firebase: Operation not allowed for email: $email');
          throw Exception('E-posta/şifre girişi devre dışı');
        default:
          print(
              '🔥 Firebase: Unknown error for email: $email, error: ${e.message}');
          throw Exception('Hesap oluşturulurken bir hata oluştu: ${e.message}');
      }
    } catch (e) {
      print('🔥 Firebase: General error creating user: $e');
      rethrow;
    }
  }

  // Sign out
  static Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      rethrow;
    }
  }

  // Send password reset email
  static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Error sending password reset email: $e');
      rethrow;
    }
  }

  // Listen to auth state changes
  static Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Check if user is signed in
  static bool get isSignedIn => _firebaseAuth.currentUser != null;

  // Get user email
  static String? get userEmail => _firebaseAuth.currentUser?.email;

  // Get user UID
  static String? get userUid => _firebaseAuth.currentUser?.uid;
}
