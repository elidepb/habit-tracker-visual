import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_frequency.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';

void main() {
  group('HabitModel', () {
    test('dateKey normaliza a yyyy-MM-dd', () {
      expect(
        HabitModel.dateKey(DateTime(2026, 5, 22, 15, 30)),
        '2026-05-22',
      );
    });

    test('isCompletedOn detecta fechas completadas', () {
      final today = DateTime.now();
      final habit = HabitModel.create(name: 'Leer').copyWith(
        completedDates: [HabitModel.dateKey(today)],
      );

      expect(habit.isCompletedOn(today), isTrue);
      expect(
        habit.isCompletedOn(today.subtract(const Duration(days: 1))),
        isFalse,
      );
    });

    test('toggleCompletion agrega y quita la misma fecha', () {
      final date = DateTime(2026, 5, 22);
      final habit = HabitModel.create(name: 'Leer');

      final completed = habit.toggleCompletion(date);
      expect(completed.completedDates, contains('2026-05-22'));

      final uncompleted = completed.toggleCompletion(date);
      expect(uncompleted.completedDates, isEmpty);
    });

    test('copyWith puede limpiar recordatorio', () {
      final habit = HabitModel.create(
        name: 'Leer',
        reminderEnabled: true,
        reminderHour: 9,
        reminderMinute: 0,
      );

      final cleared = habit.copyWith(
        reminderEnabled: false,
        clearReminderHour: true,
        clearReminderMinute: true,
      );

      expect(cleared.reminderEnabled, isFalse);
      expect(cleared.reminderHour, isNull);
      expect(cleared.reminderMinute, isNull);
    });

    test('create asigna valores por defecto', () {
      final habit = HabitModel.create(name: 'Meditar');

      expect(habit.name, 'Meditar');
      expect(habit.frequency, HabitFrequency.daily);
      expect(habit.reminderEnabled, isFalse);
      expect(habit.completedDates, isEmpty);
      expect(habit.id, isNotEmpty);
    });
  });
}
