import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/features/habit_detail/models/habit_statistics.dart';
import 'package:habit_tracker_visual/features/habit_detail/utils/habit_statistics_calculator.dart';

final habitStatisticsProvider = Provider.family<HabitStatistics, String>((ref, habitId) {
  final habit = ref.watch(habitByIdProvider(habitId));
  if (habit == null) return const HabitStatistics.empty();
  return HabitStatisticsCalculator.fromHabit(habit);
});
