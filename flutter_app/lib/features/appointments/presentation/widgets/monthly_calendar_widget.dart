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

class _MonthlyCalendarWidgetState extends ConsumerState<MonthlyCalendarWidget>
    with TickerProviderStateMixin {
  late DateTime _currentDate;
  late int _currentYear;
  late int _currentMonth;
  late AnimationController _monthAnimationController;
  late AnimationController _dayAnimationController;
  late Animation<double> _monthAnimation;
  late Animation<double> _dayAnimation;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _currentYear = _currentDate.year;
    _currentMonth = _currentDate.month;

    _monthAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _dayAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _monthAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _monthAnimationController,
      curve: Curves.easeInOut,
    ));

    _dayAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _dayAnimationController,
      curve: Curves.elasticOut,
    ));

    _monthAnimationController.forward();
    _dayAnimationController.forward();
  }

  @override
  void dispose() {
    _monthAnimationController.dispose();
    _dayAnimationController.dispose();
    super.dispose();
  }

  void _previousMonth() {
    _monthAnimationController.reverse().then((_) {
      setState(() {
        if (_currentMonth == 1) {
          _currentMonth = 12;
          _currentYear--;
        } else {
          _currentMonth--;
        }
      });
      _monthAnimationController.forward();
    });
  }

  void _nextMonth() {
    _monthAnimationController.reverse().then((_) {
      setState(() {
        if (_currentMonth == 12) {
          _currentMonth = 1;
          _currentYear++;
        } else {
          _currentMonth++;
        }
      });
      _monthAnimationController.forward();
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
        // Modern month navigation
        _buildModernMonthNavigation(),
        const SizedBox(height: 20),
        // Modern calendar
        busySlots.when(
          data: (busySlotsList) => _buildModernCalendar(busySlotsList),
          loading: () => _buildLoadingState(),
          error: (error, stack) => _buildErrorWidget(error),
        ),
      ],
    );
  }

  Widget _buildModernMonthNavigation() {
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
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryNavy,
            AppTheme.primaryNavy.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryNavy.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavigationButton(
              icon: Icons.chevron_left_rounded,
              onPressed: _previousMonth,
            ),
            AnimatedBuilder(
              animation: _monthAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: 0.8 + (0.2 * _monthAnimation.value),
                  child: Opacity(
                    opacity: _monthAnimation.value,
                    child: Text(
                      '${monthNames[_currentMonth - 1]} $_currentYear',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                );
              },
            ),
            _buildNavigationButton(
              icon: Icons.chevron_right_rounded,
              onPressed: _nextMonth,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernCalendar(List<BusySlot> busySlotsList) {
    final today = DateTime.now();
    final daysInMonth = DateTime(_currentYear, _currentMonth + 1, 0).day;
    final firstDayOfMonth = DateTime(_currentYear, _currentMonth, 1);
    final firstWeekday = firstDayOfMonth.weekday;

    final days = <DateTime>[];

    // Önceki ayın son günlerini ekle
    for (int i = firstWeekday - 1; i > 0; i--) {
      days.add(firstDayOfMonth.subtract(Duration(days: i)));
    }

    // Bu ayın günlerini ekle
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(_currentYear, _currentMonth, i));
    }

    // Sonraki ayın ilk günlerini ekle
    while (days.length % 7 != 0) {
      days.add(days.last.add(const Duration(days: 1)));
    }

    return AnimatedBuilder(
      animation: _monthAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.95 + (0.05 * _monthAnimation.value),
          child: Opacity(
            opacity: _monthAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildModernWeekdayHeaders(),
                  ...List.generate(
                    (days.length / 7).ceil(),
                    (weekIndex) => _buildModernWeekRow(
                        days, weekIndex, today, busySlotsList),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModernWeekdayHeaders() {
    final weekdays = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryNavy.withOpacity(0.05),
            AppTheme.primaryNavy.withOpacity(0.02),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
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
                        fontSize: 14,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildModernWeekRow(List<DateTime> days, int weekIndex, DateTime today,
      List<BusySlot> busySlots) {
    final startIndex = weekIndex * 7;
    final endIndex = (startIndex + 7).clamp(0, days.length);
    final weekDays = days.sublist(startIndex, endIndex);

    return Row(
      children: List.generate(7, (dayIndex) {
        if (dayIndex < weekDays.length) {
          return Expanded(
            child: _buildModernDayCell(weekDays[dayIndex], today, busySlots),
          );
        } else {
          return const Expanded(child: SizedBox());
        }
      }),
    );
  }

  Widget _buildModernDayCell(
      DateTime date, DateTime today, List<BusySlot> busySlots) {
    final isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;

    final isPast = date.isBefore(today) && !isToday;
    final isCurrentMonth =
        date.month == _currentMonth && date.year == _currentYear;

    // Bu tarih için dolu slotları bul
    final dateString = date.toIso8601String().split('T')[0];
    final dayBusySlots =
        busySlots.where((slot) => slot.date == dateString).toList();

    // Basit çalışma saatleri varsayımı (09:00-18:00, Pazartesi-Cumartesi)
    final isWorkingDay = date.weekday <= 6;
    final workingHours = List.generate(
        9, (index) => '${(9 + index).toString().padLeft(2, '0')}:00');

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
    final isWeekend = date.weekday == 7; // Pazar

    return AnimatedBuilder(
      animation: _dayAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * _dayAnimation.value),
          child: Container(
            height: 90,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: _getDayCellColor(isToday, isPast, isCurrentMonth,
                  isWeekend, hasAvailableSlots),
              border: isToday
                  ? Border.all(
                      color: AppTheme.primaryNavy,
                      width: 2,
                    )
                  : hasAvailableSlots && !isToday
                      ? Border.all(
                          color: AppTheme.successGreen.withOpacity(0.3),
                          width: 1,
                        )
                      : null,
              boxShadow: isToday
                  ? [
                      BoxShadow(
                        color: AppTheme.primaryNavy.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : hasAvailableSlots && !isToday
                      ? [
                          BoxShadow(
                            color: AppTheme.successGreen.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: hasAvailableSlots && isCurrentMonth
                    ? () => _showModernAvailableHours(date, availableHours)
                    : null,
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${date.day}',
                      style: TextStyle(
                        fontWeight: isToday ? FontWeight.bold : FontWeight.w600,
                        fontSize: 16,
                        color: _getDayTextColor(isToday, isPast, isCurrentMonth,
                            isWeekend, hasAvailableSlots),
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (isCurrentMonth) ...[
                      if (isWorkingDay) ...[
                        _buildAvailabilityIndicator(hasAvailableSlots),
                      ] else
                        _buildWeekendIndicator(),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getDayCellColor(bool isToday, bool isPast, bool isCurrentMonth,
      bool isWeekend, bool hasAvailableSlots) {
    if (isToday) {
      return AppTheme.primaryNavy.withOpacity(0.1);
    } else if (isPast) {
      return Colors.grey.withOpacity(0.1);
    } else if (!isCurrentMonth) {
      return Colors.grey.withOpacity(0.05);
    } else if (isWeekend) {
      return Colors.blue.withOpacity(0.05);
    } else if (hasAvailableSlots) {
      return AppTheme.successGreen.withOpacity(0.15);
    } else {
      return Colors.transparent;
    }
  }

  Color _getDayTextColor(bool isToday, bool isPast, bool isCurrentMonth,
      bool isWeekend, bool hasAvailableSlots) {
    if (isToday) {
      return AppTheme.primaryNavy;
    } else if (isPast || !isCurrentMonth) {
      return Colors.grey.withOpacity(0.5);
    } else if (isWeekend) {
      return Colors.blue.withOpacity(0.7);
    } else if (hasAvailableSlots) {
      return AppTheme.successGreen;
    } else {
      return Theme.of(context).colorScheme.onSurface;
    }
  }

  Widget _buildAvailabilityIndicator(bool hasAvailableSlots) {
    return Container(
      width: hasAvailableSlots ? 14 : 12,
      height: hasAvailableSlots ? 14 : 12,
      decoration: BoxDecoration(
        color: hasAvailableSlots ? AppTheme.successGreen : AppTheme.errorRed,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color:
                (hasAvailableSlots ? AppTheme.successGreen : AppTheme.errorRed)
                    .withOpacity(hasAvailableSlots ? 0.6 : 0.4),
            blurRadius: hasAvailableSlots ? 6 : 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: hasAvailableSlots
          ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 8,
            )
          : null,
    );
  }

  Widget _buildWeekendIndicator() {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.6),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Skeleton calendar grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Skeleton month header
                  Container(
                    height: 40,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  // Skeleton calendar days
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: 35, // 5 weeks * 7 days
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Loading indicator at bottom
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppTheme.primaryOrange),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Takvim yükleniyor...',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.primaryNavy.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(Object error) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.errorRed.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: AppTheme.errorRed,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Takvim Yüklenemedi',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.errorRed,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              ref.invalidate(busySlotsProvider(
                BusySlotsParams(
                  serviceId: widget.serviceId,
                  days: 90,
                ),
              ));
            },
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Tekrar Dene'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryOrange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showModernAvailableHours(DateTime date, List<String> availableHours) {
    // Get busy slots for this date
    final dateString = date.toIso8601String().split('T')[0];

    // Preload the data before showing modal
    final busySlotsAsync = ref.read(busySlotsProvider(
      BusySlotsParams(
        serviceId: widget.serviceId,
        days: 30,
      ),
    ).future);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (context, scrollController) => FutureBuilder<List<BusySlot>>(
          future: busySlotsAsync,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppTheme.primaryOrange),
                  ),
                ),
              );
            }

            if (snapshot.hasError) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 64,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Saatler yüklenirken hata oluştu',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.grey.withOpacity(0.7),
                                ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final busySlots = snapshot.data ?? [];
            final dayBusySlots =
                busySlots.where((slot) => slot.date == dateString).toList();
            final allWorkingHours = List.generate(
                9, (index) => '${(9 + index).toString().padLeft(2, '0')}:00');

            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(28)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Modern handle bar
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Modern header
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryOrange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                Icons.access_time_rounded,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Saatler',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    '${date.day} ${_getMonthName(date.month)} ${date.year}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Modern time slots
                        Flexible(
                          child: SizedBox(
                            height: 200,
                            child: GridView.builder(
                              controller: scrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2.2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: allWorkingHours.length,
                              itemBuilder: (context, index) {
                                final hour = allWorkingHours[index];
                                final isBusy = dayBusySlots.any((slot) =>
                                    slot.start == hour ||
                                    slot.start.split(':')[0] ==
                                        hour.split(':')[0]);

                                if (isBusy) {
                                  return _buildBusyHourButton(hour);
                                } else {
                                  return _buildModernHourButton(hour, date);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildModernHourButton(String hour, DateTime date) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            widget.onTimeSlotSelected?.call(date, hour);
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                hour,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBusyHourButton(String hour) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // Hour text
          Center(
            child: Text(
              hour,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.withOpacity(0.6),
              ),
            ),
          ),
          // Red cross overlay
          Center(
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppTheme.errorRed.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close_rounded,
                color: AppTheme.errorRed,
                size: 22,
              ),
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
