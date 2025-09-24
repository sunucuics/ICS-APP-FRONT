import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../../features/auth/presentation/pages/guest_welcome_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: "Özel Tasarım\nLED Işıklar",
      description:
          "Kişiye özel LED aydınlatma çözümleri,\nmodern tasarım ve kaliteli işçilik.",
      imagePath: "assets/images/onboarding_1.jpg", // AI generated image
      primaryColor: AppTheme.primaryOrange,
      secondaryColor: AppTheme.lightOrange,
    ),
    OnboardingPage(
      title: "Lazer Baskı ve\nÖzel Tasarım",
      description:
          "Hassas lazer kesim ve gravür işleri,\nher türlü malzemede özel tasarım.",
      imagePath: "assets/images/onboarding_2.jpg", // AI generated image
      primaryColor: AppTheme.primaryNavy,
      secondaryColor: AppTheme.lightNavy,
    ),
    OnboardingPage(
      title: "E-Ticaret ile\nKolay Alışveriş",
      description:
          "Online ürün satışı, güvenli ödeme\nve hızlı teslimat ile ustanın ürünlerini keşfedin.",
      imagePath: "assets/images/onboarding_3.jpg", // AI generated image
      primaryColor: AppTheme.whatsappGreen,
      secondaryColor: AppTheme.whatsappGreenLight,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_first_time', false);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const GuestWelcomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    const Color(0xFF0F1115),
                    const Color(0xFF171A20),
                  ]
                : [
                    const Color(0xFFF6F7F9),
                    Colors.white,
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with Skip button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.primaryOrange,
                            AppTheme.secondaryOrange,
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.brush,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),

                    // Skip button
                    TextButton(
                      onPressed: _skipOnboarding,
                      child: Text(
                        'Atla',
                        style: TextStyle(
                          color: isDark
                              ? const Color(0xFFB7C1CE)
                              : const Color(0xFF5F6B7A),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return OnboardingPageWidget(
                      page: _pages[index],
                      isDark: isDark,
                    );
                  },
                ),
              ),

              // Bottom section with indicators and buttons
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Page indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? _pages[_currentPage].primaryColor
                                : (isDark
                                    ? const Color(0xFF2C2C2E)
                                    : const Color(0xFFE8EAED)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Navigation buttons
                    Row(
                      children: [
                        // Previous button
                        if (_currentPage > 0)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _previousPage,
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                side: BorderSide(
                                  color: _pages[_currentPage].primaryColor,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                'Geri',
                                style: TextStyle(
                                  color: _pages[_currentPage].primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                        if (_currentPage > 0) const SizedBox(width: 16),

                        // Next/Get Started button
                        Expanded(
                          flex: _currentPage > 0 ? 1 : 2,
                          child: ElevatedButton(
                            onPressed: _nextPage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _pages[_currentPage].primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 3,
                              shadowColor: _pages[_currentPage]
                                  .primaryColor
                                  .withValues(alpha: 0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              _currentPage == _pages.length - 1
                                  ? 'Başlayalım'
                                  : 'İleri',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage page;
  final bool isDark;

  const OnboardingPageWidget({
    super.key,
    required this.page,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image placeholder with gradient background
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  page.primaryColor.withValues(alpha: 0.1),
                  page.secondaryColor.withValues(alpha: 0.05),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: page.primaryColor.withValues(alpha: 0.1),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                // AI generated image
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      page.imagePath,
                      width: 280,
                      height: 280,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback to icon if image not found
                        return Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                page.primaryColor.withValues(alpha: 0.2),
                                page.secondaryColor.withValues(alpha: 0.1),
                              ],
                            ),
                          ),
                          child: Icon(
                            _getPageIcon(),
                            size: 80,
                            color: page.primaryColor.withValues(alpha: 0.6),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Decorative elements
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: page.primaryColor.withValues(alpha: 0.1),
                    ),
                    child: Icon(
                      Icons.star,
                      color: page.primaryColor.withValues(alpha: 0.4),
                      size: 24,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: page.secondaryColor.withValues(alpha: 0.1),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: page.secondaryColor.withValues(alpha: 0.4),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Title
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF111111),
              height: 1.2,
            ),
          ),

          const SizedBox(height: 16),

          // Description
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isDark ? const Color(0xFFB7C1CE) : const Color(0xFF5F6B7A),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getPageIcon() {
    // Find the index of current page
    final onboardingPages = [
      OnboardingPage(
        title: "El Yapımı Ürünlerle\nTanışın",
        description:
            "Özenle seçilmiş, kaliteli malzemelerle hazırlanmış\nbenzersiz el yapımı ürünleri keşfedin.",
        imagePath: "assets/images/onboarding_1.jpg",
        primaryColor: AppTheme.primaryOrange,
        secondaryColor: AppTheme.lightOrange,
      ),
      OnboardingPage(
        title: "Özel Sanat Eserleri\nSizin İçin",
        description:
            "Usta ellerden çıkan, her biri birer sanat eseri\nolan ürünleri koleksiyonunuza ekleyin.",
        imagePath: "assets/images/onboarding_2.jpg",
        primaryColor: AppTheme.primaryNavy,
        secondaryColor: AppTheme.lightNavy,
      ),
      OnboardingPage(
        title: "Güvenli ve Kolay\nAlışveriş",
        description:
            "Güvenli ödeme seçenekleri ve hızlı kargo ile\nsiparişlerinizi güvenle alın.",
        imagePath: "assets/images/onboarding_3.jpg",
        primaryColor: AppTheme.whatsappGreen,
        secondaryColor: AppTheme.whatsappGreenLight,
      ),
    ];

    final index = onboardingPages.indexWhere((p) => p.title == page.title);

    switch (index) {
      case 0:
        return Icons.lightbulb;
      case 1:
        return Icons.precision_manufacturing;
      case 2:
        return Icons.shopping_cart;
      default:
        return Icons.brush;
    }
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String imagePath;
  final Color primaryColor;
  final Color secondaryColor;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.primaryColor,
    required this.secondaryColor,
  });
}
