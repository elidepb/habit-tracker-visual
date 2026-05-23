import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_frequency.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';

void main() {
  group('HabitFrequency', () {
    test('label retorna texto en español', () {
      expect(HabitFrequency.daily.label, 'Diario');
      expect(HabitFrequency.weekly.label, 'Semanal');
      expect(HabitFrequency.custom.label, 'Personalizado');
    });

    test('fromIndex retorna frecuencia válida', () {
      expect(HabitFrequency.fromIndex(0), HabitFrequency.daily);
      expect(HabitFrequency.fromIndex(99), HabitFrequency.custom);
    });
  });
}
