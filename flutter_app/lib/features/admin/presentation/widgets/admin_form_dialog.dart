import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/snackbar_service.dart';

class AdminFormDialog extends StatefulWidget {
  final String title;
  final List<AdminFormField> fields;
  final Map<String, String>? initialData;
  final Future<void> Function(Map<String, String>) onSave;
  final Map<String, List<String> Function(Map<String, String>)>? dynamicDropdowns;

  const AdminFormDialog({
    super.key,
    required this.title,
    required this.fields,
    required this.onSave,
    this.initialData,
    this.dynamicDropdowns,
  });

  @override
  State<AdminFormDialog> createState() => _AdminFormDialogState();
}

class _AdminFormDialogState extends State<AdminFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, List<File>> _selectedImages = {};
  bool _isLoading = false;

  bool _isFormValid() {
    // Check all required text fields
    for (final field in widget.fields) {
      if (field.isRequired && !field.isImageField) {
        final controller = _controllers[field.label];
        if (controller == null || controller.text.trim().isEmpty) {
          return false;
        }
      }
    }

    // Check all required image fields
    // Edit modunda mevcut görseller varsa (initialData'dan gelen URL),
    // yeni görsel seçilmemiş olsa bile geçerli say
    for (final field in widget.fields) {
      if (field.isImageField && field.isRequired) {
        final images = _selectedImages[field.label];
        final hasExistingImage =
            widget.initialData?[field.label]?.isNotEmpty == true;
        if ((images == null || images.isEmpty) && !hasExistingImage) {
          return false;
        }
      }
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    for (final field in widget.fields) {
      _controllers[field.label] = TextEditingController(
        text: widget.initialData?[field.label] ?? '',
      );
      if (field.isImageField) {
        _selectedImages[field.label] = [];
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
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
                      widget.title,
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
                    children: widget.fields.map((field) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildFormField(field),
                      );
                    }).toList(),
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
                    onPressed:
                        _isLoading ? null : () => Navigator.of(context).pop(),
                    child: const Text('İptal'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: (_isLoading || !_isFormValid()) ? null : _handleSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey,
                      disabledForegroundColor: Colors.grey[300],
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
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

  Widget _buildFormField(AdminFormField field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field.label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        if (field.isRequired)
          const Text(
            ' *',
            style: TextStyle(color: Colors.red),
          ),
        const SizedBox(height: 8),
        if (field.dropdownOptions != null)
          _buildDropdownField(field)
        else if (field.isDateField)
          _buildDateField(field)
        else if (field.isImageField)
          _buildImageField(field)
        else
          TextFormField(
            controller: _controllers[field.label],
            maxLines: field.maxLines ?? 1,
            keyboardType: field.keyboardType,
            inputFormatters: field.inputFormatters,
            decoration: InputDecoration(
              hintText: field.hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppTheme.primaryNavy),
              ),
            ),
            validator: (value) {
              if (field.isRequired && (value == null || value.trim().isEmpty)) {
                return '${field.label} zorunludur';
              }
              return null;
            },
            onChanged: (value) {
              // Trigger rebuild to update save button state
              setState(() {});
            },
          ),
      ],
    );
  }

  Widget _buildDropdownField(AdminFormField field) {
    // Get current field values for dynamic dropdowns
    final currentValues = <String, String>{};
    for (final entry in _controllers.entries) {
      currentValues[entry.key] = entry.value.text;
    }

    // Get dropdown options (static or dynamic)
    List<String> options;
    if (widget.dynamicDropdowns != null &&
        widget.dynamicDropdowns!.containsKey(field.label)) {
      options = widget.dynamicDropdowns![field.label]!(currentValues);
    } else {
      options = field.dropdownOptions ?? [];
    }

    return DropdownButtonFormField<String>(
      value: _controllers[field.label]!.text.isNotEmpty &&
              options.contains(_controllers[field.label]!.text)
          ? _controllers[field.label]!.text
          : null,
      isExpanded: true,
      decoration: InputDecoration(
        hintText: field.hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppTheme.primaryNavy),
        ),
      ),
      items: options.map((String option) {
        // Extract display name from "ID - Name" format
        String displayText = option;
        if (option.contains(' - ')) {
          displayText = option.split(' - ').skip(1).join(' - ');
        }
        
        return DropdownMenuItem<String>(
          value: option,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              displayText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        );
      }).toList(),
      selectedItemBuilder: (BuildContext context) {
        return options.map((String option) {
          // Extract display name from "ID - Name" format
          String displayText = option;
          if (option.contains(' - ')) {
            displayText = option.split(' - ').skip(1).join(' - ');
          }
          
          return SizedBox(
            width: double.infinity,
            child: Text(
              displayText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          );
        }).toList();
      },
      onChanged: (String? newValue) {
        setState(() {
          _controllers[field.label]!.text = newValue ?? '';
          // Clear dependent fields if needed
          if (widget.dynamicDropdowns != null) {
            // If this field affects other dynamic dropdowns, clear them
            for (final entry in widget.dynamicDropdowns!.entries) {
              if (entry.key != field.label) {
                // Check if this field is a dependency
                final dependentOptions = entry.value(currentValues);
                final currentValue = _controllers[entry.key]!.text;
                if (!dependentOptions.contains(currentValue)) {
                  _controllers[entry.key]!.text = '';
                }
              }
            }
          }
        });
        // Trigger rebuild to update save button state
        setState(() {});
      },
      validator: (value) {
        if (field.isRequired && (value == null || value.trim().isEmpty)) {
          return '${field.label} zorunludur';
        }
        return null;
      },
    );
  }

  Widget _buildDateField(AdminFormField field) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          locale: const Locale('tr', 'TR'),
        );
        if (picked != null) {
          setState(() {
            _controllers[field.label]!.text =
                '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[600]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                _controllers[field.label]!.text.isEmpty
                    ? field.hint
                    : _controllers[field.label]!.text,
                style: TextStyle(
                  color: _controllers[field.label]!.text.isEmpty
                      ? Colors.grey[400]
                      : Colors.white,
                ),
              ),
            ),
            const Icon(Icons.calendar_today, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate required image fields
    // Edit modunda mevcut görseller varsa yeni seçim zorunlu değil
    for (final field in widget.fields) {
      if (field.isImageField && field.isRequired) {
        final hasExistingImage =
            widget.initialData?[field.label]?.isNotEmpty == true;
        if ((_selectedImages[field.label] == null || _selectedImages[field.label]!.isEmpty) && !hasExistingImage) {
          if (mounted) {
            SnackBarService.showSnackBar(context: context, snackBar:
              SnackBar(
                content: Text('${field.label} zorunludur'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }
      }
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final data = <String, String>{};
      for (final entry in _controllers.entries) {
        data[entry.key] = entry.value.text.trim();
      }

      // Add selected images to data
      for (final entry in _selectedImages.entries) {
        if (entry.value.isNotEmpty) {
          // For multiple images, store as comma-separated paths
          // For single image, store as single path
          final field = widget.fields.firstWhere(
            (f) => f.label == entry.key && f.isImageField,
            orElse: () => widget.fields.firstWhere((f) => f.label == entry.key),
          );
          if (field.allowMultipleImages) {
            data['${entry.key}_files'] = entry.value.map((f) => f.path).join(',');
          } else {
            data['${entry.key}_file'] = entry.value.first.path;
          }
        }
      }

      await widget.onSave(data);

      if (mounted) {
        Navigator.of(context).pop();
        SnackBarService.showSnackBar(context: context, snackBar: 
          const SnackBar(
            content: Text('Başarıyla kaydedildi'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
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

  Widget _buildImageField(AdminFormField field) {
    final selectedImages = _selectedImages[field.label] ?? [];
    final allowMultiple = field.allowMultipleImages;
    final maxImages = allowMultiple ? 5 : 1;

    return Column(
      children: [
        // Selected images grid
        if (selectedImages.isNotEmpty)
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxHeight: 200),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: selectedImages.asMap().entries.map((entry) {
                  final index = entry.key;
                  final image = entry.value;
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            image,
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.close, size: 16, color: Colors.white),
                              onPressed: () => _removeImage(field.label, index),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),
                        ),
                        if (allowMultiple && index == 0)
                          Positioned(
                            bottom: 4,
                            left: 4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryNavy,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Ana',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        else
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image,
                    size: 40,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    allowMultiple 
                        ? 'Görsel seçmek için tıklayın (Maks: $maxImages)'
                        : 'Görsel seçmek için tıklayın',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: selectedImages.length >= maxImages
                    ? null
                    : () => _pickImage(field.label, ImageSource.gallery, allowMultiple),
                icon: const Icon(Icons.photo_library, size: 18),
                label: Text(allowMultiple ? 'Galeri (${selectedImages.length}/$maxImages)' : 'Galeri'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryNavy,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: selectedImages.length >= maxImages
                    ? null
                    : () => _pickImage(field.label, ImageSource.camera, allowMultiple),
                icon: const Icon(Icons.camera_alt, size: 18),
                label: const Text('Kamera'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryNavy,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ],
        ),
        if (allowMultiple && selectedImages.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'İlk görsel ana görsel olarak kullanılacaktır',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _pickImage(String fieldLabel, ImageSource source, bool allowMultiple) async {
    try {
      final ImagePicker picker = ImagePicker();
      
      if (allowMultiple && source == ImageSource.gallery) {
        // Pick multiple images (only from gallery)
        final List<XFile> images = await picker.pickMultiImage(
          maxWidth: 1024,
          maxHeight: 1024,
          imageQuality: 80,
        );

        if (images.isNotEmpty) {
          setState(() {
            final currentImages = _selectedImages[fieldLabel] ?? [];
            final newImages = images.map((x) => File(x.path)).toList();
            final totalImages = currentImages.length + newImages.length;
            final maxImages = 5;
            
            if (totalImages > maxImages) {
              // Limit to maxImages
              final remainingSlots = maxImages - currentImages.length;
              if (remainingSlots > 0) {
                _selectedImages[fieldLabel] = [
                  ...currentImages,
                  ...newImages.take(remainingSlots),
                ];
                if (mounted) {
                  SnackBarService.showSnackBar(context: context, snackBar: 
                    SnackBar(
                      content: Text('Maksimum $maxImages görsel seçebilirsiniz. İlk $remainingSlots görsel eklendi.'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              } else {
                if (mounted) {
                  SnackBarService.showSnackBar(context: context, snackBar: 
                    SnackBar(
                      content: Text('Maksimum $maxImages görsel seçebilirsiniz.'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              }
            } else {
              _selectedImages[fieldLabel] = [...currentImages, ...newImages];
            }
          });
        }
      } else {
        // Pick single image (camera or single image mode)
        final XFile? image = await picker.pickImage(
          source: source,
          maxWidth: 1024,
          maxHeight: 1024,
          imageQuality: 80,
        );

        if (image != null) {
          setState(() {
            if (allowMultiple) {
              // Add to existing images if multiple mode
              final currentImages = _selectedImages[fieldLabel] ?? [];
              if (currentImages.length < 5) {
                _selectedImages[fieldLabel] = [...currentImages, File(image.path)];
              } else {
                if (mounted) {
                  SnackBarService.showSnackBar(context: context, snackBar: 
                    const SnackBar(
                      content: Text('Maksimum 5 görsel seçebilirsiniz.'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              }
            } else {
              // Replace existing image if single mode
              _selectedImages[fieldLabel] = [File(image.path)];
            }
          });
        }
      }
    } catch (e) {
      if (mounted) {
        SnackBarService.showSnackBar(context: context, snackBar: 
          SnackBar(
            content: Text('Görsel seçilirken hata oluştu: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _removeImage(String fieldLabel, int index) {
    setState(() {
      final images = _selectedImages[fieldLabel] ?? [];
      if (index >= 0 && index < images.length) {
        images.removeAt(index);
        _selectedImages[fieldLabel] = images;
      }
    });
    // Trigger rebuild to update save button state
    setState(() {});
  }
}

class AdminFormField {
  final String label;
  final String hint;
  final bool isRequired;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final List<String>? dropdownOptions;
  final bool isDateField;
  final bool isImageField;
  final bool allowMultipleImages;

  const AdminFormField({
    required this.label,
    required this.hint,
    this.isRequired = false,
    this.maxLines,
    this.keyboardType,
    this.inputFormatters,
    this.dropdownOptions,
    this.isDateField = false,
    this.isImageField = false,
    this.allowMultipleImages = false,
  });
}
