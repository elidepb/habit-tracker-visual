import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/features/home/widgets/home_empty_state.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('HomeEmptyState muestra mensaje y botón crear', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      wrapWithMaterialApp(
        HomeEmptyState(onCreateTap: () => tapped = true),
      ),
    );
    await pumpAnimations(tester);

    expect(find.text('Sin hábitos aún'), findsOneWidget);
    expect(find.text('Crear hábito'), findsOneWidget);

    await tester.tap(find.text('Crear hábito'));
    expect(tapped, isTrue);
  });
}
