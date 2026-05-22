import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/core/theme/app_theme.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      theme: AppTheme.dark,
      home: Scaffold(body: child),
    );
  }

  group('AppText', () {
    testWidgets('renderiza variantes tipográficas', (tester) async {
      await tester.pumpWidget(
        wrap(
          const Column(
            children: [
              AppText.h1('Título'),
              AppText.caption('Caption'),
            ],
          ),
        ),
      );

      expect(find.text('Título'), findsOneWidget);
      expect(find.text('Caption'), findsOneWidget);
    });
  });

  group('AppButton', () {
    testWidgets('ejecuta onPressed', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        wrap(
          AppButton(
            label: 'Tap me',
            onPressed: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.text('Tap me'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('muestra loading y deshabilita interacción', (tester) async {
      await tester.pumpWidget(
        wrap(
          const AppButton(
            label: 'Loading',
            isLoading: true,
            onPressed: null,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading'), findsNothing);
    });
  });

  group('AppCard', () {
    testWidgets('renderiza contenido', (tester) async {
      await tester.pumpWidget(
        wrap(
          const AppCard(child: Text('Card content')),
        ),
      );

      expect(find.text('Card content'), findsOneWidget);
    });
  });

  group('AppInput', () {
    testWidgets('renderiza label y campo', (tester) async {
      await tester.pumpWidget(
        wrap(
          const AppInput(
            label: 'Nombre',
            hint: 'Escribe aquí',
          ),
        ),
      );

      expect(find.text('Nombre'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });
  });
}
