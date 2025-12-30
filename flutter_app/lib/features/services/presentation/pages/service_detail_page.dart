import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../comments/presentation/widgets/rating_summary.dart';
import '../../../comments/presentation/widgets/comments_list.dart';
import '../../../comments/presentation/widgets/comment_form.dart';
import '../../../comments/presentation/pages/comments_page.dart';
import '../../../auth/providers/anonymous_auth_provider.dart' as anonymous;
import '../../../auth/providers/auth_provider.dart';
import '../../../auth/presentation/pages/guest_upgrade_page.dart';
import '../../../appointments/presentation/pages/appointment_booking_page.dart';
import '../../../../core/models/service_model.dart';
import '../../../../core/theme/app_theme.dart';

class ServiceDetailPage extends ConsumerStatefulWidget {
  final Service service;

  const ServiceDetailPage({super.key, required this.service});

  @override
  ConsumerState<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends ConsumerState<ServiceDetailPage> {
  void _showCommentForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'Yorum Ekle',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Comment form
            Expanded(
              child: CommentForm(
                targetId: widget.service.id,
                targetType: 'service',
                onCommentAdded: () {
                  Navigator.of(context).pop();
                  // Refresh comments if needed
                  setState(() {});
                },
              ),
            ),
          ],
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

  @override
  Widget build(BuildContext context) {
    final service = widget.service;

    return Scaffold(
      appBar: AppBar(
        title: Text(service.title),
        actions: [],
      ),
      body: Column(
        children: [
          // Service Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service Images Gallery
                  Container(
                    height: 300,
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: service.images.isNotEmpty
                        ? Stack(
                            children: [
                              PageView.builder(
                                itemCount: service.images.length,
                                itemBuilder: (context, index) {
                                  return CachedNetworkImage(
                                    imageUrl: service.images[index],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant,
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        size: 64,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // Page indicator for multiple images
                              if (service.images.length > 1)
                                Positioned(
                                  bottom: 16,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      service.images.length,
                                      (index) => Container(
                                        width: 8,
                                        height: 8,
                                        margin:
                                            const EdgeInsets.symmetric(
                                                horizontal: 4),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          )
                        : Container(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            child: const Icon(Icons.business_center, size: 64),
                          ),
                  ),

                  // Service Info
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Category
                        Text(
                          service.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryNavy.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Hizmet',
                            style: TextStyle(
                              color: AppTheme.primaryNavy,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Status
                        Row(
                          children: [
                            Icon(
                              service.isUpcoming
                                  ? Icons.access_time
                                  : Icons.check_circle,
                              color: service.isUpcoming
                                  ? AppTheme.primaryNavy
                                  : Colors.green,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              service.isUpcoming
                                  ? 'Yakında başlayacak'
                                  : 'Aktif hizmet',
                              style: TextStyle(
                                color: service.isUpcoming
                                    ? AppTheme.primaryNavy
                                    : Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        if (service.isUpcoming) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryNavy.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.access_time,
                                    color: AppTheme.primaryNavy, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'Yakında gelecek',
                                  style: TextStyle(
                                    color: AppTheme.primaryNavy,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),

                        // Description
                        Text(
                          'Hizmet Açıklaması',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          service.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 24),

                        // Rating Summary
                        RatingSummary(
                          targetId: service.id,
                          targetType: 'service',
                        ),

                        // Comments Section
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Yorumlar',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Row(
                              children: [
                                // Add comment button
                                ElevatedButton.icon(
                                  onPressed: _showCommentForm,
                                  icon: const Icon(Icons.add_comment, size: 16),
                                  label: const Text('Yorum Ekle'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    textStyle: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // View all comments button
                                TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => CommentsPage(
                                          targetId: service.id,
                                          targetType: 'service',
                                          targetTitle: service.title,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.comment_outlined,
                                      size: 16),
                                  label: const Text('Tümünü Gör'),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Comments Preview (show first 3 comments)
                        SizedBox(
                          height: 300,
                          child: CommentsList(
                            targetId: service.id,
                            targetType: 'service',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Action Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                  top:
                      BorderSide(color: Theme.of(context).colorScheme.outline)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Service Status
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Durum',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      service.isUpcoming ? 'Yakında' : 'Aktif',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: service.isUpcoming
                            ? AppTheme.primaryNavy
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),

                // Action Button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: service.isUpcoming
                        ? null
                        : () {
                            _bookAppointment(context, ref, service);
                          },
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      service.isUpcoming ? 'Yakında Başlayacak' : 'Randevu Al',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryNavy,
                      foregroundColor: Colors.white,
                      elevation: 3,
                      shadowColor: AppTheme.primaryNavy.withOpacity(0.3),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
