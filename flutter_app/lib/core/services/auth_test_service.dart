import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_auth_service.dart';

class AuthTestService {
  // Test Firebase authentication flow
  static Future<void> testAuthFlow() async {
    print('🧪 Testing Firebase Authentication Flow...');
    
    // Test 1: Check if Firebase is initialized
    try {
      final currentUser = FirebaseAuthService.currentUser;
      print('✅ Firebase initialized successfully');
      print('📱 Current user: ${currentUser?.email ?? 'Not signed in'}');
    } catch (e) {
      print('❌ Firebase initialization failed: $e');
      return;
    }

    // Test 2: Test token retrieval
    try {
      final token = await FirebaseAuthService.getIdToken();
      if (token != null) {
        print('✅ Token retrieved successfully');
        print('🔑 Token length: ${token.length}');
      } else {
        print('ℹ️ No token available (user not signed in)');
      }
    } catch (e) {
      print('❌ Token retrieval failed: $e');
    }

    // Test 3: Test auth state changes
    try {
      FirebaseAuthService.authStateChanges.listen((User? user) {
        if (user != null) {
          print('🔄 Auth state changed: User signed in - ${user.email}');
        } else {
          print('🔄 Auth state changed: User signed out');
        }
      });
      print('✅ Auth state listener set up successfully');
    } catch (e) {
      print('❌ Auth state listener setup failed: $e');
    }

    print('🧪 Auth flow test completed');
  }

  // Test API interceptor
  static Future<void> testApiInterceptor() async {
    print('🧪 Testing API Interceptor...');
    
    // This would test the actual API calls with token handling
    // For now, just print the test structure
    print('✅ API Interceptor test structure ready');
    print('📝 To test: Make an API call and check token handling');
  }

  // Test logout flow
  static Future<void> testLogoutFlow() async {
    print('🧪 Testing Logout Flow...');
    
    try {
      if (FirebaseAuthService.isSignedIn) {
        print('📱 User is signed in, testing logout...');
        await FirebaseAuthService.signOut();
        print('✅ Logout completed successfully');
      } else {
        print('ℹ️ No user signed in, logout test skipped');
      }
    } catch (e) {
      print('❌ Logout test failed: $e');
    }
  }
}
