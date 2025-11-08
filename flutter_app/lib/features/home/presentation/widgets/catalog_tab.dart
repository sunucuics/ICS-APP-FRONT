import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../products/providers/products_provider.dart';
import '../../../products/presentation/pages/product_detail_page.dart';
import '../../../cart/providers/cart_provider.dart';
import '../../../auth/providers/anonymous_auth_provider.dart' as anonymous;
import '../../../auth/providers/auth_provider.dart';
import '../../../auth/presentation/pages/guest_upgrade_page.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_section.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/services/snackbar_service.dart';

class CatalogTab extends ConsumerStatefulWidget {
  const CatalogTab({super.key});

  @override
  ConsumerState<CatalogTab> createState() => _CatalogTabState();
}

class _CatalogTabState extends ConsumerState<CatalogTab> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearchVisible = false;

  // For debouncing search
  Timer? _searchTimer;

  // Category icons mapping
  final Map<String, IconData> categoryIcons = {
    'elektronik': Icons.phone_android,
    'giyim': Icons.checkroom,
    'ev': Icons.home,
    'spor': Icons.sports_soccer,
    'kitap': Icons.book,
    'oyuncak': Icons.toys,
    'default': Icons.category,
  };

  @override
  void dispose() {
    _searchController.dispose();
    _searchTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _searchQuery = value.toLowerCase();
        });
      }
    });
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

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final productsAsync = ref.watch(productsProvider(selectedCategory));
    final themed = AppTheme.themedForSection(context, AppSection.store);

    if (ApiEndpoints.isDebug) {
      print('🏗️ CatalogTab build - selectedCategory: $selectedCategory');
    }

    return Theme(
      data: themed,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background, // Gri zemin
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: _isSearchVisible
              ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Ürün ara...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: _onSearchChanged,
                )
              : Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.store,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Mağaza',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  SnackBarService.showSnackBar(context: context, snackBar: 
                    const SnackBar(
                        content: Text('Filtreleme özelliği yakında eklenecek')),
                  );
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // Categories horizontal list
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: categoriesAsync.when(
                data: (categories) {
                  // Add "Tümü" category at the beginning
                  // Use all categories (removed test category filtering)
                  final filteredCategories = categories;

                  // Fixed categories should appear first
                  final fixedCategories =
                      filteredCategories.where((cat) => cat.isFixed).toList();
                  final regularCategories =
                      filteredCategories.where((cat) => !cat.isFixed).toList();

                  final allCategories = [
                    const Category(id: '', name: 'Tümü'),
                    ...fixedCategories,
                    ...regularCategories,
                  ];

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: allCategories.length,
                    itemBuilder: (context, index) {
                      final category = allCategories[index];
                      final isFixed = category.isFixed;

                      // Special handling for Innova Craft Studio card
                      if (isFixed &&
                          category.name.toLowerCase().contains('innova')) {
                        return GestureDetector(
                          onTap: () {
                            final newCategory =
                                category.name == 'Tümü' ? null : category.name;
                            if (ApiEndpoints.isDebug) {
                              print(
                                  '🎯 Innova Studio tapped: ${category.name} -> newCategory: $newCategory');
                              print(
                                  '🎯 Current selectedCategory: ${ref.read(selectedCategoryProvider)}');
                            }
                            ref.read(selectedCategoryProvider.notifier).state =
                                newCategory;
                            if (ApiEndpoints.isDebug) {
                              print(
                                  '🎯 After setting, selectedCategory: ${ref.read(selectedCategoryProvider)}');
                            }
                          },
                          child: Container(
                            width: 200, // Larger width for featured card
                            height: 80,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: AppTheme.studioBlack,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppTheme.studioBlack.withOpacity(0.3),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.studioBlack.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.business,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Innova Craft ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'S',
                                            style: TextStyle(
                                              color: AppTheme.studioS,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 't',
                                            style: TextStyle(
                                              color: AppTheme.studioT,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'u',
                                            style: TextStyle(
                                              color: AppTheme.studioU,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'd',
                                            style: TextStyle(
                                              color: AppTheme.studioD,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'i',
                                            style: TextStyle(
                                              color: AppTheme.studioI,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'o',
                                            style: TextStyle(
                                              color: AppTheme.studioO,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'ÖNE ÇIKAN',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                      return GestureDetector(
                        onTap: () {
                          final newCategory =
                              category.name == 'Tümü' ? null : category.name;
                          if (ApiEndpoints.isDebug) {
                            print(
                                '🎯 Category tapped: ${category.name} -> newCategory: $newCategory');
                            print(
                                '🎯 Current selectedCategory: ${ref.read(selectedCategoryProvider)}');
                          }
                          ref.read(selectedCategoryProvider.notifier).state =
                              newCategory;
                          if (ApiEndpoints.isDebug) {
                            print(
                                '🎯 After setting, selectedCategory: ${ref.read(selectedCategoryProvider)}');
                          }
                        },
                        child: Container(
                          width: 85,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: AppTheme.categoryCardTransparentOrange,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppTheme.primaryOrange,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryOrange.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Show category image if available, otherwise show icon
                                  if (category.name == 'Tümü')
                                    Icon(
                                      Icons.apps,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                      size: 20,
                                    )
                                  else if (category.coverImage != null &&
                                      category.coverImage!.isNotEmpty)
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.black.withOpacity(0.1)
                                            : Colors.white.withOpacity(0.2),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl: category.coverImage!,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Icon(
                                            _getCategoryIcon(category.name),
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            size: 20,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                            _getCategoryIcon(category.name),
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    Icon(
                                      _getCategoryIcon(category.name),
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                      size: 20,
                                    ),
                                  const SizedBox(height: 4),
                                  Text(
                                    category.name,
                                    style: TextStyle(
                                      fontSize: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? 13
                                          : 11,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              if (isFixed)
                                Positioned(
                                  right: 4,
                                  top: 4,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.push_pin,
                                      color: Colors.white,
                                      size: 8,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text('Kategoriler yüklenemedi: $error'),
                ),
              ),
            ),

            // Products grid
            Expanded(
              child: productsAsync.when(
                data: (products) {
                  if (products.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_bag_outlined,
                              size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'Bu kategoride henüz ürün bulunmuyor',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }

                  // Filter products based on search query
                  final filteredProducts = _searchQuery.isEmpty
                      ? products
                      : products.where((product) {
                          return product.title
                                  .toLowerCase()
                                  .contains(_searchQuery) ||
                              product.description
                                      ?.toLowerCase()
                                      .contains(_searchQuery) ==
                                  true ||
                              product.categoryName
                                      ?.toLowerCase()
                                      .contains(_searchQuery) ==
                                  true;
                        }).toList();

                  if (filteredProducts.isEmpty && _searchQuery.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off,
                              size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'Aradığınız ürün bulunamadı',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '"$_searchQuery" için sonuç bulunamadı',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return _ProductCard(product: product);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        'Ürünler yüklenemedi:\n$error',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            ref.refresh(productsProvider(selectedCategory)),
                        child: const Text('Tekrar Dene'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends ConsumerWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayPrice = product.finalPrice ?? product.price;
    final hasDiscount =
        product.finalPrice != null && product.finalPrice! < product.price;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppTheme.primaryOrange,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryOrange.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: product.images.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: product.images.first,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.white.withOpacity(0.1),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.white.withOpacity(0.1),
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.image_not_supported,
                            size: 48,
                            color: Colors.white,
                          ),
                  ),
                ),
                const SizedBox(height: 8),

                // Product Title
                Expanded(
                  flex: 1,
                  child: Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Price and Stock
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        Text(
                          '₺${displayPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        if (hasDiscount) ...[
                          const SizedBox(width: 8),
                          Text(
                            '₺${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      children: [
                        Icon(
                          product.stock > 0 ? Icons.check_circle : Icons.cancel,
                          size: 12,
                          color: product.stock > 0
                              ? AppTheme.successGreen
                              : AppTheme.errorRed,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          product.stock > 0 ? 'Stokta var' : 'Stokta yok',
                          style: TextStyle(
                            fontSize: 11,
                            color: product.stock > 0
                                ? Colors.white70
                                : Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Add to Cart Button
                    SizedBox(
                      width: double.infinity,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final isLoading = ref.watch(cartLoadingProvider);
                          return ElevatedButton.icon(
                            onPressed: (product.stock > 0 &&
                                    !product.isUpcoming &&
                                    !isLoading)
                                ? () => _addToCart(context, ref, product)
                                : null,
                            icon: isLoading
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : const Icon(Icons.shopping_cart_outlined,
                                    size: 16),
                            label: Text(
                              isLoading
                                  ? 'Ekleniyor...'
                                  : product.isUpcoming
                                      ? 'Yakında Satışta'
                                      : product.stock > 0
                                          ? 'Sepete Ekle'
                                          : 'Stokta Yok',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.primaryOrange,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppTheme.primaryOrange,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
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

  void _addToCart(BuildContext context, WidgetRef ref, Product product) async {
    // Check if user is authenticated (either registered or anonymous)
    final authState = ref.read(authProvider);
    final isAnonymous = ref.read(anonymous.isAnonymousProvider);

    // If registered user is authenticated, allow adding to cart
    // If only anonymous user is authenticated, show upgrade dialog
    final isActuallyAnonymous = !authState.isAuthenticated && isAnonymous;

    if (isActuallyAnonymous) {
      _showGuestUpgradeDialog(context);
      return;
    }

    try {
      await ref.read(cartProvider.notifier).addToCart(
            product.id,
            quantity: 1,
            productTitle: product.title,
            productPrice: product.price,
          );

      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text('${product.title} sepete eklendi'),
            duration: const Duration(seconds: 2),
            // Remove action button, just show notification
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text('Hata: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showGuestUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hesap Gerekli'),
          content: const Text(
            'Sepete ürün eklemek için hesap oluşturmanız gerekiyor. '
            'Hesap oluşturmak ister misiniz?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const GuestUpgradePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Hesap Oluştur'),
            ),
          ],
        );
      },
    );
  }
}
