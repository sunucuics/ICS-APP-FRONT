import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../core/utils/logger.dart';

// Custom phone number formatter
class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove all non-digit characters
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Limit to 10 digits - if more than 10, don't allow the input
    if (digitsOnly.length > 10) {
      return oldValue; // Reject the input
    }

    // Format as 555 123 4567
    String formatted = '';
    if (digitsOnly.length >= 1) {
      formatted = digitsOnly.substring(
          0, digitsOnly.length > 3 ? 3 : digitsOnly.length);
    }
    if (digitsOnly.length >= 4) {
      formatted +=
          ' ${digitsOnly.substring(3, digitsOnly.length > 6 ? 6 : digitsOnly.length)}';
    }
    if (digitsOnly.length >= 7) {
      formatted += ' ${digitsOnly.substring(6, digitsOnly.length)}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _phoneError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hesap Oluştur'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),

                // Welcome Text
                Text(
                  'Hesabınızı Oluşturun',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                Text(
                  'Ücretsiz hesap oluşturun ve tüm özelliklerden yararlanın',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 48),

                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Ad Soyad',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ad soyad gerekli';
                    }
                    if (value.trim().length < 2) {
                      return 'Ad soyad en az 2 karakter olmalı';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Phone Field
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(
                        13), // 10 digits + 3 spaces max
                    _PhoneNumberFormatter(),
                  ],
                  onChanged: (value) {
                    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
                    if (digitsOnly.length > 10) {
                      setState(() {
                        _phoneError =
                            'Telefon numarası en fazla 10 haneli olabilir';
                      });
                    } else {
                      setState(() {
                        _phoneError = null;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Telefon (Opsiyonel)',
                    hintText: '555 123 4567',
                    prefixIcon: const Icon(Icons.phone_outlined),
                    border: const OutlineInputBorder(),
                    errorText: _phoneError,
                  ),
                  validator: (value) {
                    // Phone is optional, only validate format if provided
                    if (value == null || value.trim().isEmpty) {
                      return null; // No error if empty
                    }
                    // Backend expects format like '555 123 4567'
                    if (!RegExp(r'^[0-9\s]+$').hasMatch(value)) {
                      return 'Telefon numarası sadece rakam ve boşluk içermelidir';
                    }
                    // Check if it has the expected format (numbers with spaces)
                    final cleanNumber = value.replaceAll(' ', '');
                    if (cleanNumber.length < 10 || cleanNumber.length > 11) {
                      return 'Telefon numarası 10-11 haneli olmalıdır';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-posta',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'E-posta gerekli';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Geçerli bir e-posta adresi girin';
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
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
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

                // Confirm Password Field
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Şifre Tekrar',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Şifre tekrarı gerekli';
                    }
                    if (value != _passwordController.text) {
                      return 'Şifreler eşleşmiyor';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // Register Button
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            'Hesap Oluştur',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 24),

                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'veya',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 24),

                // Guest Mode Button
                SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () => _continueAsGuest(),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Misafir Olarak Devam Et',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Sign In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Zaten hesabınız var mı? '),
                    TextButton(
                      onPressed: () => _navigateToSignIn(),
                      child: const Text(
                        'Giriş yapın',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Format phone number to backend expected format (555 123 4567)
  // Returns null if phone is empty or null
  String? _formatPhoneNumber(String? phone) {
    // Return null if phone is null or empty/whitespace only
    if (phone == null || phone.trim().isEmpty) {
      return null;
    }

    // Remove all non-digit characters
    final cleanPhone = phone.replaceAll(RegExp(r'[^\d]'), '');

    // If it starts with 0, remove it
    final phoneWithoutZero =
        cleanPhone.startsWith('0') ? cleanPhone.substring(1) : cleanPhone;

    // Format as 555 123 4567 (3-3-4 digits)
    if (phoneWithoutZero.length == 10) {
      return '${phoneWithoutZero.substring(0, 3)} ${phoneWithoutZero.substring(3, 6)} ${phoneWithoutZero.substring(6)}';
    } else if (phoneWithoutZero.length == 11) {
      return '${phoneWithoutZero.substring(0, 3)} ${phoneWithoutZero.substring(3, 6)} ${phoneWithoutZero.substring(6)}';
    }

    // If format doesn't match expected, return as is
    return phone;
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final name = _nameController.text.trim();
    AppLogger.info('RegisterPage: Starting registration process');
    AppLogger.debug('RegisterPage: Email: ${AppLogger.maskEmail(email)}');
    AppLogger.debug(
        'RegisterPage: Name: ${name.isNotEmpty ? name.substring(0, name.length > 2 ? 2 : name.length) + '***' : '***'}');

    setState(() {
      _isLoading = true;
    });

    try {
      // Use real auth provider for registration
      AppLogger.debug('RegisterPage: Calling auth provider register...');
      final success = await ref.read(authProvider.notifier).register(
            name: name,
            phone: _formatPhoneNumber(_phoneController.text.trim()),
            email: email,
            password: _passwordController.text,
          );
      AppLogger.debug('RegisterPage: Registration result: $success');

      if (mounted) {
        if (success) {
          // Show success message
          SnackBarService.showSnackBar(
            context: context,
            snackBar: const SnackBar(
              content: Text('Hesabınız başarıyla oluşturuldu!'),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to home page after successful registration
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          // Show error message
          final error = ref.read(authErrorProvider);
          AppLogger.warning('RegisterPage: Registration failed', error);
          String userFriendlyError = 'Hesap oluşturulurken bir hata oluştu';

          if (error != null) {
            // Backend hatalarını kullanıcı dostu mesajlara çevir
            if (error.contains('Bu e-posta zaten kayıtlı') ||
                error.contains('Bu kullanıcı zaten kayıtlı')) {
              // Kullanıcı zaten kayıtlı ve giriş yapmış durumda
              // Dialog gösterme, direkt ana sayfaya yönlendir
              AppLogger.info(
                  'RegisterPage: User already exists, redirecting to home');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
              return; // SnackBar gösterme
            } else if (error.contains('email-already-in-use')) {
              // Firebase'den gelen hata (nadir durum)
              userFriendlyError =
                  'Bu e-posta adresi zaten kullanılıyor. Giriş yapmak için tıklayın.';
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('E-posta Zaten Kayıtlı'),
                  content: const Text(
                      'Bu e-posta adresi ile zaten bir hesap bulunmaktadır. Giriş yapmak ister misiniz?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('İptal'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _navigateToSignIn();
                      },
                      child: const Text('Giriş Yap'),
                    ),
                  ],
                ),
              );
              return; // SnackBar gösterme
            } else if (error.contains('weak-password') ||
                error.contains('Şifre çok zayıf')) {
              userFriendlyError = 'Şifre çok zayıf, daha güçlü bir şifre seçin';
            } else if (error.contains('invalid-email') ||
                error.contains('Geçersiz e-posta')) {
              userFriendlyError = 'Geçersiz e-posta adresi';
            } else if (error.contains('Firebase kullanıcısı bulunamadı')) {
              userFriendlyError =
                  'Kayıt işlemi başarısız. Lütfen tekrar deneyin.';
            } else if (error.contains('NO_INTERNET')) {
              userFriendlyError = 'İnternet bağlantısı bulunamadı';
            }
          }

          SnackBarService.showSnackBar(
            context: context,
            snackBar: SnackBar(
              content: Text(userFriendlyError),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: SnackBar(
            content: Text('Kayıt başarısız: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _continueAsGuest() {
    // Misafir kullanıcı olarak ana sayfaya git
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  void _navigateToSignIn() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignInPage(),
      ),
    );
  }
}

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),

                // Welcome Text
                Text(
                  'Hesabınıza Giriş Yapın',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                Text(
                  'E-posta ve şifrenizi girerek giriş yapın',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 48),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-posta',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'E-posta gerekli';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Geçerli bir e-posta adresi girin';
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
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
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

                const SizedBox(height: 32),

                // Sign In Button
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _signIn,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            'Giriş Yap',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 24),

                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'veya',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 24),

                // Guest Mode Button
                SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () => _continueAsGuest(),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Misafir Olarak Devam Et',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Hesabınız yok mu? '),
                    TextButton(
                      onPressed: () => _navigateToRegister(),
                      child: const Text(
                        'Hesap oluşturun',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Use real auth provider
      final success = await ref.read(authProvider.notifier).login(
            _emailController.text.trim(),
            _passwordController.text,
          );

      if (mounted) {
        if (success) {
          // Show success message
          SnackBarService.showSnackBar(
            context: context,
            snackBar: const SnackBar(
              content: Text('Giriş başarılı!'),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to home page
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          // Show error message
          final error = ref.read(authErrorProvider);
          String userFriendlyError = 'Giriş yapılırken bir hata oluştu';

          if (error != null) {
            if (error.contains('UNAUTHORIZED') || error.contains('401')) {
              userFriendlyError = 'E-posta veya şifre hatalı';
            } else if (error.contains('NO_INTERNET')) {
              userFriendlyError = 'İnternet bağlantısı bulunamadı';
            }
          }

          SnackBarService.showSnackBar(
            context: context,
            snackBar: SnackBar(
              content: Text(userFriendlyError),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: SnackBar(
            content: Text('Giriş başarısız: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _continueAsGuest() {
    // Misafir kullanıcı olarak ana sayfaya git
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  void _navigateToRegister() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
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
            const Text(
                'E-posta adresinizi girin, şifre sıfırlama bağlantısı gönderelim.'),
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
                SnackBarService.showSnackBar(
                  context: context,
                  snackBar: const SnackBar(
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
                  SnackBarService.showSnackBar(
                    context: context,
                    snackBar: const SnackBar(
                      content: Text(
                          'Şifre sıfırlama e-postası gönderildi. E-posta kutunuzu kontrol edin.'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  SnackBarService.showSnackBar(
                    context: context,
                    snackBar: SnackBar(
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
}
