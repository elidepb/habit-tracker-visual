import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/core/utils/date_formatters.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('DateFormatters', () {
    test('reminder formatea hora con padding', () {
      final l10n = testL10n();
      expect(DateFormatters.reminder(9, 5, l10n), '09:05');
      expect(DateFormatters.reminder(null, 0, l10n), '—');
    });

    test('timeOfDay usa fallback cuando es null', () {
      final l10n = testL10n();
      expect(DateFormatters.timeOfDay(null, l10n), 'Seleccionar hora');
      expect(
        DateFormatters.timeOfDay(const TimeOfDay(hour: 14, minute: 30), l10n),
        '14:30',
      );
    });

    test('displayDate incluye día de la semana y mes', () {
      final l10n = testL10n();
      final formatted = DateFormatters.displayDate(DateTime(2026, 5, 22), l10n);
      expect(formatted, contains('22'));
      expect(formatted, contains('mayo'));
    });

    test('heatmapDate usa formato corto', () {
      expect(
        DateFormatters.heatmapDate(DateTime(2026, 5, 22)),
        '22/5/2026',
      );
    });

    test('heatmapTooltip describe nivel de actividad', () {
      final l10n = testL10n();
      final date = DateTime(2026, 5, 22);
      expect(
        DateFormatters.heatmapTooltip(date, level: 0, l10n: l10n),
        '22/5/2026 — Sin actividad',
      );
      expect(
        DateFormatters.heatmapTooltip(
          date,
          level: 2,
          l10n: l10n,
          intensityLabel: (l) => l > 0 ? 'Activo' : 'Inactivo',
        ),
        '22/5/2026 — Activo',
      );
    });
  });
}
