import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/features/heatmap/models/heatmap_data.dart';
import 'package:habit_tracker_visual/features/heatmap/utils/heatmap_calculator.dart';

final globalHeatmapProvider = Provider<HeatmapData>((ref) {
  final habits = ref.watch(habitsProvider);
  return HeatmapCalculator.fromHabits(habits);
});

final habitHeatmapProvider = Provider.family<HeatmapData, String>((ref, habitId) {
  final habit = ref.watch(habitByIdProvider(habitId));
  if (habit == null) return HeatmapData.empty();
  return HeatmapCalculator.fromHabit(habit);
});
