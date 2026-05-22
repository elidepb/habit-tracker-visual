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

final habitByIdProvider = Provider.family<HabitModel?, String>((ref, id) {
  final habits = ref.watch(habitsProvider);
  for (final habit in habits) {
    if (habit.id == id) return habit;
  }
  return ref.watch(habitRepositoryProvider).getById(id);
});

final todayStatsProvider = Provider<({int completed, int total, double rate})>((ref) {
  final repository = ref.watch(habitRepositoryProvider);
  ref.watch(habitsStreamProvider);
  final total = repository.getAll().length;
  final completed = repository.completedTodayCount;
  return (
    completed: completed,
    total: total,
    rate: repository.todayCompletionRate,
  );
});
