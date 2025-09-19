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
    // Check if this is a fixed category
    final isFixed = category.isFixed;

    return GestureDetector(
      onTap: () {
        // Navigate to category products page
        _navigateToCategoryProducts(category);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isFixed
              ? AppTheme.primaryOrange.withOpacity(0.1)
              : isSelected
                  ? AppTheme.primaryNavy
                  : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isFixed
                ? AppTheme.primaryOrange
                : isSelected
                    ? AppTheme.primaryOrange
                    : Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: isFixed
                ? 2
                : isSelected
                    ? 2
                    : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isFixed
                  ? AppTheme.primaryOrange.withOpacity(0.3)
                  : isSelected
                      ? AppTheme.primaryOrange.withOpacity(0.2)
                      : Colors.black.withOpacity(0.05),
              blurRadius: isFixed
                  ? 16
                  : isSelected
                      ? 12
                      : 8,
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
                color: isFixed
                    ? AppTheme.primaryOrange
                    : isSelected
                        ? AppTheme.primaryOrange
                        : AppTheme.primaryOrange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Icon(
                    category.name == 'Tümü'
                        ? Icons.grid_view_rounded
                        : _getCategoryIcon(category.name),
                    color: isFixed || isSelected
                        ? Colors.white
                        : AppTheme.primaryOrange,
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
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isFixed
                                ? AppTheme.primaryOrange
                                : isSelected
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                      if (isFixed)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryOrange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'ÖNE ÇIKAN',
                            style: TextStyle(
                              color: Colors.white,
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
                      style: TextStyle(
                        fontSize: 12,
                        color: isFixed
                            ? AppTheme.primaryOrange.withOpacity(0.8)
                            : isSelected
                                ? Colors.white.withOpacity(0.8)
                                : Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: isFixed
                  ? AppTheme.primaryOrange.withOpacity(0.7)
                  : isSelected
                      ? Colors.white.withOpacity(0.7)
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5),
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
        actions: [],
      ),
      body: AnimatedBuilder(
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
                    _buildCategoriesSection(categoriesAsync, selectedCategory),
                  ],
                ),
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
