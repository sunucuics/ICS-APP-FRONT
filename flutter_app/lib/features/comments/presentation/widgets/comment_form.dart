import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/comments_providers.dart';
import '../../../../core/models/comment_model.dart';

class CommentForm extends ConsumerStatefulWidget {
  final String targetId;
  final String targetType; // 'product' or 'service'
  final VoidCallback? onCommentAdded;

  const CommentForm({
    super.key,
    required this.targetId,
    required this.targetType,
    this.onCommentAdded,
  });

  @override
  ConsumerState<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends ConsumerState<CommentForm> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  int _selectedRating = 5;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Yorum Ekle',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),

              // Rating section
              Text(
                'Puanınız:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              _buildRatingSelector(),
              const SizedBox(height: 16),

              // Comment content
              Text(
                'Yorumunuz:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _contentController,
                maxLines: 4,
                maxLength: 500,
                decoration: InputDecoration(
                  hintText: 'Ürün/hizmet hakkında düşüncelerinizi paylaşın...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Yorum içeriği boş olamaz';
                  }
                  if (value.trim().length < 10) {
                    return 'Yorum en az 10 karakter olmalıdır';
                  }
                  if (value.length > 500) {
                    return 'Yorum en fazla 500 karakter olabilir';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitComment,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Yorumu Gönder',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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

  Widget _buildRatingSelector() {
    return Row(
      children: List.generate(5, (index) {
        final rating = index + 1;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedRating = rating;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            child: Icon(
              rating <= _selectedRating ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: 32,
            ),
          ),
        );
      }),
    );
  }

  Future<void> _submitComment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final commentsProvider = ref.read(commentsProviderNotifier);

      Comment? newComment;
      if (widget.targetType == 'product') {
        newComment = await commentsProvider.addProductComment(
          productId: widget.targetId,
          content: _contentController.text.trim(),
          rating: _selectedRating,
        );
      } else if (widget.targetType == 'service') {
        newComment = await commentsProvider.addServiceComment(
          serviceId: widget.targetId,
          content: _contentController.text.trim(),
          rating: _selectedRating,
        );
      }

      if (newComment != null) {
        // Clear form
        _contentController.clear();
        _selectedRating = 5;

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Yorumunuz başarıyla eklendi!'),
              backgroundColor: Colors.green,
            ),
          );
        }

        // Notify parent
        widget.onCommentAdded?.call();
      } else {
        // Show error message
        if (mounted) {
          final error = commentsProvider
              .getError('add_${widget.targetType}_${widget.targetId}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error ?? 'Yorum eklenirken bir hata oluştu'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hata: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }
}
