import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/admin_services_provider.dart';
import '../widgets/admin_service_form_dialog.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/service_model.dart';

class AdminServicesPage extends ConsumerWidget {
  const AdminServicesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(adminServicesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hizmet Yönetimi'),
        backgroundColor: AppTheme.primaryNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(adminServicesNotifierProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: servicesAsync.when(
        data: (services) => _buildServicesList(context, ref, services),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            _buildErrorWidget(context, ref, error.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddServiceDialog(context, ref),
        backgroundColor: AppTheme.primaryOrange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildServicesList(
      BuildContext context, WidgetRef ref, List<Service> services) {
    if (services.isEmpty) {
      return _buildEmptyState(context, ref);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(adminServicesNotifierProvider.notifier).refresh();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return _buildServiceCard(context, ref, service);
        },
      ),
    );
  }

  Widget _buildServiceCard(
      BuildContext context, WidgetRef ref, Service service) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Service Images - Show all images (max 3)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppTheme.primaryNavy.withOpacity(0.1),
              ),
              child: service.images.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: service.images.length == 1
                          ? Image.network(
                              service.images[0],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.work,
                                  color: AppTheme.primaryNavy,
                                  size: 30,
                                );
                              },
                            )
                          : PageView.builder(
                              itemCount: service.images.length,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  service.images[index],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.work,
                                      color: AppTheme.primaryNavy,
                                      size: 30,
                                    );
                                  },
                                );
                              },
                            ),
                    )
                  : Icon(
                      Icons.work,
                      color: AppTheme.primaryNavy,
                      size: 30,
                    ),
            ),
            const SizedBox(width: 16),

            // Service Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (service.description.isNotEmpty)
                    Text(
                      service.description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 8),

                  // Service Type
                  Text(
                    'Tür: ${service.kind}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildStatusChip(
                        !service.isDeleted ? 'Aktif' : 'Pasif',
                        !service.isDeleted ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      if (service.isUpcoming)
                        _buildStatusChip('Yakında', Colors.orange),
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
                    _showEditServiceDialog(context, ref, service);
                    break;
                  case 'delete':
                    _showDeleteConfirmation(context, ref, service);
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
            Icons.work_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz hizmet eklenmemiş',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'İlk hizmetinizi eklemek için + butonuna tıklayın',
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
              ref.read(adminServicesNotifierProvider.notifier).refresh();
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  void _showAddServiceDialog(BuildContext context, WidgetRef ref) {
    _showServiceFormDialog(context, ref, null);
  }

  void _showEditServiceDialog(
      BuildContext context, WidgetRef ref, Service service) {
    _showServiceFormDialog(context, ref, service);
  }

  void _showServiceFormDialog(
      BuildContext context, WidgetRef ref, Service? service) {
    showDialog(
      context: context,
      builder: (context) => AdminServiceFormDialog(
        service: service,
        onSave: (data) async {
          if (service == null) {
            await ref
                .read(adminServicesNotifierProvider.notifier)
                .createService(data);
          } else {
            await ref
                .read(adminServicesNotifierProvider.notifier)
                .updateService(service.id, data);
          }
        },
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, WidgetRef ref, Service service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hizmet Sil'),
        content: Text(
            '${service.title} hizmetini silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref
                  .read(adminServicesNotifierProvider.notifier)
                  .deleteService(service.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
}
