import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/features/habits/validators/habit_validators.dart';

void main() {
  group('HabitValidators.name', () {
    test('rechaza nombre vacío', () {
      expect(HabitValidators.name(''), isNotNull);
      expect(HabitValidators.name('   '), isNotNull);
      expect(HabitValidators.name(null), isNotNull);
    });

    test('acepta nombre válido', () {
      expect(HabitValidators.name('Leer'), isNull);
      expect(HabitValidators.name('  Meditar  '), isNull);
    });

    test('rechaza nombre demasiado largo', () {
      final longName = 'a' * (HabitValidators.maxNameLength + 1);
      expect(HabitValidators.name(longName), isNotNull);
    });
  });
}
