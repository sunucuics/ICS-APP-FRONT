import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/comments_providers.dart';

class RatingSummary extends ConsumerWidget {
  final String targetId;
  final String targetType; // 'product' or 'service'

  const RatingSummary({
    super.key,
    required this.targetId,
    required this.targetType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsProvider = ref.watch(commentsProviderNotifier);
    final comments = targetType == 'product'
        ? commentsProvider.getProductComments(targetId)
        : commentsProvider.getServiceComments(targetId);

    if (comments.isEmpty) {
      return const SizedBox.shrink();
    }

    final averageRating = targetType == 'product'
        ? commentsProvider.getProductAverageRating(targetId)
        : commentsProvider.getServiceAverageRating(targetId);

    final ratingDistribution = targetType == 'product'
        ? commentsProvider.getProductRatingDistribution(targetId)
        : commentsProvider.getServiceRatingDistribution(targetId);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Değerlendirmeler',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // Overall rating
            Row(
              children: [
                // Average rating number
                Text(
                  averageRating.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const SizedBox(width: 4),
                // Stars
                _buildStars(averageRating),
                const SizedBox(width: 4),
                // Total count
                Expanded(
                  child: Text(
                    '(${comments.length} değerlendirme)',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Rating breakdown
            _buildRatingBreakdown(ratingDistribution, comments.length),
          ],
        ),
      ),
    );
  }

  Widget _buildStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starRating = index + 1;
        if (rating >= starRating) {
          return const Icon(Icons.star, color: Colors.amber, size: 20);
        } else if (rating > index) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 20);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 20);
        }
      }),
    );
  }

  Widget _buildRatingBreakdown(Map<int, int> distribution, int totalComments) {
    return Column(
      children: List.generate(5, (index) {
        final rating = 5 - index; // Show 5 stars first
        final count = distribution[rating] ?? 0;
        final percentage =
            totalComments > 0 ? (count / totalComments) * 100 : 0.0;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              // Star icon
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 16,
              ),
              const SizedBox(width: 4),
              // Rating number
              SizedBox(
                width: 16,
                child: Text(
                  '$rating',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 4),
              // Progress bar
              Expanded(
                child: LinearProgressIndicator(
                  value: percentage / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.amber.withOpacity(0.7),
                  ),
                  minHeight: 8,
                ),
              ),
              const SizedBox(width: 4),
              // Count
              SizedBox(
                width: 24,
                child: Text(
                  '$count',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
