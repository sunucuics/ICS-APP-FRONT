import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../core/services/account_service.dart';
import '../../../../core/services/navigation_service.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tema Ayarları
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.palette,
                        color: AppTheme.primaryOrange,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Tema Ayarları',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                _buildThemeOption(
                  context,
                  ref,
                  ThemeMode.system,
                  'Sistem Teması',
                  'Cihaz ayarlarına göre tema seç',
                  Icons.settings_suggest,
                  themeMode,
                ),
                const Divider(height: 1),
                _buildThemeOption(
                  context,
                  ref,
                  ThemeMode.light,
                  'Açık Tema',
                  'Her zaman açık tema kullan',
                  Icons.light_mode,
                  themeMode,
                ),
                const Divider(height: 1),
                _buildThemeOption(
                  context,
                  ref,
                  ThemeMode.dark,
                  'Koyu Tema',
                  'Her zaman koyu tema kullan',
                  Icons.dark_mode,
                  themeMode,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Yardım & Destek
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.help_outline,
                        color: AppTheme.primaryOrange,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Yardım & Destek',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                _buildActionItem(
                  context,
                  'İletişim',
                  'E-posta veya WhatsApp ile iletişime geçin',
                  Icons.contact_support,
                  () => _showContactDialog(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Hesap İşlemleri
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person_off,
                        color: Colors.red,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Hesap İşlemleri',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                _buildActionItem(
                  context,
                  'Hesabımı Sil',
                  'Hesabınızı ve tüm verilerinizi kalıcı olarak silin',
                  Icons.delete_forever,
                  () => _showDeleteAccountDialog(context),
                  isDestructive: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref,
    ThemeMode mode,
    String title,
    String subtitle,
    IconData icon,
    ThemeMode currentMode,
  ) {
    final isSelected = currentMode == mode;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppTheme.primaryOrange : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? AppTheme.primaryOrange : null,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: AppTheme.primaryOrange,
            )
          : null,
      onTap: () {
        ref.read(themeModeProvider.notifier).setThemeMode(mode);
      },
    );
  }

  Widget _buildActionItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    final color = isDestructive ? Colors.red : null;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title, 
        style: TextStyle(
          color: color,
          fontWeight: isDestructive ? FontWeight.w600 : null,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: color),
      onTap: onTap,
    );
  }

  Future<void> _showDeleteAccountDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hesabı Sil?'),
        content: const Text(
          'Hesabınızı silmek istediğinize emin misiniz? Bu işlem geri alınamaz ve tüm verileriniz kalıcı olarak silinecektir.\n\nDevam etmek için e-posta adresinize bir doğrulama kodu gönderilecektir.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Devam Et'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        // Show loading
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(child: CircularProgressIndicator()),
        );

        await AccountService.instance.initiateDeleteAccount();

        // Hide loading
        if (context.mounted) Navigator.of(context).pop();

        if (context.mounted) {
          _showVerificationDialog(context);
        }
      } catch (e) {
        // Hide loading
        if (context.mounted) Navigator.of(context).pop();
        
        if (context.mounted) {
          SnackBarService.showSnackBar(
            context: context,
            snackBar: SnackBar(content: Text('Hata: $e')),
          );
        }
      }
    }
  }

  void _showVerificationDialog(BuildContext context) {
    final codeController = TextEditingController();
    bool isLoading = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Doğrulama Kodu'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('E-posta adresinize gönderilen kodu girin:'),
              const SizedBox(height: 16),
              TextField(
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: 'Kod',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            if (!isLoading)
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('İptal'),
              ),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      if (codeController.text.isEmpty) return;

                      setState(() => isLoading = true);

                      try {
                        await AccountService.instance.verifyAndDeleteAccount(
                          codeController.text.trim(),
                        );
                        
                        if (context.mounted) {
                          Navigator.of(context).pop(); // Close dialog
                          
                          // Navigate to login
                          NavigationService.navigateToLogin();
                          
                          SnackBarService.showSnackBar(
                            context: context,
                            snackBar: const SnackBar(
                              content: Text('Hesabınız başarıyla silindi.'),
                            ),
                          );
                        }
                      } catch (e) {
                         setState(() => isLoading = false);
                         if (context.mounted) {
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text('Hata: $e')),
                           );
                         }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Hesabı Sil'),
            ),
          ],
        ),
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('İletişim'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Bizimle iletişime geçmek için bir yöntem seçin:'),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.of(dialogContext).pop();
                _launchEmail(context);
              },
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.email, color: AppTheme.primaryOrange),
                title: const Text('E-posta'),
                subtitle: const Text('innovacraftstudio@hotmail.com'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.of(dialogContext).pop();
                _launchWhatsApp(context);
              },
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.chat, color: Colors.green),
                title: const Text('WhatsApp'),
                subtitle: const Text('+90 530 643 55 79'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('İptal'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchEmail(BuildContext context) async {
    final email = 'innovacraftstudio@hotmail.com';
    final uri = Uri(
      scheme: 'mailto',
      path: email,
    );
    
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (context.mounted) {
          SnackBarService.showSnackBar(
            context: context,
            snackBar: const SnackBar(
              content: Text('E-posta uygulaması açılamadı'),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: SnackBar(content: Text('Hata: $e')),
        );
      }
    }
  }

  Future<void> _launchWhatsApp(BuildContext context) async {
    final phone = '905306435579'; // +90 530 643 55 79 without + and spaces
    final uri = Uri.parse('https://wa.me/$phone');
    
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          SnackBarService.showSnackBar(
            context: context,
            snackBar: const SnackBar(
              content: Text('WhatsApp açılamadı'),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: SnackBar(content: Text('Hata: $e')),
        );
      }
    }
  }
}
