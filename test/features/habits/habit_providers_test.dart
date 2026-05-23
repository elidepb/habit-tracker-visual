import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habits/providers/daily_check_providers.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/features/habits/repositories/habit_repository.dart';

void main() {
  group('habit providers', () {
    test('habitByIdProvider resuelve hábito desde habitsProvider', () {
      final habit = HabitModel.create(name: 'Correr');
      final container = ProviderContainer(
        overrides: [
          habitsProvider.overrideWith((ref) => [habit]),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(habitByIdProvider(habit.id))?.name, 'Correr');
    });

    test('isCompletedTodayProvider refleja fechas completadas', () {
      final habit = HabitModel.create(name: 'Yoga').copyWith(
        completedDates: [HabitModel.dateKey(DateTime.now())],
      );
      final container = ProviderContainer(
        overrides: [
          habitsProvider.overrideWith((ref) => [habit]),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(isCompletedTodayProvider(habit.id)), isTrue);
    });

    test('todayStatsProvider calcula progreso del día', () {
      final today = DateTime.now();
      final completed = HabitModel.create(name: 'A').copyWith(
        completedDates: [HabitModel.dateKey(today)],
      );
      final pending = HabitModel.create(name: 'B');

      final container = ProviderContainer(
        overrides: [
          habitsProvider.overrideWith((ref) => [completed, pending]),
          habitRepositoryProvider.overrideWithValue(HabitRepository()),
        ],
      );
      addTearDown(container.dispose);

      final stats = container.read(todayStatsProvider);

      expect(stats.total, 2);
      expect(stats.completed, 1);
      expect(stats.rate, 0.5);
    });

    test('habitStreakProvider calcula racha actual', () {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));
      final habit = HabitModel.create(name: 'Leer').copyWith(
        completedDates: [
          HabitModel.dateKey(today),
          HabitModel.dateKey(yesterday),
        ],
      );

      final container = ProviderContainer(
        overrides: [
          habitsProvider.overrideWith((ref) => [habit]),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(habitStreakProvider(habit.id)), 2);
    });
  });
}
