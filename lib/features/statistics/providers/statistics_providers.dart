import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/core/utils/date_formatters.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/features/settings/providers/locale_providers.dart';
import 'package:habit_tracker_visual/features/statistics/models/global_statistics.dart';
import 'package:habit_tracker_visual/features/statistics/utils/global_statistics_calculator.dart';

final globalStatisticsProvider = Provider<GlobalStatistics>((ref) {
  final habits = ref.watch(habitsProvider);
  final l10n = ref.watch(appLocalizationsProvider);
  return GlobalStatisticsCalculator.fromHabits(
    habits,
    weekdayLabels: DateFormatters.calendarWeekdayLabels(l10n),
  );
});
