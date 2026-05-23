import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/core/utils/date_formatters.dart';

void main() {
  group('DateFormatters', () {
    test('reminder formatea hora con padding', () {
      expect(DateFormatters.reminder(9, 5), '09:05');
      expect(DateFormatters.reminder(null, 0), '—');
    });

    test('timeOfDay usa fallback cuando es null', () {
      expect(DateFormatters.timeOfDay(null), 'Seleccionar hora');
      expect(
        DateFormatters.timeOfDay(const TimeOfDay(hour: 14, minute: 30)),
        '14:30',
      );
    });

    test('displayDate incluye día de la semana y mes', () {
      final formatted = DateFormatters.displayDate(DateTime(2026, 5, 22));
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
      final date = DateTime(2026, 5, 22);
      expect(
        DateFormatters.heatmapTooltip(date, level: 0),
        '22/5/2026 — Sin actividad',
      );
      expect(
        DateFormatters.heatmapTooltip(
          date,
          level: 2,
          intensityLabel: (l) => l > 0 ? 'Activo' : 'Inactivo',
        ),
        '22/5/2026 — Activo',
      );
    });
  });
}
