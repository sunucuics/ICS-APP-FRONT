import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/comments_providers.dart';
import '../widgets/comment_form.dart';
import '../widgets/comments_list.dart';
import '../widgets/rating_summary.dart';

class CommentsPage extends ConsumerStatefulWidget {
  final String targetId;
  final String targetType; // 'product' or 'service'
  final String targetTitle;
  final bool isAdmin;

  const CommentsPage({
    super.key,
    required this.targetId,
    required this.targetType,
    required this.targetTitle,
    this.isAdmin = false,
  });

  @override
  ConsumerState<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends ConsumerState<CommentsPage> {
  @override
  void initState() {
    super.initState();
    // Provider'ı initState'de değiştirmek yerine, build tamamlandıktan sonra çağır
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadComments();
    });
  }

  Future<void> _loadComments() async {
    final commentsProvider = ref.read(commentsProviderNotifier);

    if (widget.targetType == 'product') {
      await commentsProvider.fetchProductComments(productId: widget.targetId);
    } else if (widget.targetType == 'service') {
      await commentsProvider.fetchServiceComments(serviceId: widget.targetId);
    }
  }

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
                color: Theme.of(context).colorScheme.outline.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
            // Comment form
            Expanded(
              child: CommentForm(
                targetId: widget.targetId,
                targetType: widget.targetType,
                onCommentAdded: () {
                  Navigator.of(context).pop();
                  _loadComments();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.targetTitle} - Yorumlar'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _loadComments,
            icon: const Icon(Icons.refresh),
            tooltip: 'Yenile',
          ),
        ],
      ),
      body: Column(
        children: [
          // Rating summary
          RatingSummary(
            targetId: widget.targetId,
            targetType: widget.targetType,
          ),

          // Add comment button (only for non-admin users)
          if (!widget.isAdmin)
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _showCommentForm,
                  icon: const Icon(Icons.add_comment),
                  label: const Text('Yorum Ekle'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),

          // Comments list
          Expanded(
            child: CommentsList(
              targetId: widget.targetId,
              targetType: widget.targetType,
              showDeleteButtons: widget.isAdmin,
              onRefresh: _loadComments,
            ),
          ),
        ],
      ),
    );
  }
}
