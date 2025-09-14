import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/appointment_model.dart';
import '../../providers/appointments_provider.dart';

class MonthlyCalendarWidget extends ConsumerStatefulWidget {
  final String serviceId;
  final Function(DateTime date, String startTime)? onTimeSlotSelected;

  const MonthlyCalendarWidget({
    super.key,
    required this.serviceId,
    this.onTimeSlotSelected,
  });

  @override
  ConsumerState<MonthlyCalendarWidget> createState() =>
      _MonthlyCalendarWidgetState();
}

class _MonthlyCalendarWidgetState extends ConsumerState<MonthlyCalendarWidget> {
  late DateTime _currentDate;
  late int _currentYear;
  late int _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _currentYear = _currentDate.year;
    _currentMonth = _currentDate.month;
  }

  void _previousMonth() {
    setState(() {
      if (_currentMonth == 1) {
        _currentMonth = 12;
        _currentYear--;
      } else {
        _currentMonth--;
      }
    });
  }

  void _nextMonth() {
    setState(() {
      if (_currentMonth == 12) {
        _currentMonth = 1;
        _currentYear++;
      } else {
        _currentMonth++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final monthlyAvailability = ref.watch(monthlyAvailabilityProvider(
      MonthlyAvailabilityParams(
        serviceId: widget.serviceId,
        year: _currentYear,
        month: _currentMonth,
      ),
    ));

    return Column(
      children: [
        // Ay navigasyonu
        _buildMonthNavigation(),
        const SizedBox(height: 16),
        // Takvim
        monthlyAvailability.when(
          data: (availability) => _buildCalendar(availability),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => _buildErrorWidget(error),
        ),
      ],
    );
  }

  Widget _buildMonthNavigation() {
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _previousMonth,
            icon: const Icon(Icons.chevron_left),
          ),
          Text(
            '${monthNames[_currentMonth - 1]} $_currentYear',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          IconButton(
            onPressed: _nextMonth,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(MonthlyAvailability availability) {
    final days = availability.days;
    final today = DateTime.now();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Hafta günleri başlığı
          _buildWeekdayHeaders(),
          // Takvim günleri
          ...List.generate(
            (days.length / 7).ceil(),
            (weekIndex) => _buildWeekRow(days, weekIndex, today),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeaders() {
    final weekdays = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: weekdays
            .map((day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildWeekRow(
      List<DayAvailability> days, int weekIndex, DateTime today) {
    final startIndex = weekIndex * 7;
    final endIndex = (startIndex + 7).clamp(0, days.length);
    final weekDays = days.sublist(startIndex, endIndex);

    return Row(
      children: List.generate(7, (dayIndex) {
        if (dayIndex < weekDays.length) {
          return Expanded(child: _buildDayCell(weekDays[dayIndex], today));
        } else {
          return const Expanded(child: SizedBox());
        }
      }),
    );
  }

  Widget _buildDayCell(DayAvailability day, DateTime today) {
    final isToday = day.date.year == today.year &&
        day.date.month == today.month &&
        day.date.day == today.day;

    final isPast = day.date.isBefore(today) && !isToday;
    final hasAvailableSlots =
        day.isWorkingDay && day.timeSlots.any((slot) => slot.isAvailable);

    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        color: isToday
            ? Theme.of(context).primaryColor.withOpacity(0.1)
            : Colors.white,
      ),
      child: InkWell(
        onTap: hasAvailableSlots && !isPast ? () => _showTimeSlots(day) : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${day.date.day}',
              style: TextStyle(
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                color: isPast
                    ? Colors.grey[400]
                    : isToday
                        ? Theme.of(context).primaryColor
                        : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            if (day.isWorkingDay) ...[
              if (hasAvailableSlots)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                )
              else
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
            ] else
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(Object error) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Takvim yüklenemedi',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.invalidate(monthlyAvailabilityProvider(
                MonthlyAvailabilityParams(
                  serviceId: widget.serviceId,
                  year: _currentYear,
                  month: _currentMonth,
                ),
              ));
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  void _showTimeSlots(DayAvailability day) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Başlık
              Text(
                '${day.date.day} ${_getMonthName(day.date.month)} ${day.date.year}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              // Müsait saatler
              Expanded(
                child: day.timeSlots.isEmpty
                    ? Center(
                        child: Text(
                          'Bu gün için müsait saat bulunmuyor',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    : GridView.builder(
                        controller: scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: day.timeSlots.length,
                        itemBuilder: (context, index) {
                          final slot = day.timeSlots[index];
                          return _buildTimeSlotButton(slot, day.date);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSlotButton(TimeSlot slot, DateTime date) {
    final isAvailable = slot.isAvailable;

    return ElevatedButton(
      onPressed: isAvailable
          ? () {
              Navigator.pop(context);
              widget.onTimeSlotSelected?.call(date, slot.startTime);
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isAvailable ? Theme.of(context).primaryColor : Colors.grey[300],
        foregroundColor: isAvailable ? Colors.white : Colors.grey[600],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        slot.startTime,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
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
