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

    return Scaffold(
      appBar: AppBar(
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
                      color: AppTheme.primaryOrange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.store,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('Mağaza'),
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
              icon: Icon(_isSearchVisible ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  if (_isSearchVisible) {
                    _isSearchVisible = false;
                    _searchController.clear();
                    _searchQuery = '';
                  } else {
                    _isSearchVisible = true;
                  }
                });
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
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
                final allCategories = [
                  const Category(id: '', name: 'Tümü'),
                  ...categories,
                ];

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: allCategories.length,
                  itemBuilder: (context, index) {
                    final category = allCategories[index];
                    final isSelected =
                        (selectedCategory == null && index == 0) ||
                            (selectedCategory == category.name);

                    return GestureDetector(
                      onTap: () {
                        final newCategory = index == 0 ? null : category.name;
                        ref.read(selectedCategoryProvider.notifier).state =
                            newCategory;
                      },
                      child: Container(
                        width: 85,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.primaryOrange
                              : Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? AppTheme.primaryOrange
                                : Theme.of(context).colorScheme.outline,
                            width: 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color:
                                        AppTheme.primaryOrange.withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              index == 0
                                  ? Icons.apps
                                  : _getCategoryIcon(category.name),
                              color: isSelected ? Colors.white : Colors.white70,
                              size: 20,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              category.name,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
        color: Theme.of(context).colorScheme.surfaceVariant,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
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
                      color: Theme.of(context).colorScheme.surfaceVariant,
                    ),
                    child: product.images.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: product.images.first,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: AppTheme.primaryOrange,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: AppTheme.primaryOrange,
                                ),
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.image_not_supported,
                            size: 48,
                            color: AppTheme.primaryOrange,
                          ),
                  ),
                ),
                const SizedBox(height: 8),

                // Product Title
                Expanded(
                  flex: 1,
                  child: Text(
                    product.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
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
                            color: AppTheme.primaryOrange,
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
                                ? AppTheme.successGreen
                                : AppTheme.errorRed,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Add to Cart Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: product.stock > 0
                            ? () => _addToCart(context, ref, product)
                            : null,
                        icon:
                            const Icon(Icons.shopping_cart_outlined, size: 16),
                        label: Text(
                          product.stock > 0 ? 'Sepete Ekle' : 'Stokta Yok',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
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
      await ref.read(cartProvider.notifier).addToCart(product.id, quantity: 1);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.title} sepete eklendi'),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Sepeti Gör',
              onPressed: () {
                // Navigate to cart tab - bu parent widget'ta handle edilmeli
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sepet sekmesine geçin')),
                );
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
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
