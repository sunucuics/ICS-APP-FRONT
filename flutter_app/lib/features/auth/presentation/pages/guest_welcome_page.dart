import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/anonymous_auth_provider.dart';
import 'register_page.dart';
import 'login_page.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../../core/services/snackbar_service.dart';

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
      // Navigate to HomePage after successful anonymous sign in
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
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
              // Header
              const Text(
                'INNOVA CRAFT STUDIO (ICS)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              const Text(
                'KULLANIM KOŞULLARI',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // 1. Taraflar ve Kabul
              const Text(
                '1. Taraflar ve Kabul',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Innova Craft Studio (ICS) tarafından sunulan mobil uygulama, web sitesi ve tüm dijital platformları kullanan herkes işbu Kullanım Koşulları\'nı okumuş, anlamış ve kabul etmiş sayılır.',
              ),
              const SizedBox(height: 16),
              // 2. Platformun Amacı ve Kapsamı
              const Text(
                '2. Platformun Amacı ve Kapsamı',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'ICS; aydınlatma sistemleri, ışıklı tabelalar, akıllı apartman giriş sistemleri, dekoratif ve teknolojik ürünler, hırdavat ürünleri ile bunlara bağlı hizmetlerin üretimi, satışı ve e-ticaret faaliyetlerini yürüten çok yönlü bir dijital platformdur.',
              ),
              const SizedBox(height: 16),
              // 3. Ürün Satışı ve E-Ticaret
              const Text(
                '3. Ürün Satışı ve E-Ticaret',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'ICS;\n- Kendi üretimi olan ürünleri,\n- Konseptine uygun üçüncü taraf tedarikçilerden temin edilen ürünleri,\n- Hırdavat, teknik ekipman ve aksesuarları\ne-ticaret kapsamında satışa sunabilir.\n\nÜrünlerin seçimi, stok durumu, fiyatlandırması ve satıştan kaldırılması tamamen ICS yetkisindedir.',
              ),
              const SizedBox(height: 16),
              // 4. Özel Üretim ve Ürün Bilgileri
              const Text(
                '4. Özel Üretim ve Ürün Bilgileri',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bazı ürünler siparişe özel veya el işçiliğiyle üretilebilir. Bu ürünlerde ölçü, renk ve tasarım farklılıkları oluşabilir ve bu durum ayıp olarak kabul edilmez.',
              ),
              const SizedBox(height: 16),
              // 5. Sipariş Süreci
              const Text(
                '5. Sipariş Süreci',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Uygulama veya platform üzerinden verilen siparişler elektronik ortamda onaylanır. Sipariş onayıyla birlikte satış sözleşmesi kurulmuş sayılır.',
              ),
              const SizedBox(height: 16),
              // 6. Ödeme
              const Text(
                '6. Ödeme',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ödemeler güvenli ödeme altyapıları aracılığıyla yapılır. Ödeme tamamlanmadan sipariş işleme alınmaz.',
              ),
              const SizedBox(height: 16),
              // 7. Teslimat
              const Text(
                '7. Teslimat',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Teslimat süreleri ürün türüne, üretim süresine ve kargo koşullarına göre değişiklik gösterebilir. Kargo kaynaklı gecikmelerden ICS sorumlu tutulamaz.',
              ),
              const SizedBox(height: 16),
              // 8. İptal, İade ve Cayma Hakkı
              const Text(
                '8. İptal, İade ve Cayma Hakkı',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Standart ürünlerde yürürlükteki tüketici mevzuatı uygulanır. Siparişe özel üretilen veya kişiselleştirilmiş ürünlerde cayma hakkı kullanılamaz.',
              ),
              const SizedBox(height: 16),
              // 9. Hizmetler
              const Text(
                '9. Hizmetler',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'ICS; montaj, kurulum, danışmanlık ve teknik destek hizmetleri sunabilir. Hizmetlerin kapsamı, süresi ve bedeli platformda belirtilir.',
              ),
              const SizedBox(height: 16),
              // 10. Kullanıcı Yükümlülükleri
              const Text(
                '10. Kullanıcı Yükümlülükleri',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Kullanıcılar platformu hukuka, ahlaka ve amacına uygun şekilde kullanmakla yükümlüdür.',
              ),
              const SizedBox(height: 16),
              // 11. Sorumluluğun Sınırlandırılması
              const Text(
                '11. Sorumluluğun Sınırlandırılması',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ürünlerin hatalı veya amacına aykırı kullanımından doğabilecek zararlardan ICS sorumlu değildir. Hırdavat ve teknik ürünlerin kullanım sorumluluğu kullanıcıya aittir.',
              ),
              const SizedBox(height: 16),
              // 12. Fikri Mülkiyet Hakları
              const Text(
                '12. Fikri Mülkiyet Hakları',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Platformda yer alan tüm içerik, tasarım, metin ve görseller ICS\'ye aittir. İzinsiz kullanılamaz.',
              ),
              const SizedBox(height: 16),
              // 13. Değişiklikler
              const Text(
                '13. Değişiklikler',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'ICS, işbu kullanım koşullarını önceden bildirimde bulunmaksızın değiştirme hakkını saklı tutar.',
              ),
              const SizedBox(height: 16),
              // 14. Yürürlük
              const Text(
                '14. Yürürlük',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'İşbu Kullanım Koşulları platformda yayınlandığı tarihten itibaren yürürlüğe girer.',
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
