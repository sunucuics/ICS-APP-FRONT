import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/appointment_model.dart';
import '../../../../core/models/service_model.dart';
import '../../providers/appointments_provider.dart';
import '../widgets/monthly_calendar_widget.dart';

class AppointmentBookingPage extends ConsumerStatefulWidget {
  final Service service;

  const AppointmentBookingPage({
    super.key,
    required this.service,
  });

  @override
  ConsumerState<AppointmentBookingPage> createState() =>
      _AppointmentBookingPageState();
}

class _AppointmentBookingPageState
    extends ConsumerState<AppointmentBookingPage> {
  DateTime? _selectedDate;
  String? _selectedTime;
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(appointmentBookingProvider);

    // Listen to booking state changes
    ref.listen(appointmentBookingProvider, (previous, next) {
      next.whenOrNull(
        data: (appointment) {
          if (appointment != null) {
            _showSuccessDialog();
          }
        },
        error: (error, stack) {
          _showErrorDialog(error.toString());
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.service.title} - Randevu Al'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Servis bilgileri
            _buildServiceInfo(),
            const SizedBox(height: 24),

            // Tarih seçimi
            _buildDateSelection(),
            const SizedBox(height: 24),

            // Seçilen tarih ve saat bilgisi
            if (_selectedDate != null && _selectedTime != null)
              _buildSelectedDateTime(),

            const SizedBox(height: 24),

            // Notlar
            _buildNotesSection(),
            const SizedBox(height: 32),

            // Randevu alma butonu
            _buildBookingButton(bookingState),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: widget.service.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.service.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.work,
                          color: Theme.of(context).primaryColor,
                          size: 32,
                        ),
                      ),
                    )
                  : Icon(
                      Icons.work,
                      color: Theme.of(context).primaryColor,
                      size: 32,
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.service.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.service.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tarih ve Saat Seçin',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        MonthlyCalendarWidget(
          serviceId: widget.service.id,
          onTimeSlotSelected: (date, startTime) {
            setState(() {
              _selectedDate = date;
              _selectedTime = startTime;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSelectedDateTime() {
    return Card(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seçilen Randevu',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_selectedDate!.day} ${_getMonthName(_selectedDate!.month)} ${_selectedDate!.year} - $_selectedTime',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedDate = null;
                  _selectedTime = null;
                });
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ek Notlar (İsteğe Bağlı)',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _notesController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Randevu ile ilgili özel isteklerinizi yazabilirsiniz...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildBookingButton(AsyncValue<Appointment?> bookingState) {
    final canBook = _selectedDate != null && _selectedTime != null;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: canBook && !bookingState.isLoading ? _bookAppointment : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: bookingState.when(
          data: (appointment) => appointment != null
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Randevu Talebi Oluşturuldu',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : const Text(
                  'Randevu Talebi Oluştur',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
          loading: () => const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Randevu Oluşturuluyor...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          error: (error, stack) => const Text(
            'Randevu Oluştur',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _bookAppointment() {
    if (_selectedDate == null || _selectedTime == null) return;

    // Create DateTime in local timezone, then convert to UTC for backend
    final startDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      int.parse(_selectedTime!.split(':')[0]),
      int.parse(_selectedTime!.split(':')[1]),
    );

    ref.read(appointmentBookingProvider.notifier).bookAppointmentForm(
          serviceId: widget.service.id,
          start: startDateTime,
        );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Randevu Talebi Oluşturuldu!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: const Text(
          '🎉 Randevu talebiniz başarıyla oluşturuldu!\n\n'
          'Admin onayından sonra randevunuz aktif olacaktır. '
          'Randevularım sayfasından durumunuzu takip edebilirsiniz.',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Reset provider state
              ref.read(appointmentBookingProvider.notifier).reset();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Harika!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Randevu Alınamadı',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          '❌ Randevu talebi oluşturulurken bir hata oluştu:\n\n$error\n\nLütfen tekrar deneyin.',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Reset provider state
              ref.read(appointmentBookingProvider.notifier).reset();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Tamam',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    final monthNames = [
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık'
    ];
    return monthNames[month - 1];
  }
}
