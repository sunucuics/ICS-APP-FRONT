import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/admin_notifications_provider.dart';
import '../widgets/admin_navigation.dart';
import '../../../../core/theme/app_theme.dart';

class AdminNotificationsPage extends ConsumerStatefulWidget {
  const AdminNotificationsPage({super.key});

  @override
  ConsumerState<AdminNotificationsPage> createState() =>
      _AdminNotificationsPageState();
}

class _AdminNotificationsPageState extends ConsumerState<AdminNotificationsPage>
    with TickerProviderStateMixin {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirim Yönetimi'),
        backgroundColor: AppTheme.primaryNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller:
              TabController(length: 3, vsync: this, initialIndex: _selectedTab),
          onTap: (index) => setState(() => _selectedTab = index),
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Şablonlar', icon: Icon(Icons.description)),
            Tab(text: 'Kampanyalar', icon: Icon(Icons.campaign)),
            Tab(text: 'Gönder', icon: Icon(Icons.send)),
          ],
        ),
      ),
      body: TabBarView(
        controller:
            TabController(length: 3, vsync: this, initialIndex: _selectedTab),
        children: [
          _buildTemplatesTab(),
          _buildCampaignsTab(),
          _buildSendTab(),
        ],
      ),
      bottomNavigationBar: const AdminNavigation(),
    );
  }

  Widget _buildTemplatesTab() {
    final templatesAsync = ref.watch(adminNotificationTemplatesProvider);

    return templatesAsync.when(
      data: (templates) => _buildTemplatesList(templates),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorWidget(error.toString()),
    );
  }

  Widget _buildTemplatesList(templates) {
    if (templates.isEmpty) {
      return _buildEmptyState(
          'Henüz bildirim şablonu bulunmuyor.', Icons.description);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.refresh(adminNotificationTemplatesProvider);
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: templates.length,
        itemBuilder: (context, index) {
          final template = templates[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppTheme.primaryOrange.withOpacity(0.1),
                child: Icon(
                  Icons.description,
                  color: AppTheme.primaryOrange,
                ),
              ),
              title: Text(
                template.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(template.body),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _buildStatusChip(
                        template.templateType,
                        Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      _buildStatusChip(
                        template.isActive ? 'Aktif' : 'Pasif',
                        template.isActive ? Colors.green : Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      _showEditTemplateDialog(template);
                      break;
                    case 'delete':
                      _showDeleteTemplateConfirmation(template);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: AppTheme.primaryOrange),
                        SizedBox(width: 8),
                        Text('Düzenle'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Sil'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCampaignsTab() {
    final campaignsAsync = ref.watch(adminNotificationCampaignsProvider);

    return campaignsAsync.when(
      data: (campaigns) => _buildCampaignsList(campaigns),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorWidget(error.toString()),
    );
  }

  Widget _buildCampaignsList(campaigns) {
    if (campaigns.isEmpty) {
      return _buildEmptyState(
          'Henüz bildirim kampanyası bulunmuyor.', Icons.campaign);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.refresh(adminNotificationCampaignsProvider);
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          final campaign = campaigns[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppTheme.primaryNavy.withOpacity(0.1),
                        child: Icon(
                          Icons.campaign,
                          color: AppTheme.primaryNavy,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              campaign.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              campaign.body,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildStatusChip(
                        campaign.status,
                        _getStatusColor(campaign.status),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCampaignMetric(
                          'Hedef',
                          campaign.targetCount.toString(),
                          Icons.people,
                          Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: _buildCampaignMetric(
                          'Gönderilen',
                          campaign.sentCount.toString(),
                          Icons.send,
                          Colors.green,
                        ),
                      ),
                      Expanded(
                        child: _buildCampaignMetric(
                          'Teslim',
                          campaign.deliveredCount.toString(),
                          Icons.check_circle,
                          Colors.orange,
                        ),
                      ),
                      Expanded(
                        child: _buildCampaignMetric(
                          'Açılan',
                          campaign.openedCount.toString(),
                          Icons.visibility,
                          Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSendTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bildirim Gönder',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryNavy,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildSendForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendForm() {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    String? selectedTemplate;
    List<String> selectedSegments = [];

    return Column(
      children: [
        TextFormField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'Başlık',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: bodyController,
          decoration: const InputDecoration(
            labelText: 'İçerik',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: selectedTemplate,
          decoration: const InputDecoration(
            labelText: 'Şablon Seç (Opsiyonel)',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: null, child: Text('Şablon kullanma')),
            // Burada şablonlar listesi gelecek
          ],
          onChanged: (value) {
            selectedTemplate = value;
          },
        ),
        const SizedBox(height: 16),
        const Text(
          'Hedef Kitle',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            FilterChip(
              label: const Text('Tüm Kullanıcılar'),
              selected: selectedSegments.isEmpty,
              onSelected: (selected) {
                if (selected) {
                  selectedSegments.clear();
                }
              },
            ),
            FilterChip(
              label: const Text('Aktif Kullanıcılar'),
              selected: selectedSegments.contains('active'),
              onSelected: (selected) {
                if (selected) {
                  selectedSegments.add('active');
                } else {
                  selectedSegments.remove('active');
                }
              },
            ),
            FilterChip(
              label: const Text('Yeni Kullanıcılar'),
              selected: selectedSegments.contains('new'),
              onSelected: (selected) {
                if (selected) {
                  selectedSegments.add('new');
                } else {
                  selectedSegments.remove('new');
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Test gönderimi
                  _showTestDialog(titleController.text, bodyController.text);
                },
                icon: const Icon(Icons.send),
                label: const Text('Test Gönder'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Gerçek gönderim
                  _sendNotification(
                    titleController.text,
                    bodyController.text,
                    selectedTemplate,
                    selectedSegments,
                  );
                },
                icon: const Icon(Icons.send),
                label: const Text('Gönder'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryOrange,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCampaignMetric(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String text, Color color) {
    return Chip(
      label: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
      backgroundColor: color,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.description, size: 60, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => _showAddTemplateDialog(),
            icon: const Icon(Icons.add),
            label: const Text('Yeni Şablon Ekle'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryOrange,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          Text(
            'Hata oluştu: $error',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.invalidate(adminNotificationTemplatesProvider);
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'sending':
        return Colors.orange;
      case 'scheduled':
        return Colors.blue;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showAddTemplateDialog() {
    // Şablon ekleme dialog'u
  }

  void _showEditTemplateDialog(template) {
    // Şablon düzenleme dialog'u
  }

  void _showDeleteTemplateConfirmation(template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Şablon Sil'),
        content: Text(
            '${template.title} şablonunu silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref
                  .read(adminNotificationTemplatesNotifierProvider.notifier)
                  .deleteTemplate(template.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }

  void _showTestDialog(String title, String body) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Test Bildirimi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Başlık: $title'),
            const SizedBox(height: 8),
            Text('İçerik: $body'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  Future<void> _sendNotification(
    String title,
    String body,
    String? templateId,
    List<String> segments,
  ) async {
    try {
      await ref
          .read(adminNotificationTemplatesNotifierProvider.notifier)
          .sendNotification(title, body, templateId, segments);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bildirim gönderildi!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bildirim gönderme hatası: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
