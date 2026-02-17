import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/product_model.dart';
import '../../../core/models/paginated_list_state.dart';
import '../data/products_repository.dart';

// Products Repository Provider
final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  return ProductsRepository();
});

// ============================================================================
// NEW: Cursor-based paginated products notifier (infinite scroll)
// ============================================================================

class ProductsNotifier extends StateNotifier<PaginatedListState<Product>> {
  final ProductsRepository _repository;
  String? _categoryName;
  static const int _pageSize = 20;

  ProductsNotifier(this._repository) : super(const PaginatedListState());

  String? get categoryName => _categoryName;

  /// İlk sayfa yükle (yeni kategori veya refresh).
  Future<void> loadInitial({String? categoryName}) async {
    _categoryName = categoryName;
    state = PaginatedListState.loading();

    try {
      final response = await _repository.getProducts(
        categoryName: _categoryName,
        limit: _pageSize,
      );

      state = PaginatedListState(
        items: response.items,
        hasMore: response.hasMore,
        nextCursor: response.nextCursor,
        isLoading: false,
      );
    } catch (e) {
      state = PaginatedListState.error(e.toString());
    }
  }

  /// Sonraki sayfa yükle (infinite scroll).
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final response = await _repository.getProducts(
        categoryName: _categoryName,
        limit: _pageSize,
        startAfter: state.nextCursor,
      );

      state = state.copyWith(
        items: [...state.items, ...response.items],
        hasMore: response.hasMore,
        nextCursor: response.nextCursor,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  /// Kategori değiştir → ilk sayfadan yeniden yükle.
  void changeCategory(String? name) {
    final finalName = name == 'Tümü' ? null : name;
    if (finalName == _categoryName && state.hasData) return;
    loadInitial(categoryName: finalName);
  }

  /// Pull-to-refresh.
  Future<void> refresh() => loadInitial(categoryName: _categoryName);
}

/// Paginated products notifier provider.
/// autoDispose kullanılMIyor — tab geçişlerinde state korunmalı.
final productsNotifierProvider =
    StateNotifierProvider<ProductsNotifier, PaginatedListState<Product>>((ref) {
  final repository = ref.read(productsRepositoryProvider);
  return ProductsNotifier(repository);
});

// ============================================================================
// LEGACY: Eski provider'lar — mevcut UI'lar kademeli olarak geçirilecek.
// Backend artık CursorPage döndüğü için items extract ediliyor.
// ============================================================================

/// Eski productsProvider — FutureProvider.autoDispose.family
/// category_products_page.dart ve home_page.dart tarafından kullanılıyor.
final productsProvider = FutureProvider.autoDispose
    .family<List<Product>, String?>((ref, categoryName) async {
  final repository = ref.read(productsRepositoryProvider);
  final finalCategoryName = categoryName == 'Tümü' ? null : categoryName;
  // İlk sayfa — limit yüksek tutarak eski davranışı korur
  final response = await repository.getProducts(
    categoryName: finalCategoryName,
    limit: 100,
  );
  return response.items;
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
  return null;
});

// Filtered Products Provider — eski UI uyumluluğu için korunuyor
final filteredProductsProvider =
    FutureProvider.autoDispose<List<Product>>((ref) {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  return ref.watch(productsProvider(selectedCategory)).when(
    data: (products) => products,
    loading: () => <Product>[],
    error: (error, stack) => <Product>[],
  );
});

// Product search — eski UI uyumluluğu için korunuyor
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
