import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../comments/presentation/widgets/rating_summary.dart';
import '../../../comments/presentation/widgets/comments_list.dart';
import '../../../comments/presentation/widgets/comment_form.dart';
import '../../../comments/presentation/pages/comments_page.dart';
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
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    'Yorum Ekle',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
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

  @override
  Widget build(BuildContext context) {
    final service = widget.service;

    return Scaffold(
      appBar: AppBar(
        title: Text(service.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Favoriler özelliği yakında eklenecek')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Paylaşım özelliği yakında eklenecek')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Service Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service Image
                  Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.grey[100],
                    child: service.image != null && service.image!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: service.image!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.image_not_supported,
                                  size: 64),
                            ),
                          )
                        : Container(
                            color: Colors.grey[200],
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
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Hizmet',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
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
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
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
                    const Text(
                      'Durum',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
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
                            // Navigate to appointment booking or contact
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Randevu sistemi yakında eklenecek'),
                              ),
                            );
                          },
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      service.isUpcoming ? 'Yakında Başlayacak' : 'Randevu Al',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryNavy,
                      foregroundColor: Colors.white,
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
