import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/anonymous_auth_provider.dart';
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

              // App Logo with Glowing Frame
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    'assets/images/ics_logo.jpg',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Welcome Title
              _buildColoredTitle(context),

              const SizedBox(height: 16),

              // Welcome Subtitle
              Text(
                'Ürünlerimizi ve hizmetlerimizi keşfetmek için misafir olarak devam edebilir veya hesap oluşturabilirsiniz.',
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
      // AuthWrapper will automatically show HomePage when anonymous user is authenticated
      // No need to navigate manually
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
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '1. Hizmet Kullanımı',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Innova Craft Studio uygulamasını kullanarak bu koşulları kabul etmiş olursunuz. Uygulama, el yapımı ürünler ve sanat eserleri satışı için tasarlanmıştır.',
              ),
              const SizedBox(height: 16),
              const Text(
                '2. Hesap Sorumluluğu',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Hesap bilgilerinizi güvenli tutmak sizin sorumluluğunuzdadır. Şifrenizi kimseyle paylaşmayın.',
              ),
              const SizedBox(height: 16),
              const Text(
                '3. Ürün Sorumluluğu',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Satın aldığınız ürünlerin kalitesi ve teslimatından sorumluyuz. Ürünler el yapımı olduğu için küçük farklılıklar olabilir.',
              ),
              const SizedBox(height: 16),
              const Text(
                '4. İptal ve İade',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ürünler özel yapım olduğu için sipariş verildikten sonra iptal edilemez. Hasar durumunda iade yapılır.',
              ),
            ],
          ),
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
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '1. Veri Toplama',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Hesap oluşturma, sipariş verme ve iletişim sırasında kişisel bilgilerinizi toplarız. Bu bilgiler: ad, soyad, e-posta, telefon ve adres bilgilerinizdir.',
              ),
              const SizedBox(height: 16),
              const Text(
                '2. Veri Kullanımı',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bilgilerinizi sadece sipariş işleme, teslimat ve müşteri hizmetleri için kullanırız. Pazarlama amaçlı kullanım için ayrı izniniz gerekir.',
              ),
              const SizedBox(height: 16),
              const Text(
                '3. Veri Güvenliği',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Verileriniz SSL şifreleme ile korunur ve güvenli sunucularda saklanır. Kredi kartı bilgileriniz saklanmaz.',
              ),
              const SizedBox(height: 16),
              const Text(
                '4. Veri Paylaşımı',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Kişisel verilerinizi üçüncü taraflarla paylaşmayız. Sadece teslimat için kargo firmalarına gerekli bilgileri veririz.',
              ),
              const SizedBox(height: 16),
              const Text(
                '5. Haklarınız',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Verilerinizi görme, düzeltme, silme ve işlemeyi durdurma hakkınız vardır. Taleplerinizi bize iletebilirsiniz.',
              ),
            ],
          ),
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

  Widget _buildColoredTitle(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
