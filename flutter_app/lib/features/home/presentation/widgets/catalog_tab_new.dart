import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../products/providers/products_provider.dart';
import '../../../products/presentation/pages/category_products_page.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/widgets/theme_toggle_button.dart';
import '../../../../core/theme/app_theme.dart';

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
    return GestureDetector(
      onTap: () {
        // Navigate to category products page
        _navigateToCategoryProducts(category);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryNavy
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryOrange
                : Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppTheme.primaryOrange.withOpacity(0.2)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isSelected ? 12 : 8,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryOrange
                    : AppTheme.primaryOrange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                category.name == 'Tümü'
                    ? Icons.grid_view_rounded
                    : _getCategoryIcon(category.name),
                color: isSelected ? Colors.white : AppTheme.primaryOrange,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                category.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: isSelected
                  ? Colors.white.withOpacity(0.7)
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Mağaza'),
        backgroundColor: AppTheme.primaryOrange,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryOrange,
                AppTheme.primaryOrange.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryNavy,
                  AppTheme.primaryNavy.withOpacity(0.7),
                ],
              ),
            ),
          ),
        ),
        actions: [
          const ThemeToggleButton(),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Arama özelliği yakında eklenecek')),
              );
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  // Categories horizontal cards
                  _buildCategoriesSection(categoriesAsync, selectedCategory),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesSection(
      AsyncValue<List<Category>> categoriesAsync, String? selectedCategory) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: categoriesAsync.when(
        data: (categories) {
          // Add "Tümü" category and other categories (excluding Innova Craft Studio from list)
          final allCategories = [
            const Category(id: '', name: 'Tümü'),
            ...categories,
          ];

          return Column(
            children: [
              // Innova Craft Studio - Special Category with top margin
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: _buildSpecialCategoryCard(const Category(
                    id: 'innova_craft_studio', name: 'Innova Craft Studio')),
              ),
              const SizedBox(height: 20),
              // All Categories - Vertical Cards
              ...allCategories.map((category) {
                // No category should be selected by default
                final isSelected = selectedCategory == category.name;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
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

  Widget _buildSpecialCategoryCard(Category category) {
    return GestureDetector(
      onTap: () {
        // Navigate to Innova Craft Studio products page
        _navigateToCategoryProducts(category);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.primaryOrange,
              AppTheme.primaryOrange.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryOrange.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.storefront_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Innova Craft Studio',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Özel tasarım ürünler',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white.withOpacity(0.8),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
