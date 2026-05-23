import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/features/statistics/models/global_statistics.dart';
import 'package:habit_tracker_visual/features/statistics/utils/global_statistics_calculator.dart';

final globalStatisticsProvider = Provider<GlobalStatistics>((ref) {
  final habits = ref.watch(habitsProvider);
  return GlobalStatisticsCalculator.fromHabits(habits);
});
