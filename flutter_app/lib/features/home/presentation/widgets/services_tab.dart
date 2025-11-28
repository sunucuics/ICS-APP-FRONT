import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../services/providers/services_provider.dart';
import '../../../services/presentation/pages/service_detail_page.dart';
import '../../../auth/providers/anonymous_auth_provider.dart' as anonymous;
import '../../../auth/providers/auth_provider.dart';
import '../../../auth/presentation/pages/guest_upgrade_page.dart';
import '../../../../core/models/service_model.dart';
import '../../../appointments/presentation/pages/appointment_booking_page.dart';
import '../../../../core/theme/app_theme.dart';

class ServicesTab extends ConsumerWidget {
  const ServicesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(servicesProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Hizmetler',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [],
      ),
      body: servicesAsync.when(
        data: (services) {
          if (services.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.work_off, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Henüz hizmet yok',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Yakında hizmetler eklenecek',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return _ServiceCard(service: service);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Hizmetler yüklenemedi',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(servicesProvider),
                child: const Text('Tekrar Dene'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceCard extends ConsumerWidget {
  final Service service;

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.black, // Black background
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryNavy, // Thick blue border
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryNavy.withOpacity(0.8), // Stronger blue glow
            blurRadius: 25,
            offset: const Offset(0, 8),
            spreadRadius: 3,
          ),
          BoxShadow(
            color: AppTheme.primaryNavy.withOpacity(0.6),
            blurRadius: 50,
            offset: const Offset(0, 0),
            spreadRadius: 1,
          ),
          BoxShadow(
            color: AppTheme.primaryNavy.withOpacity(0.3),
            blurRadius: 80,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ServiceDetailPage(service: service),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Service image or icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: service.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: service.image!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.white.withOpacity(0.1),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.white.withOpacity(0.1),
                              child: const Icon(
                                Icons.work,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.work,
                          color: Colors.white,
                          size: 32,
                        ),
                ),
                const SizedBox(width: 16),
                // Service details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              service.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700, // Bolder text
                                fontSize: 17, // Slightly larger
                                color: Colors.white,
                                letterSpacing: 0.5, // Better letter spacing
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (service.isUpcoming)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white
                                    .withOpacity(0.25), // Slightly more opaque
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'Yakında',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11, // Slightly larger
                                  fontWeight: FontWeight.w600, // Bolder
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors
                              .white, // Changed from white70 to white for better readability
                          fontSize: 14, // Slightly larger
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.3,
                          height: 1.4, // Better line height
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ServiceDetailPage(service: service),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                    0xFF64B5F6), // More harmonious light blue
                                foregroundColor: Colors.white,
                                elevation: 4,
                                shadowColor:
                                    const Color(0xFF64B5F6).withOpacity(0.4),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10), // Slightly more padding
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Detaylar',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: service.isUpcoming
                                  ? null
                                  : () {
                                      _bookAppointment(context, ref, service);
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: service.isUpcoming
                                    ? Colors.grey[300]
                                    : const Color(
                                        0xFF1976D2), // More harmonious blue
                                foregroundColor: service.isUpcoming
                                    ? Colors.grey[600]
                                    : Colors.white,
                                elevation: 4,
                                shadowColor: service.isUpcoming
                                    ? Colors.grey.withOpacity(0.3)
                                    : const Color(0xFF1976D2).withOpacity(0.4),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10), // Slightly more padding
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                service.isUpcoming ? 'Yakında' : 'Randevu Al',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _bookAppointment(BuildContext context, WidgetRef ref, Service service) {
    // Check if user is authenticated (either registered or anonymous)
    final authState = ref.read(authProvider);
    final isAnonymous = ref.read(anonymous.isAnonymousProvider);

    // If registered user is authenticated, allow booking
    // If only anonymous user is authenticated, show upgrade dialog
    final isActuallyAnonymous = !authState.isAuthenticated && isAnonymous;

    if (isActuallyAnonymous) {
      _showGuestUpgradeDialog(context);
      return;
    }

    // Navigate to appointment booking page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentBookingPage(service: service),
      ),
    );
  }

  void _showGuestUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hesap Gerekli'),
          content: const Text(
            'Randevu almak için hesap oluşturmanız gerekiyor. '
            'Hesap oluşturmak ister misiniz?',
          ),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryNavy,
                foregroundColor: Colors.white,
                elevation: 3,
                shadowColor: AppTheme.primaryNavy.withOpacity(0.3),
              ),
              child: const Text('Hesap Oluştur'),
            ),
          ],
        );
      },
    );
  }
}
