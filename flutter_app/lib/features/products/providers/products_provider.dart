import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/product_model.dart';
import '../../../core/network/api_endpoints.dart';
import '../data/products_repository.dart';

// Products Repository Provider
final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  return ProductsRepository();
});

// Products Provider - FutureProvider for automatic state management
final productsProvider = FutureProvider.autoDispose
    .family<List<Product>, String?>((ref, categoryName) {
  final repository = ref.read(productsRepositoryProvider);

  // Force "Tümü" to be treated as null
  final finalCategoryName = categoryName == 'Tümü' ? null : categoryName;

  if (ApiEndpoints.isDebug) {
    print(
        '🛍️ productsProvider called with categoryName: $categoryName -> finalCategoryName: $finalCategoryName');
  }

  return repository.getProducts(categoryName: finalCategoryName);
});

// Single Product Provider
final productProvider =
    FutureProvider.autoDispose.family<Product, String>((ref, productId) {
  final repository = ref.read(productsRepositoryProvider);
  return repository.getProduct(productId);
});

// Categories Provider
final categoriesProvider = FutureProvider.autoDispose<List<Category>>((ref) {
  final repository = ref.read(productsRepositoryProvider);
  return repository.getCategories();
});

// Single Category Provider
final categoryProvider =
    FutureProvider.autoDispose.family<Category, String>((ref, categoryId) {
  final repository = ref.read(productsRepositoryProvider);
  return repository.getCategory(categoryId);
});

// Selected Category State Provider (for filtering)
final selectedCategoryProvider = StateProvider<String?>((ref) {
  if (ApiEndpoints.isDebug) {
    print('🏗️ selectedCategoryProvider initialized with null');
  }
  return null;
});

// Filtered Products Provider - combines products with selected category
final filteredProductsProvider =
    FutureProvider.autoDispose<List<Product>>((ref) {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  if (ApiEndpoints.isDebug) {
    print('🛍️ Fetching products for category: ${selectedCategory ?? "All"}');
  }
  return ref.watch(productsProvider(selectedCategory)).when(
    data: (products) {
      if (ApiEndpoints.isDebug) {
        print('✅ Successfully loaded ${products.length} products');
      }
      return products;
    },
    loading: () {
      if (ApiEndpoints.isDebug) {
        print('⏳ Loading products...');
      }
      return <Product>[];
    },
    error: (error, stack) {
      if (ApiEndpoints.isDebug) {
        print('❌ Error loading products: $error');
      }
      // Return empty list instead of throwing to prevent app crash
      return <Product>[];
    },
  );
});

// Convenience provider for product search/filter
final productSearchProvider = StateProvider<String>((ref) => '');

final searchedProductsProvider = Provider.autoDispose<List<Product>>((ref) {
  final allProducts = ref.watch(filteredProductsProvider);
  final searchQuery = ref.watch(productSearchProvider);

  return allProducts.when(
    data: (products) {
      if (searchQuery.isEmpty) return products;

      return products
          .where((product) =>
              product.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              (product.description
                      ?.toLowerCase()
                      .contains(searchQuery.toLowerCase()) ??
                  false))
          .toList();
    },
    loading: () => <Product>[],
    error: (error, stack) => <Product>[],
  );
});
