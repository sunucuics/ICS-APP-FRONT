import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/admin_discounts_provider.dart';
import '../widgets/admin_navigation.dart';
import '../widgets/admin_form_dialog.dart';
import '../../../../core/theme/app_theme.dart';
import '../../models/admin_discount_model.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDiscountDialog(context, ref),
        backgroundColor: AppTheme.primaryOrange,
        child: const Icon(Icons.add, color: Colors.white),
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
    final isActive = discount.isActive &&
        now.isAfter(discount.startDate) &&
        now.isBefore(discount.endDate);

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
                    discount.name,
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
                        '${discount.targetType == 'product' ? 'Ürün' : 'Kategori'}: ${discount.targetName ?? 'Tümü'}',
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
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  'Başlangıç: ${_formatDate(discount.startDate)}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Text(
                  'Bitiş: ${_formatDate(discount.endDate)}',
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
    _showDiscountFormDialog(context, ref, null);
  }

  void _showEditDiscountDialog(
      BuildContext context, WidgetRef ref, AdminDiscount discount) {
    _showDiscountFormDialog(context, ref, discount);
  }

  void _showDiscountFormDialog(
      BuildContext context, WidgetRef ref, AdminDiscount? discount) {
    showDialog(
      context: context,
      builder: (context) => AdminFormDialog(
        title: discount == null ? 'Yeni İndirim Ekle' : 'İndirim Düzenle',
        initialData: discount != null
            ? {
                'İndirim Adı': discount.name,
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
            hint: 'product veya category',
            isRequired: true,
          ),
          AdminFormField(
            label: 'Hedef ID',
            hint: 'Hedef ürün/kategori ID (opsiyonel)',
          ),
          AdminFormField(
            label: 'Açıklama',
            hint: 'İndirim açıklaması (opsiyonel)',
            maxLines: 3,
          ),
        ],
        onSave: (data) async {
          final discountData = DiscountCreateRequest(
            name: data['İndirim Adı']!,
            percentage: double.parse(data['İndirim Oranı (%)']!),
            targetType: data['Hedef Tip']!,
            targetId:
                data['Hedef ID']?.isNotEmpty == true ? data['Hedef ID'] : null,
            startDate: DateTime.now(),
            endDate: DateTime.now().add(const Duration(days: 30)),
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
        title: Text('İndirim Detayları: ${discount.name}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('İndirim Oranı: %${discount.percentage.toStringAsFixed(0)}'),
              Text('Hedef Tip: ${discount.targetType}'),
              if (discount.targetName != null)
                Text('Hedef: ${discount.targetName}'),
              Text('Başlangıç: ${_formatDate(discount.startDate)}'),
              Text('Bitiş: ${_formatDate(discount.endDate)}'),
              Text('Durum: ${discount.isActive ? 'Aktif' : 'Pasif'}'),
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
            '${discount.name} indirimini silmek istediğinizden emin misiniz?'),
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
