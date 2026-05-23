import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/shared/widgets/stat_metric_card.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('StatMetricCard', () {
    testWidgets('muestra valor y etiqueta', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          const StatMetricCard(
            icon: LucideIcons.flame,
            label: 'Mejor racha',
            value: '7',
            color: Colors.orange,
          ),
        ),
      );

      expect(find.text('7'), findsOneWidget);
      expect(find.text('Mejor racha'), findsOneWidget);
    });

    testWidgets('muestra suffix opcional', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          const StatMetricCard(
            icon: LucideIcons.percent,
            label: 'Cumplimiento',
            value: '85',
            suffix: '%',
            color: Colors.blue,
          ),
        ),
      );

      expect(find.text('85'), findsOneWidget);
      expect(find.text('%'), findsOneWidget);
    });
  });
}
