import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/address_model.dart';
import '../../providers/addresses_provider.dart';

class EditAddressPage extends ConsumerStatefulWidget {
  final Address address;

  const EditAddressPage({super.key, required this.address});

  @override
  ConsumerState<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends ConsumerState<EditAddressPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _streetController;
  late final TextEditingController _buildingNoController;
  late final TextEditingController _apartmentController;
  late final TextEditingController _floorController;
  late final TextEditingController _neighborhoodController;
  late final TextEditingController _districtController;
  late final TextEditingController _zipCodeController;
  late final TextEditingController _noteController;

  late String? _selectedCity;
  late AddressLabel _selectedLabel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.address.name ?? '');
    _streetController =
        TextEditingController(text: widget.address.street ?? '');
    _buildingNoController =
        TextEditingController(text: widget.address.buildingNo ?? '');
    _apartmentController =
        TextEditingController(text: widget.address.apartment ?? '');
    _floorController = TextEditingController(text: widget.address.floor ?? '');
    _neighborhoodController =
        TextEditingController(text: widget.address.neighborhood ?? '');
    _districtController =
        TextEditingController(text: widget.address.district ?? '');
    _zipCodeController =
        TextEditingController(text: widget.address.zipCode ?? '');
    _noteController = TextEditingController(text: widget.address.note ?? '');

    _selectedCity = widget.address.city;
    _selectedLabel = AddressLabel.fromString(widget.address.label ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    _buildingNoController.dispose();
    _apartmentController.dispose();
    _floorController.dispose();
    _neighborhoodController.dispose();
    _districtController.dispose();
    _zipCodeController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adresi Düzenle'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveAddress,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Kaydet'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Address Label
              _buildLabelSelector(),
              const SizedBox(height: 16),

              // Address Name
              _buildTextField(
                controller: _nameController,
                label: 'Adres Adı',
                hint: 'Örn: Ev, İş, Anne Evi',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Adres adı gerekli';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // City
              _buildCityDropdown(),
              const SizedBox(height: 16),

              // District
              _buildTextField(
                controller: _districtController,
                label: 'İlçe',
                hint: 'İlçe adını girin',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'İlçe gerekli';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Neighborhood
              _buildTextField(
                controller: _neighborhoodController,
                label: 'Mahalle',
                hint: 'Mahalle adını girin',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mahalle gerekli';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Street
              _buildTextField(
                controller: _streetController,
                label: 'Sokak/Cadde',
                hint: 'Sokak veya cadde adını girin',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Sokak/Cadde gerekli';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Building No and Apartment
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _buildingNoController,
                      label: 'Bina No',
                      hint: 'Bina numarası',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bina no gerekli';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      controller: _apartmentController,
                      label: 'Daire No',
                      hint: 'Daire numarası',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Floor
              _buildTextField(
                controller: _floorController,
                label: 'Kat',
                hint: 'Kat numarası',
              ),
              const SizedBox(height: 16),

              // Zip Code
              _buildTextField(
                controller: _zipCodeController,
                label: 'Posta Kodu',
                hint: 'Posta kodu',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Note
              _buildTextField(
                controller: _noteController,
                label: 'Not',
                hint: 'Ek notlar (opsiyonel)',
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabelSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Adres Türü',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        Row(
          children: AddressLabel.values.map((label) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(label.displayName),
                  selected: _selectedLabel == label,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedLabel = label;
                      });
                    }
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCityDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'İl',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCity,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'İl seçin',
          ),
          items: TurkishCities.cities.map((city) {
            return DropdownMenuItem(
              value: city,
              child: Text(city),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedCity = value;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'İl seçimi gerekli';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hint,
          ),
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
        ),
      ],
    );
  }

  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedCity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen il seçin'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final address = AddressUpdateRequest(
        name: _nameController.text.trim(),
        label: _selectedLabel.displayName,
        city: _selectedCity!,
        district: _districtController.text.trim(),
        neighborhood: _neighborhoodController.text.trim(),
        street: _streetController.text.trim(),
        buildingNo: _buildingNoController.text.trim(),
        apartment: _apartmentController.text.trim().isEmpty
            ? null
            : _apartmentController.text.trim(),
        floor: _floorController.text.trim().isEmpty
            ? null
            : _floorController.text.trim(),
        zipCode: _zipCodeController.text.trim().isEmpty
            ? null
            : _zipCodeController.text.trim(),
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
      );

      await ref
          .read(addressesProvider.notifier)
          .updateAddress(widget.address.id!, address);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Adres başarıyla güncellendi'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hata: $error'),
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
