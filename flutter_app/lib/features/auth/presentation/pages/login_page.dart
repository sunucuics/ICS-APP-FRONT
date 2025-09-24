import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../providers/auth_provider.dart';
import 'register_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      print('🔐 LoginPage - Starting login process');
      
      // Check if widget is still mounted
      if (!mounted) return;
      
      // Clear any previous errors
      ref.read(authProvider.notifier).clearError();

      final success = await ref.read(authProvider.notifier).login(
            _emailController.text.trim(),
            _passwordController.text,
          );

      print('🔐 LoginPage - Login result: $success');
      
      // Check if widget is still mounted after async operation
      if (!mounted) return;
      
      print(
          '🔐 LoginPage - Auth state: ${ref.read(authProvider).isAuthenticated}');

      if (success && mounted) {
        print('🔐 LoginPage - Login successful, navigating to HomePage');
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Giriş başarılı!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );

        // Navigate immediately - AuthWrapper will handle the rest
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else if (!success && mounted) {
        // Show error message
        final error = ref.read(authErrorProvider);
        if (error != null) {
          String userFriendlyError;

          // Convert API errors to user-friendly messages
          if (error.contains('ApiException')) {
            final apiException = error;
            if (apiException.contains('UNAUTHORIZED') ||
                apiException.contains('401')) {
              userFriendlyError = 'E-posta veya şifre hatalı';
            } else if (apiException.contains('NO_INTERNET')) {
              userFriendlyError = 'İnternet bağlantısı bulunamadı';
            } else if (apiException.contains('CONNECTION_TIMEOUT')) {
              userFriendlyError = 'Bağlantı zaman aşımına uğradı';
            } else {
              userFriendlyError = 'Giriş yapılırken bir hata oluştu';
            }
          } else {
            userFriendlyError = 'Giriş yapılırken bir hata oluştu';
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(userFriendlyError),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

    // AuthWrapper will handle navigation automatically
    print('🔐 LoginPage - Build: isLoading=$isLoading, isAuthenticated=${authState.isAuthenticated}');

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Add top spacing for center effect
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                  // Logo/Title
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/images/ics_logo.jpg',
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildColoredTitle(context),
                          const SizedBox(height: 4),
                          Text(
                            'Hoş geldiniz',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-posta',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'E-posta gerekli';
                      }
                      if (!value.contains('@')) {
                        return 'Geçerli e-posta girin';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Şifre gerekli';
                      }
                      if (value.length < 6) {
                        return 'Şifre en az 6 karakter olmalı';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => _showForgotPassword(),
                      child: const Text('Şifremi Unuttum'),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  ElevatedButton(
                    onPressed: isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Giriş Yap',
                            style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 16),

                  // Register Link
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Text('Hesabınız yok mu? Kayıt olun'),
                  ),

                  // Add bottom spacing
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showForgotPassword() {
    final emailController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Şifremi Unuttum'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('E-posta adresinizi girin, şifre sıfırlama bağlantısı gönderelim.'),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'E-posta',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final email = emailController.text.trim();
              if (email.isEmpty || !email.contains('@')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Geçerli bir e-posta adresi girin'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              
              Navigator.of(context).pop();
              
              try {
                await ref.read(authProvider.notifier).resetPassword(email);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Şifre sıfırlama e-postası gönderildi. E-posta kutunuzu kontrol edin.'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Hata: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text('Gönder'),
          ),
        ],
      ),
    );
  }

  Widget _buildColoredTitle(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
        children: [
          TextSpan(
            text: 'Innova Craft ',
            style: TextStyle(
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
          ),
          // S - mavi
          const TextSpan(
            text: 'S',
            style: TextStyle(color: Colors.blue),
          ),
          // T - turuncu
          const TextSpan(
            text: 'T',
            style: TextStyle(color: Colors.orange),
          ),
          // U - yeşil
          const TextSpan(
            text: 'U',
            style: TextStyle(color: Colors.green),
          ),
          // D - kırmızı
          const TextSpan(
            text: 'D',
            style: TextStyle(color: Colors.red),
          ),
          // I - sarı
          const TextSpan(
            text: 'I',
            style: TextStyle(color: Colors.yellow),
          ),
          // O - pembe
          const TextSpan(
            text: 'O',
            style: TextStyle(color: Colors.pink),
          ),
        ],
      ),
    );
  }
}
