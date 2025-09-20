import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/anonymous_auth_provider.dart';
import '../../../home/presentation/pages/home_page.dart';
import 'register_page.dart';
import 'login_page.dart';

class GuestWelcomePage extends ConsumerWidget {
  const GuestWelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(anonymousAuthProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // App Logo
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/ics_logo.jpg',
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Welcome Title
              Text(
                'ICS App\'e Hoş Geldiniz',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Welcome Subtitle
              Text(
                'Ürünlerimizi keşfetmek için misafir olarak devam edebilir veya hesap oluşturabilirsiniz.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Guest Mode Benefits
              _buildBenefitsList(context),

              const SizedBox(height: 48),

              // Action Buttons
              _buildActionButtons(context, ref, authNotifier),

              const SizedBox(height: 16),

              // Terms and Privacy
              _buildTermsAndPrivacy(context),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitsList(BuildContext context) {
    final benefits = [
      {
        'icon': Icons.shopping_cart_outlined,
        'title': 'Alışveriş Yapın',
        'description': 'Ürünleri inceleyin ve sepete ekleyin',
      },
      {
        'icon': Icons.favorite_outline,
        'title': 'Favorilerinizi Kaydedin',
        'description': 'Beğendiğiniz ürünleri favorilere ekleyin',
      },
      {
        'icon': Icons.local_shipping_outlined,
        'title': 'Hızlı Teslimat',
        'description': 'Siparişlerinizi hızlıca teslim alın',
      },
    ];

    return Column(
      children: benefits
          .map((benefit) => _buildBenefitItem(
                context,
                benefit['icon'] as IconData,
                benefit['title'] as String,
                benefit['description'] as String,
              ))
          .toList(),
    );
  }

  Widget _buildBenefitItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    WidgetRef ref,
    AnonymousAuthNotifier authNotifier,
  ) {
    return Column(
      children: [
        // Login Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _navigateToSignIn(context),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Giriş Yap',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Continue as Guest Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => _continueAsGuest(context, authNotifier),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
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

        const SizedBox(height: 16),

        // Create Account Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => _navigateToRegister(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Hesap Oluştur',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsAndPrivacy(BuildContext context) {
    return Column(
      children: [
        Text(
          'Devam ederek Kullanım Koşulları ve Gizlilik Politikası\'nı kabul etmiş olursunuz.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[500],
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => _showTerms(context),
              child: const Text(
                'Kullanım Koşulları',
                style: TextStyle(fontSize: 12),
              ),
            ),
            Text(
              ' • ',
              style: TextStyle(color: Colors.grey[500]),
            ),
            TextButton(
              onPressed: () => _showPrivacy(context),
              child: const Text(
                'Gizlilik Politikası',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _continueAsGuest(
    BuildContext context,
    AnonymousAuthNotifier authNotifier,
  ) async {
    try {
      await authNotifier.signInAnonymously();
      if (context.mounted) {
        // Navigate directly to HomePage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Misafir girişi başarısız: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }

  void _navigateToSignIn(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  void _showTerms(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kullanım Koşulları'),
        content: const Text(
          'Bu uygulamayı kullanarak kullanım koşullarımızı kabul etmiş olursunuz. '
          'Detaylı bilgi için lütfen web sitemizi ziyaret edin.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showPrivacy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Gizlilik Politikası'),
        content: const Text(
          'Gizliliğiniz bizim için önemlidir. Kişisel verileriniz güvenli bir şekilde '
          'işlenir ve üçüncü taraflarla paylaşılmaz.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }
}
