import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/shared/widgets/habit_not_found_screen.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('HabitNotFoundScreen muestra mensaje y botón atrás', (tester) async {
    await tester.pumpWidget(
      wrapWithMaterialApp(const HabitNotFoundScreen()),
    );

    expect(find.text('Hábito no encontrado'), findsOneWidget);
    expect(find.byIcon(LucideIcons.arrowLeft), findsOneWidget);
  });
}
