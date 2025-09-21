import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/admin_products_provider.dart';
import '../../providers/admin_categories_provider.dart';
import '../widgets/admin_navigation.dart';
import '../widgets/admin_form_dialog.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/product_model.dart';

class AdminProductsPage extends ConsumerWidget {
  const AdminProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(adminProductsNotifierProvider);
    final categoriesAsync = ref.watch(adminCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Yönetimi'),
        backgroundColor: AppTheme.primaryNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(adminProductsNotifierProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: productsAsync.when(
        data: (products) =>
            _buildProductsList(context, ref, products, categoriesAsync),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            _buildErrorWidget(context, ref, error.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProductDialog(context, ref, categoriesAsync),
        backgroundColor: AppTheme.primaryOrange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const AdminNavigation(),
    );
  }

  Widget _buildProductsList(BuildContext context, WidgetRef ref,
      List<Product> products, AsyncValue<List<Category>> categoriesAsync) {
    if (products.isEmpty) {
      return _buildEmptyState(context, ref);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(adminProductsNotifierProvider.notifier).refresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _buildProductCard(context, ref, product, categoriesAsync);
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, WidgetRef ref, Product product,
      AsyncValue<List<Category>> categoriesAsync) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppTheme.primaryNavy.withOpacity(0.1),
              ),
              child: product.images.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.images.first,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.inventory,
                            color: AppTheme.primaryNavy,
                            size: 30,
                          );
                        },
                      ),
                    )
                  : Icon(
                      Icons.inventory,
                      color: AppTheme.primaryNavy,
                      size: 30,
                    ),
            ),
            const SizedBox(width: 16),

            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (product.description != null &&
                      product.description!.isNotEmpty)
                    Text(
                      product.description!,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 8),

                  // Price and Stock
                  Row(
                    children: [
                      Text(
                        '₺${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryOrange,
                        ),
                      ),
                      if (product.finalPrice != null &&
                          product.finalPrice != product.price) ...[
                        const SizedBox(width: 8),
                        Text(
                          '₺${product.finalPrice!.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Stok: ${product.stock}',
                        style: TextStyle(
                          color: product.stock > 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: product.id));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Ürün ID\'si kopyalandı'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Text(
                            'ID: ${product.id}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 11,
                              fontFamily: 'monospace',
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildStatusChip(
                        !product.isUpcoming ? 'Aktif' : 'Pasif',
                        !product.isUpcoming ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      if (product.isUpcoming)
                        _buildStatusChip('Yakında', Colors.orange),
                      if (product.finalPrice != null &&
                          product.finalPrice != product.price)
                        _buildStatusChip('İndirimli', Colors.purple),
                    ],
                  ),
                ],
              ),
            ),

            // Actions
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    _showEditProductDialog(
                        context, ref, product, categoriesAsync);
                    break;
                  case 'delete':
                    _showDeleteConfirmation(context, ref, product);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      SizedBox(width: 8),
                      Text('Düzenle'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Sil', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz ürün eklenmemiş',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'İlk ürününüzü eklemek için + butonuna tıklayın',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, WidgetRef ref, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Hata Oluştu',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.read(adminProductsNotifierProvider.notifier).refresh();
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog(BuildContext context, WidgetRef ref,
      AsyncValue<List<Category>> categoriesAsync) {
    categoriesAsync.when(
      data: (categories) =>
          _showProductFormDialog(context, ref, null, categories),
      loading: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kategoriler yükleniyor...')),
      ),
      error: (error, stack) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kategori hatası: $error')),
      ),
    );
  }

  void _showEditProductDialog(BuildContext context, WidgetRef ref,
      Product product, AsyncValue<List<Category>> categoriesAsync) {
    categoriesAsync.when(
      data: (categories) =>
          _showProductFormDialog(context, ref, product, categories),
      loading: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kategoriler yükleniyor...')),
      ),
      error: (error, stack) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kategori hatası: $error')),
      ),
    );
  }

  void _showProductFormDialog(BuildContext context, WidgetRef ref,
      Product? product, List<Category> categories) {
    showDialog(
      context: context,
      builder: (context) => AdminFormDialog(
        title: product == null ? 'Yeni Ürün Ekle' : 'Ürün Düzenle',
        initialData: product != null
            ? {
                'Ürün Adı': product.title,
                'Açıklama': product.description ?? '',
                'Fiyat': product.price.toString(),
                'Stok': product.stock.toString(),
                'Kategori': product.categoryName ?? '',
                'Görsel': product.images.isNotEmpty ? product.images.first : '',
                'Durum': product.isUpcoming ? 'Yakında' : 'Aktif',
              }
            : {
                'Durum': 'Aktif', // Yeni ürün için varsayılan durum
              },
        fields: [
          AdminFormField(
            label: 'Ürün Adı',
            hint: 'Ürün adını girin',
            isRequired: true,
          ),
          AdminFormField(
            label: 'Açıklama',
            hint: 'Ürün açıklaması (opsiyonel)',
            maxLines: 3,
          ),
          AdminFormField(
            label: 'Fiyat',
            hint: 'Ürün fiyatı',
            isRequired: true,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
            ],
          ),
          AdminFormField(
            label: 'Stok',
            hint: 'Stok miktarı',
            isRequired: true,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          AdminFormField(
            label: 'Kategori',
            hint: 'Kategori seçin',
            isRequired: true,
            dropdownOptions: categories.map((cat) => cat.name).toList(),
          ),
          AdminFormField(
            label: 'Görsel',
            hint: 'Ürün görseli seçin (opsiyonel)',
            isImageField: true,
          ),
          AdminFormField(
            label: 'Durum',
            hint: 'Ürün durumunu seçin',
            isRequired: true,
            dropdownOptions: const ['Aktif', 'Yakında'],
          ),
        ],
        onSave: (data) async {
          // Find category ID from category name
          final selectedCategory = categories.firstWhere(
            (cat) => cat.name == data['Kategori'],
            orElse: () => categories.first,
          );

          final productData = {
            'name': data['Ürün Adı'], // Backend 'name' bekliyor, 'title' değil
            'description':
                data['Açıklama']?.isNotEmpty == true ? data['Açıklama'] : null,
            'price': double.parse(data['Fiyat']!),
            'stock': int.parse(data['Stok']!),
            'category_name': selectedCategory
                .name, // Backend 'category_name' bekliyor, 'category_id' değil
            'images': data['Görsel_file']?.isNotEmpty == true
                ? [
                    data['Görsel_file']
                  ] // For now, we'll use the file path as URL
                : [],
            'is_upcoming': data['Durum'] == 'Yakında',
          };

          if (product == null) {
            await ref
                .read(adminProductsNotifierProvider.notifier)
                .createProduct(productData);
          } else {
            await ref
                .read(adminProductsNotifierProvider.notifier)
                .updateProduct(product.id, productData);
          }
        },
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, WidgetRef ref, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ürün Sil'),
        content: Text(
            '${product.title} ürününü silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref
                  .read(adminProductsNotifierProvider.notifier)
                  .deleteProduct(product.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
}
