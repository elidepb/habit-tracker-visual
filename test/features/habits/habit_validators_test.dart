import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/features/habits/validators/habit_validators.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('HabitValidators.name', () {
    test('rechaza nombre vacío', () {
      final l10n = testL10n();
      expect(HabitValidators.name('', l10n), isNotNull);
      expect(HabitValidators.name('   ', l10n), isNotNull);
      expect(HabitValidators.name(null, l10n), isNotNull);
    });

    test('acepta nombre válido', () {
      final l10n = testL10n();
      expect(HabitValidators.name('Leer', l10n), isNull);
      expect(HabitValidators.name('  Meditar  ', l10n), isNull);
    });

    test('rechaza nombre demasiado largo', () {
      final l10n = testL10n();
      final longName = 'a' * (HabitValidators.maxNameLength + 1);
      expect(HabitValidators.name(longName, l10n), isNotNull);
    });
  });
}
