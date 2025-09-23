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
        ref.invalidate(adminNotificationTemplatesProvider);
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
                template.name ?? template.title ?? 'Başlıksız',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(template.content ?? template.body ?? 'İçerik yok'),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _buildStatusChip(
                        template.type ?? template.templateType ?? 'genel',
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
        ref.invalidate(adminNotificationCampaignsProvider);
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

    // Şablonları al
    final templatesAsync = ref.watch(adminNotificationTemplatesProvider);

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
        templatesAsync.when(
          data: (templates) => DropdownButtonFormField<String>(
            value: selectedTemplate,
            decoration: const InputDecoration(
              labelText: 'Şablon Seç (Opsiyonel)',
              border: OutlineInputBorder(),
            ),
            items: [
              const DropdownMenuItem(
                  value: null, child: Text('Şablon kullanma')),
              ...templates.map((template) => DropdownMenuItem(
                    value: template.id,
                    child: Text(template.name.isNotEmpty
                        ? template.name
                        : (template.title?.isNotEmpty == true
                            ? template.title!
                            : 'Başlıksız')),
                  )),
            ],
            onChanged: (value) {
              selectedTemplate = value;
              if (value != null) {
                // Şablon seçildiğinde form alanlarını doldur
                final template = templates.firstWhere((t) => t.id == value);
                titleController.text = template.subject.isNotEmpty
                    ? template.subject
                    : (template.name.isNotEmpty
                        ? template.name
                        : (template.title?.isNotEmpty == true
                            ? template.title!
                            : ''));
                bodyController.text = template.content.isNotEmpty
                    ? template.content
                    : (template.body?.isNotEmpty == true ? template.body! : '');
              } else {
                // Şablon seçimi kaldırıldığında alanları temizle
                titleController.clear();
                bodyController.clear();
              }
            },
          ),
          loading: () => DropdownButtonFormField<String>(
            value: null,
            decoration: const InputDecoration(
              labelText: 'Şablonlar yükleniyor...',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: null, child: Text('Yükleniyor...'))
            ],
            onChanged: null,
          ),
          error: (error, stack) => DropdownButtonFormField<String>(
            value: null,
            decoration: const InputDecoration(
              labelText: 'Şablonlar yüklenemedi',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: null, child: Text('Hata oluştu'))
            ],
            onChanged: null,
          ),
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
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    String selectedTemplateType = 'general';
    bool isActive = true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Yeni Şablon Ekle'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Şablon Başlığı',
                    border: OutlineInputBorder(),
                    hintText: 'Örn: Hoş Geldiniz Bildirimi',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Başlık gereklidir';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: bodyController,
                  decoration: const InputDecoration(
                    labelText: 'Şablon İçeriği',
                    border: OutlineInputBorder(),
                    hintText: 'Bildirim içeriğini buraya yazın...',
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'İçerik gereklidir';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedTemplateType,
                  decoration: const InputDecoration(
                    labelText: 'Şablon Türü',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'general',
                      child: Text('Genel'),
                    ),
                    DropdownMenuItem(
                      value: 'promotional',
                      child: Text('Promosyon'),
                    ),
                    DropdownMenuItem(
                      value: 'system',
                      child: Text('Sistem'),
                    ),
                    DropdownMenuItem(
                      value: 'reminder',
                      child: Text('Hatırlatma'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedTemplateType = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: isActive,
                      onChanged: (value) {
                        setState(() {
                          isActive = value ?? true;
                        });
                      },
                    ),
                    const Text('Şablonu aktif olarak kaydet'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isEmpty ||
                    bodyController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lütfen tüm alanları doldurun'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                try {
                  final templateData = {
                    'id': '', // Backend will generate this
                    'name': titleController.text,
                    'subject': titleController.text,
                    'content': bodyController.text,
                    'type': selectedTemplateType,
                    'is_active': isActive,
                  };

                  await ref
                      .read(adminNotificationTemplatesNotifierProvider.notifier)
                      .createTemplate(templateData);

                  if (mounted) {
                    Navigator.of(context).pop();
                    // Provider'ı yenile
                    ref.invalidate(adminNotificationTemplatesProvider);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Şablon başarıyla oluşturuldu!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Şablon oluşturma hatası: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryOrange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Oluştur'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditTemplateDialog(template) {
    final titleController =
        TextEditingController(text: template.name ?? template.title ?? '');
    final bodyController =
        TextEditingController(text: template.content ?? template.body ?? '');
    String selectedTemplateType =
        template.type ?? template.templateType ?? 'general';
    bool isActive = template.isActive;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Şablon Düzenle'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Şablon Başlığı',
                    border: OutlineInputBorder(),
                    hintText: 'Örn: Hoş Geldiniz Bildirimi',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Başlık gereklidir';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: bodyController,
                  decoration: const InputDecoration(
                    labelText: 'Şablon İçeriği',
                    border: OutlineInputBorder(),
                    hintText: 'Bildirim içeriğini buraya yazın...',
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'İçerik gereklidir';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedTemplateType,
                  decoration: const InputDecoration(
                    labelText: 'Şablon Türü',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'general',
                      child: Text('Genel'),
                    ),
                    DropdownMenuItem(
                      value: 'promotional',
                      child: Text('Promosyon'),
                    ),
                    DropdownMenuItem(
                      value: 'system',
                      child: Text('Sistem'),
                    ),
                    DropdownMenuItem(
                      value: 'reminder',
                      child: Text('Hatırlatma'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedTemplateType = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: isActive,
                      onChanged: (value) {
                        setState(() {
                          isActive = value ?? true;
                        });
                      },
                    ),
                    const Text('Şablonu aktif olarak kaydet'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isEmpty ||
                    bodyController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lütfen tüm alanları doldurun'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                try {
                  final templateData = {
                    'id': template.id,
                    'name': titleController.text,
                    'subject': titleController.text,
                    'content': bodyController.text,
                    'type': selectedTemplateType,
                    'is_active': isActive,
                  };

                  await ref
                      .read(adminNotificationTemplatesNotifierProvider.notifier)
                      .updateTemplate(template.id, templateData);

                  if (mounted) {
                    Navigator.of(context).pop();
                    // Provider'ı yenile
                    ref.invalidate(adminNotificationTemplatesProvider);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Şablon başarıyla güncellendi!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Şablon güncelleme hatası: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryOrange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Güncelle'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteTemplateConfirmation(template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Şablon Sil'),
        content: Text(
            '${template.name ?? template.title ?? 'Bu'} şablonunu silmek istediğinizden emin misiniz?'),
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
              // Provider'ı yenile
              ref.invalidate(adminNotificationTemplatesProvider);
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
