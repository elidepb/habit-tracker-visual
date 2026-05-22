import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habits/utils/streak_calculator.dart';

void main() {
  group('StreakCalculator', () {
    test('currentStreak cuenta días consecutivos hasta hoy', () {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));
      final twoDaysAgo = today.subtract(const Duration(days: 2));

      final dates = [
        HabitModel.dateKey(today),
        HabitModel.dateKey(yesterday),
        HabitModel.dateKey(twoDaysAgo),
      ];

      expect(StreakCalculator.currentStreak(dates), 3);
    });

    test('currentStreak continúa desde ayer si hoy no está completado', () {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));

      final dates = [
        HabitModel.dateKey(yesterday),
      ];

      expect(StreakCalculator.currentStreak(dates), 1);
    });

    test('currentStreak es 0 sin fechas', () {
      expect(StreakCalculator.currentStreak([]), 0);
    });

    test('bestStreak encuentra la racha más larga', () {
      final dates = [
        '2026-05-01',
        '2026-05-02',
        '2026-05-03',
        '2026-05-10',
        '2026-05-11',
      ];

      expect(StreakCalculator.bestStreak(dates), 3);
    });
  });
}
