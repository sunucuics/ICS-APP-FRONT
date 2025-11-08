import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/comments_providers.dart';
import 'comment_card.dart';
import '../../../../core/services/snackbar_service.dart';

class CommentsList extends ConsumerStatefulWidget {
  final String targetId;
  final String targetType; // 'product' or 'service'
  final bool showDeleteButtons;
  final VoidCallback? onRefresh;

  const CommentsList({
    super.key,
    required this.targetId,
    required this.targetType,
    this.showDeleteButtons = false,
    this.onRefresh,
  });

  @override
  ConsumerState<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends ConsumerState<CommentsList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Provider'ı initState'de değiştirmek yerine, build tamamlandıktan sonra çağır
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadComments();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadComments() async {
    final commentsProvider = ref.read(commentsProviderNotifier);

    if (widget.targetType == 'product') {
      await commentsProvider.fetchProductComments(productId: widget.targetId);
    } else if (widget.targetType == 'service') {
      await commentsProvider.fetchServiceComments(serviceId: widget.targetId);
    }
  }

  Future<void> _refreshComments() async {
    final commentsProvider = ref.read(commentsProviderNotifier);

    if (widget.targetType == 'product') {
      await commentsProvider.refreshProductComments(widget.targetId);
    } else if (widget.targetType == 'service') {
      await commentsProvider.refreshServiceComments(widget.targetId);
    }

    widget.onRefresh?.call();
  }

  Future<void> _deleteComment(String commentId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yorumu Sil'),
        content: const Text('Bu yorumu silmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final commentsProvider = ref.read(commentsProviderNotifier);
        await commentsProvider.deleteComment(commentId: commentId);

        if (mounted) {
          SnackBarService.showSnackBar(context: context, snackBar: 
            const SnackBar(
              content: Text('Yorum başarıyla silindi'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          SnackBarService.showSnackBar(context: context, snackBar: 
            SnackBar(
              content: Text('Yorum silinirken hata oluştu: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final commentsProvider = ref.watch(commentsProviderNotifier);
    final comments = widget.targetType == 'product'
        ? commentsProvider.getProductComments(widget.targetId)
        : commentsProvider.getServiceComments(widget.targetId);

    final isLoading =
        commentsProvider.isLoading('${widget.targetType}_${widget.targetId}');
    final error =
        commentsProvider.getError('${widget.targetType}_${widget.targetId}');

    if (isLoading && comments.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (error != null && comments.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'Yorumlar yüklenirken hata oluştu',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                error,
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadComments,
                child: const Text('Tekrar Dene'),
              ),
            ],
          ),
        ),
      );
    }

    if (comments.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.comment_outlined,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'Henüz yorum yok',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'İlk yorumu siz yapın!',
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshComments,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final comment = comments[index];
          return CommentCard(
            comment: comment,
            showDeleteButton: widget.showDeleteButtons,
            onDelete: widget.showDeleteButtons
                ? () => _deleteComment(comment.id)
                : null,
          );
        },
      ),
    );
  }
}
