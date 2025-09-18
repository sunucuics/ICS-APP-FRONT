import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/appointments_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/models/appointment_model.dart';

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
    final busySlots = ref.watch(busySlotsProvider(
      BusySlotsParams(
        serviceId: widget.serviceId,
        days: 90, // 3 ay
      ),
    ));

    return Column(
      children: [
        // Ay navigasyonu
        _buildMonthNavigation(),
        const SizedBox(height: 16),
        // Takvim
        busySlots.when(
          data: (busySlotsList) => _buildCalendarFromBusySlots(busySlotsList),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryOrange.withOpacity(0.1),
            AppTheme.secondaryOrange.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryOrange.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primaryOrange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: _previousMonth,
              icon: const Icon(
                Icons.chevron_left,
                color: AppTheme.primaryOrange,
                size: 24,
              ),
            ),
          ),
          Text(
            '${monthNames[_currentMonth - 1]} $_currentYear',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primaryOrange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: _nextMonth,
              icon: const Icon(
                Icons.chevron_right,
                color: AppTheme.primaryOrange,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarFromBusySlots(List<BusySlot> busySlotsList) {
    final today = DateTime.now();

    // Mevcut ayın günlerini oluştur
    final daysInMonth = DateTime(_currentYear, _currentMonth + 1, 0).day;
    final firstDayOfMonth = DateTime(_currentYear, _currentMonth, 1);
    final firstWeekday = firstDayOfMonth.weekday; // 1 = Pazartesi

    final days = <DateTime>[];

    // Önceki ayın son günlerini ekle (haftanın başını doldur)
    for (int i = firstWeekday - 1; i > 0; i--) {
      days.add(firstDayOfMonth.subtract(Duration(days: i)));
    }

    // Bu ayın günlerini ekle
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(_currentYear, _currentMonth, i));
    }

    // Sonraki ayın ilk günlerini ekle (haftanın sonunu doldur)
    while (days.length % 7 != 0) {
      days.add(days.last.add(const Duration(days: 1)));
    }

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.secondaryBlack,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryOrange.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Hafta günleri başlığı
          _buildWeekdayHeaders(),
          // Takvim günleri
          ...List.generate(
            (days.length / 7).ceil(),
            (weekIndex) => _buildWeekRowFromBusySlots(
                days, weekIndex, today, busySlotsList),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeaders() {
    final weekdays = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryOrange.withOpacity(0.1),
            AppTheme.secondaryOrange.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: weekdays
            .map((day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppTheme.primaryOrange,
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildWeekRowFromBusySlots(List<DateTime> days, int weekIndex,
      DateTime today, List<BusySlot> busySlots) {
    final startIndex = weekIndex * 7;
    final endIndex = (startIndex + 7).clamp(0, days.length);
    final weekDays = days.sublist(startIndex, endIndex);

    return Row(
      children: List.generate(7, (dayIndex) {
        if (dayIndex < weekDays.length) {
          return Expanded(
              child: _buildDayCellFromBusySlots(
                  weekDays[dayIndex], today, busySlots));
        } else {
          return const Expanded(child: SizedBox());
        }
      }),
    );
  }

  Widget _buildDayCellFromBusySlots(
      DateTime date, DateTime today, List<BusySlot> busySlots) {
    final isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;

    final isPast = date.isBefore(today) && !isToday;
    final isCurrentMonth =
        date.month == _currentMonth && date.year == _currentYear;

    // Bu tarih için dolu slotları bul
    final dateString =
        date.toIso8601String().split('T')[0]; // YYYY-MM-DD format
    final dayBusySlots =
        busySlots.where((slot) => slot.date == dateString).toList();

    // Basit çalışma saatleri varsayımı (09:00-18:00, Pazartesi-Cumartesi)
    final isWorkingDay = date.weekday <= 6; // 1-6: Pazartesi-Cumartesi
    final workingHours = List.generate(
        9,
        (index) =>
            '${(9 + index).toString().padLeft(2, '0')}:00'); // 09:00-17:00

    // Müsait saatleri hesapla
    final availableHours = <String>[];
    if (isWorkingDay && !isPast) {
      for (final hour in workingHours) {
        final isBusy = dayBusySlots.any((slot) =>
            slot.start == hour ||
            slot.start.split(':')[0] == hour.split(':')[0]);
        if (!isBusy) {
          availableHours.add(hour);
        }
      }
    }

    final hasAvailableSlots = availableHours.isNotEmpty;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        color: isToday
            ? Theme.of(context).primaryColor.withOpacity(0.1)
            : isCurrentMonth
                ? Colors.white
                : Colors.grey[50],
      ),
      child: InkWell(
        onTap: hasAvailableSlots && isCurrentMonth
            ? () => _showAvailableHours(date, availableHours)
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${date.day}',
              style: TextStyle(
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                color: isPast || !isCurrentMonth
                    ? Colors.grey[400]
                    : isToday
                        ? Theme.of(context).primaryColor
                        : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            if (isCurrentMonth) ...[
              if (isWorkingDay) ...[
                if (hasAvailableSlots)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  )
                else
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
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
              ref.invalidate(busySlotsProvider(
                BusySlotsParams(
                  serviceId: widget.serviceId,
                  days: 90,
                ),
              ));
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  void _showAvailableHours(DateTime date, List<String> availableHours) {
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
                '${date.day} ${_getMonthName(date.month)} ${date.year}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              // Müsait saatler
              Expanded(
                child: availableHours.isEmpty
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
                        itemCount: availableHours.length,
                        itemBuilder: (context, index) {
                          final hour = availableHours[index];
                          return _buildHourButton(hour, date);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHourButton(String hour, DateTime date) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        widget.onTimeSlotSelected?.call(date, hour);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        hour,
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
