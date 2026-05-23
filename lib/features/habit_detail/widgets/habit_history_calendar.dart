import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_radius.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/core/utils/date_formatters.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habits/providers/daily_check_providers.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HabitHistoryCalendar extends ConsumerStatefulWidget {
  const HabitHistoryCalendar({
    super.key,
    required this.habitId,
    required this.accentColor,
    required this.createdAt,
  });

  final String habitId;
  final Color accentColor;
  final DateTime createdAt;

  @override
  ConsumerState<HabitHistoryCalendar> createState() =>
      _HabitHistoryCalendarState();
}

class _HabitHistoryCalendarState extends ConsumerState<HabitHistoryCalendar> {
  late DateTime _visibleMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _visibleMonth = DateTime(now.year, now.month);
  }

  void _changeMonth(int delta) {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + delta);
    });
  }

  bool _canNavigateForward() {
    final now = DateTime.now();
    final current = DateTime(now.year, now.month);
    return _visibleMonth.isBefore(current);
  }

  DateTime _createdDate() {
    return DateTime(
      widget.createdAt.year,
      widget.createdAt.month,
      widget.createdAt.day,
    );
  }

  bool _isDayEnabled(DateTime day) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final dayDate = DateTime(day.year, day.month, day.day);
    return !dayDate.isAfter(todayDate) && !dayDate.isBefore(_createdDate());
  }

  Future<void> _onDayTap(DateTime day) async {
    if (!_isDayEnabled(day)) return;

    final loading = ref.read(dailyCheckProvider);
    if (loading.contains(widget.habitId)) return;

    await ref.read(dailyCheckProvider.notifier).toggleDate(widget.habitId, day);
  }

  @override
  Widget build(BuildContext context) {
    final habit = ref.watch(habitByIdProvider(widget.habitId));
    if (habit == null) return const SizedBox.shrink();

    final completedSet = habit.completedDates.toSet();
    final daysInMonth =
        DateTime(_visibleMonth.year, _visibleMonth.month + 1, 0).day;
    final firstWeekday = DateTime(_visibleMonth.year, _visibleMonth.month, 1).weekday;
    final leadingEmpty = firstWeekday - 1;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(LucideIcons.chevronLeft),
                onPressed: () => _changeMonth(-1),
              ),
              AppText.subtitle(
                '${DateFormatters.calendarMonthNames[_visibleMonth.month - 1]} ${_visibleMonth.year}',
              ),
              IconButton(
                icon: const Icon(LucideIcons.chevronRight),
                onPressed: _canNavigateForward() ? () => _changeMonth(1) : null,
              ),
            ],
          ),
          const VGap.md(),
          Row(
            children: DateFormatters.calendarWeekdayLabels
                .map(
                  (label) => Expanded(
                    child: Center(
                      child: AppText.caption(
                        label,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const VGap.sm(),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: AppSpacing.sm,
              crossAxisSpacing: AppSpacing.sm,
            ),
            itemCount: leadingEmpty + daysInMonth,
            itemBuilder: (context, index) {
              if (index < leadingEmpty) {
                return const SizedBox.shrink();
              }

              final day = index - leadingEmpty + 1;
              final date = DateTime(
                _visibleMonth.year,
                _visibleMonth.month,
                day,
              );
              final isCompleted =
                  completedSet.contains(HabitModel.dateKey(date));
              final isEnabled = _isDayEnabled(date);
              final isToday = HabitModel.dateKey(date) ==
                  HabitModel.dateKey(DateTime.now());

              return _CalendarDay(
                day: day,
                isCompleted: isCompleted,
                isEnabled: isEnabled,
                isToday: isToday,
                accentColor: widget.accentColor,
                onTap: () => _onDayTap(date),
              );
            },
          ),
          const VGap.md(),
          const AppText.caption(
            'Toca un día para marcar o desmarcar como completado.',
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

class _CalendarDay extends StatelessWidget {
  const _CalendarDay({
    required this.day,
    required this.isCompleted,
    required this.isEnabled,
    required this.isToday,
    required this.accentColor,
    required this.onTap,
  });

  final int day;
  final bool isCompleted;
  final bool isEnabled;
  final bool isToday;
  final Color accentColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color background = Colors.transparent;
    Color textColor = AppColors.textSecondary;
    Border? border;

    if (!isEnabled) {
      textColor = AppColors.textSecondary.withValues(alpha: 0.3);
    } else if (isCompleted) {
      background = accentColor;
      textColor = Colors.white;
    } else if (isToday) {
      border = Border.all(color: accentColor, width: 2);
      textColor = AppColors.textPrimary;
    } else {
      textColor = AppColors.textPrimary;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(AppRadius.input),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(AppRadius.input),
            border: border,
          ),
          child: AppText.body(
            '$day',
            color: textColor,
          ),
        ),
      ),
    );
  }
}
