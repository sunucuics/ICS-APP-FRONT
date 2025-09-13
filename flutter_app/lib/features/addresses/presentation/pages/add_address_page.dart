import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/address_model.dart';
import '../../providers/addresses_provider.dart';

class AddAddressPage extends ConsumerStatefulWidget {
  const AddAddressPage({super.key});

  @override
  ConsumerState<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends ConsumerState<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _streetController = TextEditingController();
  final _buildingNoController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _floorController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _noteController = TextEditingController();

  String? _selectedCity;
  String? _selectedDistrict;
  AddressLabel _selectedLabel = AddressLabel.home;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    _buildingNoController.dispose();
    _apartmentController.dispose();
    _floorController.dispose();
    _neighborhoodController.dispose();
    _zipCodeController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Adres Ekle'),
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

              // City and District
              Row(
                children: [
                  Expanded(
                    child: _buildCityDropdown(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDistrictDropdown(),
                  ),
                ],
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
              _selectedDistrict = null; // Reset district when city changes
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

  Widget _buildDistrictDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'İlçe',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedDistrict,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'İlçe seçin',
          ),
          items: _getDistrictsForCity().map((district) {
            return DropdownMenuItem(
              value: district,
              child: Text(district),
            );
          }).toList(),
          onChanged: _selectedCity != null
              ? (value) {
                  setState(() {
                    _selectedDistrict = value;
                  });
                }
              : null,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'İlçe seçimi gerekli';
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

  List<String> _getDistrictsForCity() {
    // This is a simplified list. In a real app, you'd fetch this from an API
    // or use a comprehensive database of Turkish districts
    switch (_selectedCity) {
      case 'İstanbul':
        return [
          'Adalar',
          'Arnavutköy',
          'Ataşehir',
          'Avcılar',
          'Bağcılar',
          'Bahçelievler',
          'Bakırköy',
          'Başakşehir',
          'Bayrampaşa',
          'Beşiktaş',
          'Beykoz',
          'Beylikdüzü',
          'Beyoğlu',
          'Büyükçekmece',
          'Çatalca',
          'Çekmeköy',
          'Esenler',
          'Esenyurt',
          'Eyüpsultan',
          'Fatih',
          'Gaziosmanpaşa',
          'Güngören',
          'Kadıköy',
          'Kağıthane',
          'Kartal',
          'Küçükçekmece',
          'Maltepe',
          'Pendik',
          'Sancaktepe',
          'Sarıyer',
          'Silivri',
          'Sultanbeyli',
          'Sultangazi',
          'Şile',
          'Şişli',
          'Tuzla',
          'Ümraniye',
          'Üsküdar',
          'Zeytinburnu'
        ];
      case 'Ankara':
        return [
          'Akyurt',
          'Altındağ',
          'Ayaş',
          'Bala',
          'Beypazarı',
          'Çamlıdere',
          'Çankaya',
          'Çubuk',
          'Elmadağ',
          'Etimesgut',
          'Evren',
          'Gölbaşı',
          'Güdül',
          'Haymana',
          'Kalecik',
          'Kazan',
          'Keçiören',
          'Kızılcahamam',
          'Mamak',
          'Nallıhan',
          'Polatlı',
          'Pursaklar',
          'Sincan',
          'Şereflikoçhisar',
          'Yenimahalle'
        ];
      case 'İzmir':
        return [
          'Aliağa',
          'Balçova',
          'Bayındır',
          'Bayraklı',
          'Bergama',
          'Beydağ',
          'Bornova',
          'Buca',
          'Çeşme',
          'Çiğli',
          'Dikili',
          'Foça',
          'Gaziemir',
          'Güzelbahçe',
          'Karabağlar',
          'Karaburun',
          'Karşıyaka',
          'Kemalpaşa',
          'Kınık',
          'Kiraz',
          'Konak',
          'Menderes',
          'Menemen',
          'Narlıdere',
          'Ödemiş',
          'Seferihisar',
          'Selçuk',
          'Tire',
          'Torbalı',
          'Urla'
        ];
      default:
        return ['Merkez']; // Default district for other cities
    }
  }

  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedCity == null || _selectedDistrict == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen il ve ilçe seçin'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final address = AddressCreateRequest(
        name: _nameController.text.trim(),
        label: _selectedLabel.displayName,
        city: _selectedCity!,
        district: _selectedDistrict!,
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

      await ref.read(addressesProvider.notifier).addAddress(address);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Adres başarıyla eklendi'),
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
