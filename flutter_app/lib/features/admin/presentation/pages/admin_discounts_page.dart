import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/admin_discounts_provider.dart';
import '../../providers/admin_products_provider.dart';
import '../../providers/admin_categories_provider.dart';
import '../widgets/admin_navigation.dart';
import '../widgets/admin_form_dialog.dart';
import '../../../../core/theme/app_theme.dart';
import '../../models/admin_discount_model.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/services/snackbar_service.dart';

class AdminDiscountsPage extends ConsumerWidget {
  const AdminDiscountsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discountsAsync = ref.watch(adminDiscountsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('İndirim Yönetimi'),
        backgroundColor: AppTheme.primaryNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(adminDiscountsNotifierProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: discountsAsync.when(
        data: (discounts) => _buildDiscountsList(context, ref, discounts),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            _buildErrorWidget(context, ref, error.toString()),
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          final productsAsync = ref.watch(adminProductsNotifierProvider);
          final categoriesAsync = ref.watch(adminCategoriesProvider);
          final isLoading =
              productsAsync.isLoading || categoriesAsync.isLoading;

          return FloatingActionButton(
            onPressed:
                isLoading ? null : () => _showAddDiscountDialog(context, ref),
            backgroundColor: isLoading ? Colors.grey : AppTheme.primaryOrange,
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.add, color: Colors.white),
          );
        },
      ),
      bottomNavigationBar: const AdminNavigation(),
    );
  }

  Widget _buildDiscountsList(
      BuildContext context, WidgetRef ref, List<AdminDiscount> discounts) {
    if (discounts.isEmpty) {
      return _buildEmptyState(context, ref);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(adminDiscountsNotifierProvider.notifier).refresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: discounts.length,
        itemBuilder: (context, index) {
          final discount = discounts[index];
          return _buildDiscountCard(context, ref, discount);
        },
      ),
    );
  }

  Widget _buildDiscountCard(
      BuildContext context, WidgetRef ref, AdminDiscount discount) {
    final now = DateTime.now();
    final isActive = discount.active &&
        (discount.startAt == null || now.compareTo(discount.startAt!) >= 0) &&
        (discount.endAt == null || now.compareTo(discount.endAt!) < 0);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Discount Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'İndirim #${discount.id.substring(0, 8)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildStatusChip(
                  isActive ? 'Aktif' : 'Pasif',
                  isActive ? Colors.green : Colors.red,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Discount Details
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryNavy.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'İndirim Oranı:',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '%${discount.percentage.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppTheme.primaryOrange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hedef:',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${discount.targetType == 'product' ? 'Ürün' : 'Kategori'}: ${discount.targetId ?? 'Tümü'}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Date Range
            if (discount.startAt != null || discount.endAt != null)
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    'Başlangıç: ${discount.startAt != null ? _formatDate(discount.startAt!) : 'Sınırsız'}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Bitiş: ${discount.endAt != null ? _formatDate(discount.endAt!) : 'Sınırsız'}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

            if (discount.description != null &&
                discount.description!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  discount.description!,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 12),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _showDiscountDetails(context, discount),
                    child: const Text('Detaylar'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        _showEditDiscountDialog(context, ref, discount),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Düzenle'),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () =>
                      _showDeleteConfirmation(context, ref, discount),
                  icon: const Icon(Icons.delete, color: Colors.red),
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_offer_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz indirim eklenmemiş',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'İlk indiriminizi eklemek için + butonuna tıklayın',
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
              ref.read(adminDiscountsNotifierProvider.notifier).refresh();
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  void _showAddDiscountDialog(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.read(adminProductsNotifierProvider);
    final categoriesAsync = ref.read(adminCategoriesProvider);

    productsAsync.when(
      data: (products) => categoriesAsync.when(
        data: (categories) =>
            _showDiscountFormDialog(context, ref, null, products, categories),
        loading: () => SnackBarService.showSnackBar(context: context, snackBar: 
          const SnackBar(content: Text('Kategoriler yükleniyor...')),
        ),
        error: (error, stack) => SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(content: Text('Kategori hatası: $error')),
        ),
      ),
      loading: () => SnackBarService.showSnackBar(context: context, snackBar: 
        const SnackBar(content: Text('Ürünler yükleniyor...')),
      ),
      error: (error, stack) => SnackBarService.showSnackBar(context: context, snackBar: 
        SnackBar(content: Text('Ürün hatası: $error')),
      ),
    );
  }

  void _showEditDiscountDialog(
      BuildContext context, WidgetRef ref, AdminDiscount discount) {
    _showDiscountFormDialog(context, ref, discount);
  }

  void _showDiscountFormDialog(
      BuildContext context, WidgetRef ref, AdminDiscount? discount,
      [List<Product>? products, List<Category>? categories]) {
    showDialog(
      context: context,
      builder: (context) => AdminFormDialog(
        title: discount == null ? 'Yeni İndirim Ekle' : 'İndirim Düzenle',
        initialData: discount != null
            ? {
                'İndirim Adı': 'İndirim #${discount.id.substring(0, 8)}',
                'İndirim Oranı': discount.percentage.toString(),
                'Hedef Tip': discount.targetType,
                'Hedef ID': discount.targetId ?? '',
                'Açıklama': discount.description ?? '',
              }
            : null,
        fields: [
          AdminFormField(
            label: 'İndirim Adı',
            hint: 'İndirim adını girin',
            isRequired: true,
          ),
          AdminFormField(
            label: 'İndirim Oranı (%)',
            hint: 'İndirim oranını girin (örn: 10)',
            isRequired: true,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
            ],
          ),
          AdminFormField(
            label: 'Hedef Tip',
            hint: 'Hedef tip seçin',
            isRequired: true,
            dropdownOptions: const ['product', 'category'],
          ),
          AdminFormField(
            label: 'Hedef ID',
            hint: products != null && categories != null
                ? 'Ürünler sayfasından ID kopyalayın (opsiyonel)'
                : 'Hedef ürün/kategori ID (opsiyonel)',
          ),
          AdminFormField(
            label: 'Başlangıç Tarihi',
            hint: 'Başlangıç tarihini seçin',
            isDateField: true,
          ),
          AdminFormField(
            label: 'Bitiş Tarihi',
            hint: 'Bitiş tarihini seçin',
            isDateField: true,
          ),
          AdminFormField(
            label: 'Açıklama',
            hint: 'İndirim açıklaması (opsiyonel)',
            maxLines: 3,
          ),
        ],
        onSave: (data) async {
          // Tarih parsing
          DateTime? startDate;
          DateTime? endDate;

          if (data['Başlangıç Tarihi']?.isNotEmpty == true) {
            final startParts = data['Başlangıç Tarihi']!.split('/');
            if (startParts.length == 3) {
              startDate = DateTime(
                int.parse(startParts[2]), // year
                int.parse(startParts[1]), // month
                int.parse(startParts[0]), // day
              );
            }
          }

          if (data['Bitiş Tarihi']?.isNotEmpty == true) {
            final endParts = data['Bitiş Tarihi']!.split('/');
            if (endParts.length == 3) {
              endDate = DateTime(
                int.parse(endParts[2]), // year
                int.parse(endParts[1]), // month
                int.parse(endParts[0]), // day
              );
            }
          }

          final discountData = DiscountCreateRequest(
            name: data['İndirim Adı']!,
            percentage: double.parse(data['İndirim Oranı (%)']!),
            targetType: data['Hedef Tip']!,
            targetId:
                data['Hedef ID']?.isNotEmpty == true ? data['Hedef ID'] : null,
            startDate: startDate ?? DateTime.now(),
            endDate: endDate ?? DateTime.now().add(const Duration(days: 30)),
            isActive: true,
            description:
                data['Açıklama']?.isNotEmpty == true ? data['Açıklama'] : null,
          );

          if (discount == null) {
            await ref
                .read(adminDiscountsNotifierProvider.notifier)
                .createDiscount(discountData);
          } else {
            final updateData = DiscountUpdateRequest(
              name: data['İndirim Adı'],
              percentage: double.parse(data['İndirim Oranı (%)']!),
              targetType: data['Hedef Tip'],
              targetId: data['Hedef ID']?.isNotEmpty == true
                  ? data['Hedef ID']
                  : null,
              description: data['Açıklama']?.isNotEmpty == true
                  ? data['Açıklama']
                  : null,
            );
            await ref
                .read(adminDiscountsNotifierProvider.notifier)
                .updateDiscount(discount.id, updateData);
          }
        },
      ),
    );
  }

  void _showDiscountDetails(BuildContext context, AdminDiscount discount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('İndirim Detayları: #${discount.id.substring(0, 8)}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('İndirim Oranı: %${discount.percentage.toStringAsFixed(0)}'),
              Text('Hedef Tip: ${discount.targetType}'),
              if (discount.targetId != null)
                Text('Hedef ID: ${discount.targetId}'),
              Text(
                  'Başlangıç: ${discount.startAt != null ? _formatDate(discount.startAt!) : 'Sınırsız'}'),
              Text(
                  'Bitiş: ${discount.endAt != null ? _formatDate(discount.endAt!) : 'Sınırsız'}'),
              Text('Durum: ${discount.active ? 'Aktif' : 'Pasif'}'),
              if (discount.description != null)
                Text('Açıklama: ${discount.description}'),
              if (discount.createdAt != null)
                Text('Oluşturulma: ${_formatDate(discount.createdAt!)}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, WidgetRef ref, AdminDiscount discount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('İndirim Sil'),
        content: Text(
            'İndirim #${discount.id.substring(0, 8)} indirimini silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref
                  .read(adminDiscountsNotifierProvider.notifier)
                  .deleteDiscount(discount.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
}
