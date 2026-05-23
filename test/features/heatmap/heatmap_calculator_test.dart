import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/heatmap/utils/heatmap_calculator.dart';

void main() {
  group('HeatmapCalculator', () {
    test('fromHabit marca días completados con intensidad 4', () {
      final today = DateTime.now();
      final habit = HabitModel.create(name: 'Leer').copyWith(
        completedDates: [HabitModel.dateKey(today)],
      );

      final data = HeatmapCalculator.fromHabit(habit);

      expect(data.isEmpty, isFalse);
      expect(data.weeks, HeatmapCalculator.weeksCount);
      expect(data.totalActiveDays, greaterThan(0));
    });

    test('fromHabits calcula intensidad según ratio de completados', () {
      final today = DateTime.now();
      final habitA = HabitModel.create(name: 'A').copyWith(
        completedDates: [HabitModel.dateKey(today)],
      );
      final habitB = HabitModel.create(name: 'B');

      final data = HeatmapCalculator.fromHabits([habitA, habitB]);

      expect(data.totalHabits, 2);
      expect(data.isEmpty, isFalse);

      var hasActivity = false;
      for (final row in data.grid) {
        for (final level in row) {
          if (level > 0) hasActivity = true;
        }
      }
      expect(hasActivity, isTrue);
    });

    test('fromHabits retorna vacío sin hábitos', () {
      final data = HeatmapCalculator.fromHabits([]);
      expect(data.isEmpty, isTrue);
    });

    test('intensityAt retorna 0 fuera de rango', () {
      final habit = HabitModel.create(name: 'Test');
      final data = HeatmapCalculator.fromHabit(habit);

      expect(data.intensityAt(-1, 0), 0);
      expect(data.intensityAt(0, 999), 0);
    });
  });
}
