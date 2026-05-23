import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habits/repositories/habit_repository.dart';

final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  return HabitRepository();
});

final habitsStreamProvider = StreamProvider<List<HabitModel>>((ref) {
  final repository = ref.watch(habitRepositoryProvider);
  return repository.watchAll();
});

final habitsProvider = Provider<List<HabitModel>>((ref) {
  return ref.watch(habitsStreamProvider).value ?? [];
});

final habitsByIdProvider = Provider<Map<String, HabitModel>>((ref) {
  final habits = ref.watch(habitsProvider);
  return {for (final habit in habits) habit.id: habit};
});

final habitByIdProvider = Provider.family<HabitModel?, String>((ref, id) {
  final habitsById = ref.watch(habitsByIdProvider);
  return habitsById[id] ?? ref.watch(habitRepositoryProvider).getById(id);
});

final todayStatsProvider = Provider<({int completed, int total, double rate})>((ref) {
  final habits = ref.watch(habitsProvider);
  return ref.watch(habitRepositoryProvider).todayStatsFor(habits);
});
