import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_model_extensions.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_frequency.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('HabitFrequency', () {
    test('localizedLabel retorna texto en español', () {
      final l10n = testL10n();
      expect(HabitFrequency.daily.localizedLabel(l10n), 'Diario');
      expect(HabitFrequency.weekly.localizedLabel(l10n), 'Semanal');
      expect(HabitFrequency.custom.localizedLabel(l10n), 'Personalizado');
    });

    test('fromIndex retorna frecuencia válida', () {
      expect(HabitFrequency.fromIndex(0), HabitFrequency.daily);
      expect(HabitFrequency.fromIndex(99), HabitFrequency.custom);
    });
  });
}
