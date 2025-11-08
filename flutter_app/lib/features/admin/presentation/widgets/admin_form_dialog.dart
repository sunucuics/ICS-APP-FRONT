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

  const AdminFormDialog({
    super.key,
    required this.title,
    required this.fields,
    required this.onSave,
    this.initialData,
  });

  @override
  State<AdminFormDialog> createState() => _AdminFormDialogState();
}

class _AdminFormDialogState extends State<AdminFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, File?> _selectedImages = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    for (final field in widget.fields) {
      _controllers[field.label] = TextEditingController(
        text: widget.initialData?[field.label] ?? '',
      );
      if (field.isImageField) {
        _selectedImages[field.label] = null;
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
                color: Colors.grey[50],
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
                    onPressed: _isLoading ? null : _handleSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      foregroundColor: Colors.white,
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
          ),
      ],
    );
  }

  Widget _buildDropdownField(AdminFormField field) {
    return DropdownButtonFormField<String>(
      value: _controllers[field.label]!.text.isNotEmpty
          ? _controllers[field.label]!.text
          : null,
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
      items: field.dropdownOptions!.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (String? newValue) {
        _controllers[field.label]!.text = newValue ?? '';
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
          _controllers[field.label]!.text =
              '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
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
                      ? Colors.grey[600]
                      : Colors.black,
                ),
              ),
            ),
            const Icon(Icons.calendar_today, color: AppTheme.primaryNavy),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
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
        if (entry.value != null) {
          data['${entry.key}_file'] = entry.value!.path;
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
    final selectedImage = _selectedImages[field.label];

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: selectedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    selectedImage,
                    fit: BoxFit.cover,
                  ),
                )
              : Center(
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
                        'Görsel seçmek için tıklayın',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
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
                onPressed: () => _pickImage(field.label, ImageSource.gallery),
                icon: const Icon(Icons.photo_library, size: 18),
                label: const Text('Galeri'),
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
                onPressed: () => _pickImage(field.label, ImageSource.camera),
                icon: const Icon(Icons.camera_alt, size: 18),
                label: const Text('Kamera'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryNavy,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
            if (selectedImage != null) ...[
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => _removeImage(field.label),
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Görseli kaldır',
              ),
            ],
          ],
        ),
      ],
    );
  }

  Future<void> _pickImage(String fieldLabel, ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImages[fieldLabel] = File(image.path);
        });
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

  void _removeImage(String fieldLabel) {
    setState(() {
      _selectedImages[fieldLabel] = null;
    });
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
  });
}
