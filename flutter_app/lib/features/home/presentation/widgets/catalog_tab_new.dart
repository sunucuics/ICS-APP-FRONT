import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../products/providers/products_provider.dart';
import '../../../products/presentation/pages/category_products_page.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_section.dart';

class CatalogTabNew extends ConsumerStatefulWidget {
  const CatalogTabNew({super.key});

  @override
  ConsumerState<CatalogTabNew> createState() => _CatalogTabNewState();
}

class _CatalogTabNewState extends ConsumerState<CatalogTabNew>
    with TickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late AnimationController _slideAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Category icons mapping
  final Map<String, IconData> categoryIcons = {
    'aydınlatma': Icons.lightbulb,
    'led': Icons.light_mode,
    'tabela': Icons.storefront,
    'ikinci el': Icons.recycling,
    'malzeme': Icons.build,
    'default': Icons.category,
  };

  @override
  void initState() {
    super.initState();
    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideAnimationController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimationController.forward();
    _slideAnimationController.forward();
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    _slideAnimationController.dispose();
    super.dispose();
  }

  IconData _getCategoryIcon(String categoryName) {
    final lowerName = categoryName.toLowerCase();
    for (final key in categoryIcons.keys) {
      if (lowerName.contains(key)) {
        return categoryIcons[key]!;
      }
    }
    return categoryIcons['default']!;
  }

  void _navigateToCategoryProducts(Category category) {
    // Navigate to category products page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryProductsPage(category: category),
      ),
    );
  }

  Widget _buildCategoryCardVertical(Category category, bool isSelected) {
    // Check if this is a fixed category
    final isFixed = category.isFixed;

    // Special handling for Innova Craft Studio card
    final isInnovaCard =
        isFixed && category.name.toLowerCase().contains('innova');

    return GestureDetector(
      onTap: () {
        // Navigate to category products page
        _navigateToCategoryProducts(category);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isInnovaCard ? 20 : 16),
        decoration: BoxDecoration(
          color: isInnovaCard
              ? AppTheme.studioBlack
              : Colors.black, // Changed to black background for other cards
          borderRadius: BorderRadius.circular(isInnovaCard ? 20 : 16),
          border: Border.all(
            color: AppTheme
                .primaryOrange, // Shimmering orange border for all cards
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryOrange
                  .withOpacity(0.5), // Enhanced orange glow
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 2,
            ),
            BoxShadow(
              color: AppTheme.primaryOrange.withOpacity(0.3),
              blurRadius: 40,
              offset: const Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
        ),
        child: isInnovaCard
            ? _buildInnovaCard(category)
            : Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(0.2), // White background for black card
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      children: [
                        Icon(
                          category.name == 'Tümü'
                              ? Icons.grid_view_rounded
                              : _getCategoryIcon(category.name),
                          color:
                              Colors.white, // White icons for black background
                          size: 24,
                        ),
                        if (isFixed)
                          Positioned(
                            right: -2,
                            top: -2,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.push_pin,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                category.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors
                                      .white, // White text for black background
                                ),
                              ),
                            ),
                            if (isFixed)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(
                                      0.2), // White background for black card
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'ÖNE ÇIKAN',
                                  style: TextStyle(
                                    color: Colors
                                        .white, // White text for black background
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (category.description != null &&
                            category.description!.isNotEmpty)
                          const SizedBox(height: 4),
                        if (category.description != null &&
                            category.description!.isNotEmpty)
                          Text(
                            category.description!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors
                                  .white, // White text for black background
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white, // White arrow for black background
                    size: 16,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildInnovaCard(Category category) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Innova Craft',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'S',
                      style: TextStyle(
                        color: AppTheme.studioS,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 't',
                      style: TextStyle(
                        color: AppTheme.studioT,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'u',
                      style: TextStyle(
                        color: AppTheme.studioU,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'd',
                      style: TextStyle(
                        color: AppTheme.studioD,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'i',
                      style: TextStyle(
                        color: AppTheme.studioI,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'o',
                      style: TextStyle(
                        color: AppTheme.studioO,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
          size: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final themed = AppTheme.themedForSection(context, AppSection.store);

    return Theme(
      data: themed,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background, // Gri zemin
        body: SafeArea(
          child: AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Categories horizontal cards
                        _buildCategoriesSection(
                            categoriesAsync, selectedCategory),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(
      AsyncValue<List<Category>> categoriesAsync, String? selectedCategory) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: categoriesAsync.when(
        data: (categories) {
          // Add "Tümü" category and other categories from backend
          // Filter out test categories
          final filteredCategories = categories
              .where((cat) =>
                  !cat.name.toLowerCase().contains('deneme') &&
                  !cat.name.toLowerCase().contains('test'))
              .toList();

          // Fixed categories should appear first
          final fixedCategories =
              filteredCategories.where((cat) => cat.isFixed).toList();
          final regularCategories =
              filteredCategories.where((cat) => !cat.isFixed).toList();

          final allCategories = [
            ...fixedCategories,
            const Category(id: '', name: 'Tümü'),
            ...regularCategories,
          ];

          return Column(
            children: [
              // All Categories - Vertical Cards
              ...allCategories.asMap().entries.map((entry) {
                final index = entry.key;
                final category = entry.value;
                // No category should be selected by default
                final isSelected = selectedCategory == category.name;
                return Container(
                  margin: EdgeInsets.only(
                    top:
                        index == 0 ? 20 : 0, // Add top margin to first category
                    bottom: 12,
                  ),
                  child: _buildCategoryCardVertical(category, isSelected),
                );
              }).toList(),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Kategoriler yüklenemedi: $error'),
        ),
      ),
    );
  }
}
