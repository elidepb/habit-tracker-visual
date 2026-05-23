import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_frequency.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/statistics/utils/global_statistics_calculator.dart';

void main() {
  group('GlobalStatisticsCalculator', () {
    test('retorna vacío sin hábitos', () {
      final stats = GlobalStatisticsCalculator.fromHabits([]);
      expect(stats.totalHabits, 0);
      expect(stats.rankings, isEmpty);
    });

    test('calcula consistencia y ranking', () {
      final today = DateTime.now();
      final habitA = HabitModel(
        id: 'a',
        name: 'A',
        colorValue: 0xFF2EA043,
        iconName: 'activity',
        frequency: HabitFrequency.daily,
        createdAt: today.subtract(const Duration(days: 9)),
        completedDates: List.generate(
          8,
          (i) => HabitModel.dateKey(today.subtract(Duration(days: i))),
        ),
      );
      final habitB = HabitModel(
        id: 'b',
        name: 'B',
        colorValue: 0xFF58A6FF,
        iconName: 'book',
        frequency: HabitFrequency.daily,
        createdAt: today.subtract(const Duration(days: 9)),
        completedDates: [
          HabitModel.dateKey(today),
        ],
      );

      final stats = GlobalStatisticsCalculator.fromHabits([habitA, habitB]);

      expect(stats.totalHabits, 2);
      expect(stats.activeDays, greaterThan(0));
      expect(stats.weeklyActivity.length, 7);
      expect(stats.rankings.first.habitId, 'a');
      expect(stats.consistencyRate, greaterThan(0));
    });
  });
}
