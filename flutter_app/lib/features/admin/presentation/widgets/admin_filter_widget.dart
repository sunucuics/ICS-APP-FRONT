import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/admin_filter_model.dart';
import '../../../../core/services/snackbar_service.dart';

class AdminFilterWidget extends ConsumerStatefulWidget {
  final FilterState initialFilter;
  final Function(FilterState) onFilterChanged;
  final List<FilterOption>? categoryOptions;
  final List<FilterOption>? statusOptions;
  final List<FilterOption>? userOptions;

  const AdminFilterWidget({
    super.key,
    required this.initialFilter,
    required this.onFilterChanged,
    this.categoryOptions,
    this.statusOptions,
    this.userOptions,
  });

  @override
  ConsumerState<AdminFilterWidget> createState() => _AdminFilterWidgetState();
}

class _AdminFilterWidgetState extends ConsumerState<AdminFilterWidget> {
  late FilterState _currentFilter;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentFilter = widget.initialFilter;
    _searchController.text = _currentFilter.searchQuery ?? '';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.filter_list, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Filtreler',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: _clearFilters,
                  child: const Text('Temizle'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSearchField(),
            const SizedBox(height: 16),
            _buildDateFilter(),
            const SizedBox(height: 16),
            if (widget.categoryOptions != null) ...[
              _buildMultiSelectFilter('Kategoriler', widget.categoryOptions!),
              const SizedBox(height: 16),
            ],
            if (widget.statusOptions != null) ...[
              _buildMultiSelectFilter('Durumlar', widget.statusOptions!),
              const SizedBox(height: 16),
            ],
            if (widget.userOptions != null) ...[
              _buildMultiSelectFilter('Kullanıcılar', widget.userOptions!),
              const SizedBox(height: 16),
            ],
            _buildSortOptions(),
            const SizedBox(height: 16),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextFormField(
      controller: _searchController,
      decoration: InputDecoration(
        labelText: 'Arama',
        hintText: 'Arama yapın...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  _updateFilter();
                },
              )
            : null,
        border: const OutlineInputBorder(),
      ),
      onChanged: (value) {
        _currentFilter =
            _currentFilter.copyWith(searchQuery: value.isEmpty ? null : value);
        _updateFilter();
      },
    );
  }

  Widget _buildDateFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tarih Aralığı',
            style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _currentFilter.dateFilter?.preset ?? 'all',
                decoration: const InputDecoration(
                  labelText: 'Periyot',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'all', child: Text('Tümü')),
                  DropdownMenuItem(value: 'today', child: Text('Bugün')),
                  DropdownMenuItem(value: 'week', child: Text('Bu Hafta')),
                  DropdownMenuItem(value: 'month', child: Text('Bu Ay')),
                  DropdownMenuItem(value: 'year', child: Text('Bu Yıl')),
                  DropdownMenuItem(value: 'custom', child: Text('Özel Tarih')),
                ],
                onChanged: (value) {
                  if (value == 'custom') {
                    _selectCustomDateRange();
                  } else {
                    _currentFilter = _currentFilter.copyWith(
                      dateFilter: DateFilter(preset: value),
                    );
                    _updateFilter();
                  }
                },
              ),
            ),
            const SizedBox(width: 16),
            if (_currentFilter.dateFilter?.preset == 'custom')
              Expanded(
                child: TextButton.icon(
                  onPressed: _selectCustomDateRange,
                  icon: const Icon(Icons.calendar_today),
                  label: Text(_getDateRangeText()),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildMultiSelectFilter(String title, List<FilterOption> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = _currentFilter.multiSelectFilters.any((filter) =>
                filter.field == title.toLowerCase() &&
                filter.selectedValues.contains(option.value));

            return FilterChip(
              label: Text('${option.label} (${option.count})'),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  final existingFilterIndex = _currentFilter.multiSelectFilters
                      .indexWhere(
                          (filter) => filter.field == title.toLowerCase());

                  if (existingFilterIndex != -1) {
                    final existingFilter =
                        _currentFilter.multiSelectFilters[existingFilterIndex];
                    final newSelectedValues =
                        List<String>.from(existingFilter.selectedValues);

                    if (selected) {
                      newSelectedValues.add(option.value);
                    } else {
                      newSelectedValues.remove(option.value);
                    }

                    final newFilters = List<MultiSelectFilter>.from(
                        _currentFilter.multiSelectFilters);
                    if (newSelectedValues.isEmpty) {
                      newFilters.removeAt(existingFilterIndex);
                    } else {
                      newFilters[existingFilterIndex] = existingFilter.copyWith(
                          selectedValues: newSelectedValues);
                    }

                    _currentFilter =
                        _currentFilter.copyWith(multiSelectFilters: newFilters);
                  } else if (selected) {
                    final newFilter = MultiSelectFilter(
                      field: title.toLowerCase(),
                      selectedValues: [option.value],
                      options: options,
                    );
                    _currentFilter = _currentFilter.copyWith(
                      multiSelectFilters: [
                        ..._currentFilter.multiSelectFilters,
                        newFilter
                      ],
                    );
                  }
                });
                _updateFilter();
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSortOptions() {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _currentFilter.sortBy ?? 'created_at',
            decoration: const InputDecoration(
              labelText: 'Sıralama',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                  value: 'created_at', child: Text('Oluşturma Tarihi')),
              DropdownMenuItem(
                  value: 'updated_at', child: Text('Güncelleme Tarihi')),
              DropdownMenuItem(value: 'name', child: Text('İsim')),
              DropdownMenuItem(value: 'price', child: Text('Fiyat')),
              DropdownMenuItem(value: 'status', child: Text('Durum')),
            ],
            onChanged: (value) {
              _currentFilter =
                  _currentFilter.copyWith(sortBy: value ?? 'created_at');
              _updateFilter();
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _currentFilter.sortOrder,
            decoration: const InputDecoration(
              labelText: 'Sıra',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'asc', child: Text('Artan')),
              DropdownMenuItem(value: 'desc', child: Text('Azalan')),
            ],
            onChanged: (value) {
              _currentFilter =
                  _currentFilter.copyWith(sortOrder: value ?? 'asc');
              _updateFilter();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _saveFilter,
            icon: const Icon(Icons.save),
            label: const Text('Filtreyi Kaydet'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _exportFilteredData,
            icon: const Icon(Icons.download),
            label: const Text('Dışa Aktar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  String _getDateRangeText() {
    final dateFilter = _currentFilter.dateFilter;
    if (dateFilter?.startDate != null && dateFilter?.endDate != null) {
      return '${dateFilter!.startDate!.day}/${dateFilter.startDate!.month} - ${dateFilter.endDate!.day}/${dateFilter.endDate!.month}';
    }
    return 'Tarih Seç';
  }

  Future<void> _selectCustomDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _currentFilter.dateFilter?.startDate != null &&
              _currentFilter.dateFilter?.endDate != null
          ? DateTimeRange(
              start: _currentFilter.dateFilter!.startDate!,
              end: _currentFilter.dateFilter!.endDate!)
          : null,
    );

    if (picked != null) {
      setState(() {
        _currentFilter = _currentFilter.copyWith(
          dateFilter: DateFilter(
            startDate: picked.start,
            endDate: picked.end,
            preset: 'custom',
          ),
        );
      });
      _updateFilter();
    }
  }

  void _clearFilters() {
    setState(() {
      _currentFilter = const FilterState();
      _searchController.clear();
    });
    _updateFilter();
  }

  void _updateFilter() {
    widget.onFilterChanged(_currentFilter);
  }

  void _saveFilter() {
    showDialog(
      context: context,
      builder: (context) => _SaveFilterDialog(
        onSave: (name, description) {
          // Filtreyi kaydetme işlemi
          SnackBarService.showSnackBar(context: context, snackBar: 
            SnackBar(
              content: Text('Filtre "$name" kaydedildi'),
              backgroundColor: Colors.green,
            ),
          );
        },
      ),
    );
  }

  void _exportFilteredData() {
    showDialog(
      context: context,
      builder: (context) => _ExportDialog(
        onExport: (format, includeHeaders) {
          // Dışa aktarma işlemi
          SnackBarService.showSnackBar(context: context, snackBar: 
            SnackBar(
              content: Text('$format formatında dışa aktarılıyor...'),
              backgroundColor: Colors.blue,
            ),
          );
        },
      ),
    );
  }
}

class _SaveFilterDialog extends StatefulWidget {
  final Function(String name, String description) onSave;

  const _SaveFilterDialog({required this.onSave});

  @override
  State<_SaveFilterDialog> createState() => _SaveFilterDialogState();
}

class _SaveFilterDialogState extends State<_SaveFilterDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filtreyi Kaydet'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Filtre Adı',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Açıklama',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_nameController.text.isNotEmpty) {
              widget.onSave(_nameController.text, _descriptionController.text);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}

class _ExportDialog extends StatefulWidget {
  final Function(String format, bool includeHeaders) onExport;

  const _ExportDialog({required this.onExport});

  @override
  State<_ExportDialog> createState() => _ExportDialogState();
}

class _ExportDialogState extends State<_ExportDialog> {
  String _selectedFormat = 'csv';
  bool _includeHeaders = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dışa Aktar'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: _selectedFormat,
            decoration: const InputDecoration(
              labelText: 'Format',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'csv', child: Text('CSV')),
              DropdownMenuItem(value: 'excel', child: Text('Excel')),
              DropdownMenuItem(value: 'pdf', child: Text('PDF')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedFormat = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            title: const Text('Başlıkları Dahil Et'),
            value: _includeHeaders,
            onChanged: (value) {
              setState(() {
                _includeHeaders = value!;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onExport(_selectedFormat, _includeHeaders);
            Navigator.of(context).pop();
          },
          child: const Text('Dışa Aktar'),
        ),
      ],
    );
  }
}
