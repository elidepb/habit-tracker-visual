import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_frequency.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habit_detail/utils/habit_statistics_calculator.dart';

void main() {
  group('HabitStatisticsCalculator', () {
    test('calcula días activos y cumplimiento', () {
      final today = DateTime.now();
      final created = today.subtract(const Duration(days: 9));

      final habit = HabitModel(
        id: '1',
        name: 'Test',
        colorValue: 0xFF2EA043,
        iconName: 'activity',
        frequency: HabitFrequency.daily,
        createdAt: created,
        completedDates: [
          HabitModel.dateKey(today),
          HabitModel.dateKey(today.subtract(const Duration(days: 1))),
        ],
      );

      final stats = HabitStatisticsCalculator.fromHabit(habit);

      expect(stats.activeDays, 2);
      expect(stats.daysTracked, 10);
      expect(stats.completionRate, closeTo(0.2, 0.01));
    });

    test('mejor racha refleja días consecutivos', () {
      final today = DateTime.now();
      final dates = List.generate(
        5,
        (i) => HabitModel.dateKey(today.subtract(Duration(days: 4 - i))),
      );

      final habit = HabitModel(
        id: '1',
        name: 'Test',
        colorValue: 0xFF2EA043,
        iconName: 'activity',
        frequency: HabitFrequency.daily,
        createdAt: today.subtract(const Duration(days: 10)),
        completedDates: dates,
      );

      final stats = HabitStatisticsCalculator.fromHabit(habit);

      expect(stats.bestStreak, greaterThanOrEqualTo(5));
      expect(stats.currentStreak, greaterThanOrEqualTo(5));
    });
  });
}
