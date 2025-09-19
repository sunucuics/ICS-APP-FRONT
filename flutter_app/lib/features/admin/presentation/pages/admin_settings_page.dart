import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/admin_settings_provider.dart';
import '../widgets/admin_navigation.dart';
import '../../../../core/theme/app_theme.dart';

class AdminSettingsPage extends ConsumerStatefulWidget {
  const AdminSettingsPage({super.key});

  @override
  ConsumerState<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends ConsumerState<AdminSettingsPage>
    with TickerProviderStateMixin {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistem Ayarları'),
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
            Tab(text: 'Genel', icon: Icon(Icons.settings)),
            Tab(text: 'Ödeme', icon: Icon(Icons.payment)),
            Tab(text: 'E-posta', icon: Icon(Icons.email)),
          ],
        ),
      ),
      body: TabBarView(
        controller:
            TabController(length: 3, vsync: this, initialIndex: _selectedTab),
        children: [
          _buildGeneralSettingsTab(),
          _buildPaymentSettingsTab(),
          _buildEmailSettingsTab(),
        ],
      ),
      bottomNavigationBar: const AdminNavigation(),
    );
  }

  Widget _buildGeneralSettingsTab() {
    final settingsAsync = ref.watch(adminSystemSettingsProvider);

    return settingsAsync.when(
      data: (settings) => _buildGeneralSettingsForm(settings.appSettings),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorWidget(error.toString()),
    );
  }

  Widget _buildGeneralSettingsForm(appSettings) {
    final appNameController = TextEditingController(text: appSettings.appName);
    final contactEmailController =
        TextEditingController(text: appSettings.contactEmail);
    final contactPhoneController =
        TextEditingController(text: appSettings.contactPhone);
    final addressController = TextEditingController(text: appSettings.address);
    final workingHoursController =
        TextEditingController(text: appSettings.workingHours);
    final maintenanceMessageController =
        TextEditingController(text: appSettings.maintenanceMessage ?? '');

    bool maintenanceMode = appSettings.maintenanceMode;

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
                    'Uygulama Ayarları',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryNavy,
                        ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: appNameController,
                    decoration: const InputDecoration(
                      labelText: 'Uygulama Adı',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: contactEmailController,
                    decoration: const InputDecoration(
                      labelText: 'İletişim E-postası',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: contactPhoneController,
                    decoration: const InputDecoration(
                      labelText: 'İletişim Telefonu',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      labelText: 'Adres',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: workingHoursController,
                    decoration: const InputDecoration(
                      labelText: 'Çalışma Saatleri',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Bakım Modu'),
                    subtitle: const Text('Uygulamayı bakım moduna al'),
                    value: maintenanceMode,
                    onChanged: (value) {
                      setState(() {
                        maintenanceMode = value;
                      });
                    },
                    activeColor: AppTheme.primaryOrange,
                  ),
                  if (maintenanceMode) ...[
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: maintenanceMessageController,
                      decoration: const InputDecoration(
                        labelText: 'Bakım Mesajı',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ],
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => _saveGeneralSettings(
                      appNameController.text,
                      contactEmailController.text,
                      contactPhoneController.text,
                      addressController.text,
                      workingHoursController.text,
                      maintenanceMode,
                      maintenanceMessageController.text,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text('Ayarları Kaydet'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSettingsTab() {
    final settingsAsync = ref.watch(adminSystemSettingsProvider);

    return settingsAsync.when(
      data: (settings) => _buildPaymentSettingsForm(settings.paymentSettings),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorWidget(error.toString()),
    );
  }

  Widget _buildPaymentSettingsForm(paymentSettings) {
    final apiKeyController =
        TextEditingController(text: paymentSettings.iyzicoApiKey);
    final secretKeyController =
        TextEditingController(text: paymentSettings.iyzicoSecretKey);
    final baseUrlController =
        TextEditingController(text: paymentSettings.iyzicoBaseUrl);
    final minOrderController =
        TextEditingController(text: paymentSettings.minOrderAmount.toString());
    final maxOrderController = TextEditingController(
        text: paymentSettings.maxOrderAmount?.toString() ?? '');

    bool testMode = paymentSettings.testMode;
    String currency = paymentSettings.currency;

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
                    'Ödeme Ayarları',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryNavy,
                        ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: apiKeyController,
                    decoration: const InputDecoration(
                      labelText: 'Iyzico API Key',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: secretKeyController,
                    decoration: const InputDecoration(
                      labelText: 'Iyzico Secret Key',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: baseUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Iyzico Base URL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: minOrderController,
                          decoration: const InputDecoration(
                            labelText: 'Minimum Sipariş Tutarı',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: maxOrderController,
                          decoration: const InputDecoration(
                            labelText: 'Maksimum Sipariş Tutarı',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: currency,
                    decoration: const InputDecoration(
                      labelText: 'Para Birimi',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'TRY', child: Text('TRY - Türk Lirası')),
                      DropdownMenuItem(
                          value: 'USD', child: Text('USD - Amerikan Doları')),
                      DropdownMenuItem(value: 'EUR', child: Text('EUR - Euro')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        currency = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Test Modu'),
                    subtitle: const Text('Test ödemeleri için aktif et'),
                    value: testMode,
                    onChanged: (value) {
                      setState(() {
                        testMode = value;
                      });
                    },
                    activeColor: AppTheme.primaryOrange,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => _savePaymentSettings(
                      apiKeyController.text,
                      secretKeyController.text,
                      baseUrlController.text,
                      double.tryParse(minOrderController.text) ?? 0.0,
                      double.tryParse(maxOrderController.text),
                      currency,
                      testMode,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: const Text('Ödeme Ayarlarını Kaydet'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailSettingsTab() {
    final templatesAsync = ref.watch(adminEmailTemplatesProvider);

    return templatesAsync.when(
      data: (templates) => _buildEmailTemplatesList(templates),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorWidget(error.toString()),
    );
  }

  Widget _buildEmailTemplatesList(templates) {
    if (templates.isEmpty) {
      return _buildEmptyState('Henüz e-posta şablonu bulunmuyor.', Icons.email);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.refresh(adminEmailTemplatesProvider);
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
                backgroundColor: AppTheme.primaryNavy.withOpacity(0.1),
                child: Icon(
                  Icons.email,
                  color: AppTheme.primaryNavy,
                ),
              ),
              title: Text(
                template.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(template.subject),
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
                      _showEditEmailTemplateDialog(template);
                      break;
                    case 'delete':
                      _showDeleteEmailTemplateConfirmation(template);
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
          Icon(icon, size: 60, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => _showAddEmailTemplateDialog(),
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
              ref.invalidate(adminSystemSettingsProvider);
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveGeneralSettings(
    String appName,
    String contactEmail,
    String contactPhone,
    String address,
    String workingHours,
    bool maintenanceMode,
    String maintenanceMessage,
  ) async {
    try {
      await ref.read(adminSettingsNotifierProvider.notifier).updateAppSettings({
        'app_name': appName,
        'contact_email': contactEmail,
        'contact_phone': contactPhone,
        'address': address,
        'working_hours': workingHours,
        'maintenance_mode': maintenanceMode,
        'maintenance_message':
            maintenanceMessage.isNotEmpty ? maintenanceMessage : null,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Genel ayarlar kaydedildi!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ayarlar kaydedilemedi: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _savePaymentSettings(
    String apiKey,
    String secretKey,
    String baseUrl,
    double minOrderAmount,
    double? maxOrderAmount,
    String currency,
    bool testMode,
  ) async {
    try {
      await ref
          .read(adminSettingsNotifierProvider.notifier)
          .updatePaymentSettings({
        'iyzico_api_key': apiKey,
        'iyzico_secret_key': secretKey,
        'iyzico_base_url': baseUrl,
        'min_order_amount': minOrderAmount,
        'max_order_amount': maxOrderAmount,
        'currency': currency,
        'test_mode': testMode,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ödeme ayarları kaydedildi!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ayarlar kaydedilemedi: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showAddEmailTemplateDialog() {
    // E-posta şablonu ekleme dialog'u
  }

  void _showEditEmailTemplateDialog(template) {
    // E-posta şablonu düzenleme dialog'u
  }

  void _showDeleteEmailTemplateConfirmation(template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('E-posta Şablonu Sil'),
        content: Text(
            '${template.name} şablonunu silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref
                  .read(adminEmailTemplatesNotifierProvider.notifier)
                  .deleteTemplate(template.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }
}
