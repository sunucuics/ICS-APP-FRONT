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
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryNavy,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.work,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text('Hizmetler'),
          ],
        ),
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
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 15,
      shadowColor: AppTheme.serviceCardBlue.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppTheme.serviceCardBlue.withOpacity(0.3),
          width: 1,
        ),
      ),
      color: AppTheme.serviceCardBlue,
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
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white,
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
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Yakında',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
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
                        color: Colors.white70,
                        fontSize: 13,
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
                              backgroundColor: Colors.white,
                              foregroundColor: AppTheme.serviceCardBlue,
                              elevation: 3,
                              shadowColor: Colors.white.withOpacity(0.3),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            child: const Text(
                              'Detaylar',
                              style: TextStyle(fontSize: 12),
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
                                  : Colors.white,
                              foregroundColor: service.isUpcoming
                                  ? Colors.grey[600]
                                  : AppTheme.serviceCardBlue,
                              elevation: 3,
                              shadowColor: service.isUpcoming
                                  ? Colors.grey.withOpacity(0.3)
                                  : Colors.white.withOpacity(0.3),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            child: Text(
                              service.isUpcoming ? 'Yakında' : 'Randevu Al',
                              style: const TextStyle(fontSize: 12),
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
    );
  }

  void _showServiceDetail(
      BuildContext context, WidgetRef ref, Service service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Service image
              if (service.image != null) ...[
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.surfaceVariant,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: service.image!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: Icon(
                          Icons.work,
                          color: AppTheme.primaryNavy,
                          size: 64,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
              // Service title
              Row(
                children: [
                  Expanded(
                    child: Text(
                      service.title,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  if (service.isUpcoming)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryNavy.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'Yakında',
                        style: TextStyle(
                          color: AppTheme.primaryNavy,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              // Service description
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Text(
                    service.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Action button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: service.isUpcoming
                      ? null
                      : () {
                          Navigator.pop(context);
                          _bookAppointment(context, ref, service);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryNavy,
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shadowColor: AppTheme.primaryNavy.withOpacity(0.3),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    service.isUpcoming
                        ? 'Bu Hizmet Yakında Aktif Olacak'
                        : 'Randevu Al',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
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
