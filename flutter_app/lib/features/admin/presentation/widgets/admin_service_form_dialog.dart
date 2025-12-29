import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../core/models/service_model.dart';
import '../../../../core/services/snackbar_service.dart';
import '../../../../core/theme/app_theme.dart';

class AdminServiceFormDialog extends StatefulWidget {
  final Service? service;
  final Future<void> Function(Map<String, dynamic>) onSave;

  const AdminServiceFormDialog({
    super.key,
    this.service,
    required this.onSave,
  });

  @override
  State<AdminServiceFormDialog> createState() => _AdminServiceFormDialogState();
}

class _AdminServiceFormDialogState extends State<AdminServiceFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  // 3 image slots: each can have a File (new upload) or String (existing URL)
  final List<File?> _newImages = [null, null, null];
  final List<String?> _existingImageUrls = [null, null, null];
  final List<bool> _removeFlags = [false, false, false];
  
  String _isUpcoming = 'keep'; // 'keep', 'yes', 'no'
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.service != null) {
      _titleController.text = widget.service!.title;
      _descriptionController.text = widget.service!.description;
      
      // Load existing images
      final images = widget.service!.images;
      for (int i = 0; i < 3 && i < images.length; i++) {
        _existingImageUrls[i] = images[i];
      }
      
      // Set is_upcoming dropdown
      if (widget.service!.isUpcoming) {
        _isUpcoming = 'yes';
      } else {
        _isUpcoming = 'no';
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.primaryNavy,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.service == null ? 'Yeni Hizmet Ekle' : 'Hizmet Düzenle',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),

            // Form
            Flexible(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      _buildTextField(
                        controller: _titleController,
                        label: 'Hizmet Adı',
                        hint: 'Hizmet adını girin',
                        isRequired: true,
                      ),
                      const SizedBox(height: 16),

                      // Description
                      _buildTextField(
                        controller: _descriptionController,
                        label: 'Açıklama',
                        hint: 'Hizmet açıklaması',
                        isRequired: false,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),

                      // is_upcoming dropdown
                      _buildUpcomingDropdown(),
                      const SizedBox(height: 24),

                      // 3 Image Slots
                      const Text(
                        'Görseller (Maksimum 3)',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildImageSlot(0, 'Görsel 1'),
                      const SizedBox(height: 12),
                      _buildImageSlot(1, 'Görsel 2'),
                      const SizedBox(height: 12),
                      _buildImageSlot(2, 'Görsel 3'),
                    ],
                  ),
                ),
              ),
            ),

            // Actions
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                    child: const Text('İptal'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryNavy,
                      foregroundColor: Colors.white,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text('Kaydet'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isRequired,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: (value) {
            if (isRequired && (value == null || value.trim().isEmpty)) {
              return '$label zorunludur';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildUpcomingDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Yakında mı?',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _isUpcoming,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: 'Durum seçin',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: 'keep',
              child: Text('Dokunma'),
            ),
            DropdownMenuItem(
              value: 'yes',
              child: Text('Evet'),
            ),
            DropdownMenuItem(
              value: 'no',
              child: Text('Hayır'),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _isUpcoming = value;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildImageSlot(int index, String label) {
    final hasNewImage = _newImages[index] != null;
    final hasExistingImage = _existingImageUrls[index] != null && !_removeFlags[index];
    final hasImage = hasNewImage || hasExistingImage;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          
          // Image preview or placeholder
          if (hasImage)
            Container(
              height: 100,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: hasNewImage
                    ? Image.file(
                        _newImages[index]!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Image.network(
                        _existingImageUrls[index]!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.broken_image, size: 40),
                          );
                        },
                      ),
              ),
            )
          else
            Container(
              height: 100,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 40, color: Colors.grey),
              ),
            ),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : () => _pickImage(index),
                  icon: const Icon(Icons.add_photo_alternate, size: 18),
                  label: Text(hasImage ? 'Değiştir' : 'Görsel Seç'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[50],
                    foregroundColor: Colors.blue[700],
                    elevation: 0,
                  ),
                ),
              ),
              if (hasImage && widget.service != null) ...[
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : () => _removeImage(index),
                  icon: const Icon(Icons.delete, size: 18),
                  label: const Text('Sil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[50],
                    foregroundColor: Colors.red[700],
                    elevation: 0,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(int index) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _newImages[index] = File(image.path);
          // Clear remove flag if image is being replaced
          _removeFlags[index] = false;
        });
      }
    } catch (e) {
      if (mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: SnackBar(
            content: Text('Görsel seçilirken hata oluştu: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      if (_newImages[index] != null) {
        // Remove new image
        _newImages[index] = null;
      } else if (_existingImageUrls[index] != null) {
        // Mark existing image for removal
        _removeFlags[index] = true;
      }
    });
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final data = <String, dynamic>{
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'is_upcoming': _isUpcoming,
      };

      // Add image slots (image1, image2, image3)
      for (int i = 0; i < 3; i++) {
        if (_newImages[i] != null) {
          data['image${i + 1}'] = _newImages[i]!.path;
        } else if (_removeFlags[i] && widget.service != null) {
          // Only set remove flag if it's an update and we're removing existing image
          data['remove_image${i + 1}'] = true;
        }
      }

      await widget.onSave(data);

      if (mounted) {
        Navigator.of(context).pop();
        SnackBarService.showSnackBar(
          context: context,
          snackBar: const SnackBar(
            content: Text('Başarıyla kaydedildi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        SnackBarService.showSnackBar(
          context: context,
          snackBar: SnackBar(
            content: Text('Hata: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

