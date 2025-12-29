import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/admin_categories_provider.dart';
import '../widgets/admin_form_dialog.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/product_model.dart';

// Content widget for use in AdminMainPage
class AdminCategoriesPageContent extends ConsumerWidget {
  const AdminCategoriesPageContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(adminCategoriesNotifierProvider);

    return Stack(
      children: [
        categoriesAsync.when(
          data: (categories) => _buildCategoriesList(context, ref, categories),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) =>
              _buildErrorWidget(context, ref, error.toString()),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => _showAddCategoryDialog(context, ref),
            backgroundColor: AppTheme.primaryOrange,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesList(
      BuildContext context, WidgetRef ref, List<Category> categories) {
    if (categories.isEmpty) {
      return _buildEmptyState(context, ref);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(adminCategoriesNotifierProvider.notifier).refresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _buildCategoryCard(context, ref, category);
        },
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, WidgetRef ref, Category category) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Category Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppTheme.primaryNavy.withOpacity(0.1),
              ),
              child: category.coverImage != null &&
                      category.coverImage!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        category.coverImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.category,
                            color: AppTheme.primaryNavy,
                            size: 30,
                          );
                        },
                      ),
                    )
                  : Icon(
                      Icons.category,
                      color: AppTheme.primaryNavy,
                      size: 30,
                    ),
            ),
            const SizedBox(width: 16),

            // Category Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (category.description != null &&
                      category.description!.isNotEmpty)
                    Text(
                      category.description!,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildStatusChip(
                        !category.isDeleted ? 'Aktif' : 'Pasif',
                        !category.isDeleted ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      if (category.isFixed)
                        _buildStatusChip('Sabit', Colors.blue),
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
                    _showEditCategoryDialog(context, ref, category);
                    break;
                  case 'delete':
                    _showDeleteConfirmation(context, ref, category);
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
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
            Icons.category_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz kategori eklenmemiş',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'İlk kategorinizi eklemek için + butonuna tıklayın',
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
              ref.read(adminCategoriesNotifierProvider.notifier).refresh();
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AdminFormDialog(
        title: 'Yeni Kategori Ekle',
        fields: [
          AdminFormField(
            label: 'Kategori Adı',
            hint: 'Kategori adını girin',
            isRequired: true,
          ),
          AdminFormField(
            label: 'Açıklama',
            hint: 'Kategori açıklaması',
            isRequired: true,
            maxLines: 3,
          ),
          AdminFormField(
            label: 'Görsel',
            hint: 'Kategori görseli seçin',
            isRequired: true,
            isImageField: true,
          ),
        ],
        onSave: (data) async {
          final categoryData = {
            'name': data['Kategori Adı'],
            'description':
                data['Açıklama']?.isNotEmpty == true ? data['Açıklama'] : '',
            'imageUrl': data['Görsel_file']?.isNotEmpty == true
                ? data['Görsel_file']
                : null,
            'is_fixed': false,
          };

          await ref
              .read(adminCategoriesNotifierProvider.notifier)
              .createCategory(categoryData);
        },
      ),
    );
  }

  void _showEditCategoryDialog(
      BuildContext context, WidgetRef ref, Category category) {
    showDialog(
      context: context,
      builder: (context) => AdminFormDialog(
        title: 'Kategori Düzenle',
        initialData: {
          'Kategori Adı': category.name,
          'Açıklama': category.description ?? '',
          'Görsel': category.coverImage ?? '',
        },
        fields: [
          AdminFormField(
            label: 'Kategori Adı',
            hint: 'Kategori adını girin',
            isRequired: true,
          ),
          AdminFormField(
            label: 'Açıklama',
            hint: 'Kategori açıklaması (opsiyonel)',
            maxLines: 3,
          ),
          AdminFormField(
            label: 'Görsel',
            hint: 'Kategori görseli seçin (opsiyonel)',
            isImageField: true,
          ),
        ],
        onSave: (data) async {
          final categoryData = {
            'name': data['Kategori Adı'],
            'description':
                data['Açıklama']?.isNotEmpty == true ? data['Açıklama'] : null,
            'image': data['Görsel_file']?.isNotEmpty == true
                ? data['Görsel_file']
                : null,
            'isDeleted': category.isDeleted,
            'isFixed': category.isFixed,
          };

          await ref
              .read(adminCategoriesNotifierProvider.notifier)
              .updateCategory(category.id, categoryData);
        },
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, WidgetRef ref, Category category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kategori Sil'),
        content: Text(
            '${category.name} kategorisini silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref
                  .read(adminCategoriesNotifierProvider.notifier)
                  .deleteCategory(category.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
}

class AdminCategoriesPage extends ConsumerWidget {
  const AdminCategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(adminCategoriesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Yönetimi'),
        backgroundColor: AppTheme.primaryNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(adminCategoriesNotifierProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: categoriesAsync.when(
        data: (categories) => _buildCategoriesList(context, ref, categories),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            _buildErrorWidget(context, ref, error.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCategoryDialog(context, ref),
        backgroundColor: AppTheme.primaryOrange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCategoriesList(
      BuildContext context, WidgetRef ref, List<Category> categories) {
    if (categories.isEmpty) {
      return _buildEmptyState(context, ref);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(adminCategoriesNotifierProvider.notifier).refresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _buildCategoryCard(context, ref, category);
        },
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, WidgetRef ref, Category category) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Category Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppTheme.primaryNavy.withOpacity(0.1),
              ),
              child:
                  category.coverImage != null && category.coverImage!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            category.coverImage!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.category,
                                color: AppTheme.primaryNavy,
                                size: 30,
                              );
                            },
                          ),
                        )
                      : Icon(
                          Icons.category,
                          color: AppTheme.primaryNavy,
                          size: 30,
                        ),
            ),
            const SizedBox(width: 16),

            // Category Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (category.description != null &&
                      category.description!.isNotEmpty)
                    Text(
                      category.description!,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildStatusChip(
                        !category.isDeleted ? 'Aktif' : 'Pasif',
                        !category.isDeleted ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      if (category.isFixed)
                        _buildStatusChip('Sabit', Colors.blue),
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
                    _showEditCategoryDialog(context, ref, category);
                    break;
                  case 'delete':
                    _showDeleteConfirmation(context, ref, category);
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
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
            Icons.category_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz kategori eklenmemiş',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'İlk kategorinizi eklemek için + butonuna tıklayın',
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
              ref.read(adminCategoriesNotifierProvider.notifier).refresh();
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AdminFormDialog(
        title: 'Yeni Kategori Ekle',
        fields: [
          AdminFormField(
            label: 'Kategori Adı',
            hint: 'Kategori adını girin',
            isRequired: true,
          ),
          AdminFormField(
            label: 'Açıklama',
            hint: 'Kategori açıklaması (opsiyonel)',
            maxLines: 3,
          ),
          AdminFormField(
            label: 'Görsel',
            hint: 'Kategori görseli seçin (opsiyonel)',
            isImageField: true,
          ),
        ],
        onSave: (data) async {
          final categoryData = {
            'name': data['Kategori Adı'],
            'description':
                data['Açıklama']?.isNotEmpty == true ? data['Açıklama'] : '',
            'imageUrl': data['Görsel_file']?.isNotEmpty == true
                ? data['Görsel_file']
                : null,
            'is_fixed': false, // Backend expects this field
          };

          await ref
              .read(adminCategoriesNotifierProvider.notifier)
              .createCategory(categoryData);
        },
      ),
    );
  }

  void _showEditCategoryDialog(
      BuildContext context, WidgetRef ref, Category category) {
    showDialog(
      context: context,
      builder: (context) => AdminFormDialog(
        title: 'Kategori Düzenle',
        initialData: {
          'Kategori Adı': category.name,
          'Açıklama': category.description ?? '',
          'Görsel': category.coverImage ?? '',
        },
        fields: [
          AdminFormField(
            label: 'Kategori Adı',
            hint: 'Kategori adını girin',
            isRequired: true,
          ),
          AdminFormField(
            label: 'Açıklama',
            hint: 'Kategori açıklaması (opsiyonel)',
            maxLines: 3,
          ),
          AdminFormField(
            label: 'Görsel',
            hint: 'Kategori görseli seçin (opsiyonel)',
            isImageField: true,
          ),
        ],
        onSave: (data) async {
          final categoryData = {
            'name': data['Kategori Adı'],
            'description':
                data['Açıklama']?.isNotEmpty == true ? data['Açıklama'] : null,
            'image': data['Görsel_file']?.isNotEmpty == true
                ? data['Görsel_file']
                : null,
            'isDeleted': category.isDeleted,
            'isFixed': category.isFixed,
          };

          await ref
              .read(adminCategoriesNotifierProvider.notifier)
              .updateCategory(category.id, categoryData);
        },
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, WidgetRef ref, Category category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kategori Sil'),
        content: Text(
            '${category.name} kategorisini silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref
                  .read(adminCategoriesNotifierProvider.notifier)
                  .deleteCategory(category.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
}
