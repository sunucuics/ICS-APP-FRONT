import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../auth/providers/anonymous_auth_provider.dart' as anonymous;
import '../../../auth/presentation/pages/guest_upgrade_page.dart';
import '../../../../core/theme/app_theme.dart';

/// Shows logout confirmation dialog
void showLogoutDialog(BuildContext context, WidgetRef ref) {
  final isActuallyAnonymous = !ref.read(authProvider).isAuthenticated &&
      ref.read(anonymous.isAnonymousProvider);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Çıkış Yap'),
        content: Text(isActuallyAnonymous
            ? 'Misafir oturumundan çıkış yapmak istediğinize emin misiniz?'
            : 'Hesabınızdan çıkış yapmak istediğinize emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();

              if (isActuallyAnonymous) {
                // Sign out from anonymous auth
                await ref
                    .read(anonymous.anonymousAuthProvider.notifier)
                    .signOut();
              } else {
                // Sign out from registered auth - navigation will be handled by state listener
                await ref.read(authProvider.notifier).logout();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorRed,
              foregroundColor: Colors.white,
            ),
            child: const Text('Çıkış Yap'),
          ),
        ],
      );
    },
  );
}

/// Shows guest upgrade dialog
void showGuestUpgradeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Hesap Oluşturun'),
        content: const Text(
            'Bu özelliği kullanmak için bir hesap oluşturmanız gerekiyor.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const GuestUpgradePage(),
                ),
              );
            },
            child: const Text('Hesap Oluştur'),
          ),
        ],
      );
    },
  );
}

/// Shows about dialog with app information
void showProfileAboutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/ics_logo.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Innova Craft Studio',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '1.0.0',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Hayal Et, Tasarla ve Üret',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Akıllı ev çözümleri, el yapımı ürünler ve profesyonel hizmetler tek çatı altında.',
            style: TextStyle(fontSize: 14),
          ),
        ],
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
