import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/shared/widgets/confirm_delete_habit_dialog.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('showDeleteHabitDialog', () {
    testWidgets('retorna false al cancelar', (tester) async {
      bool? result;

      await tester.pumpWidget(
        wrapWithMaterialApp(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  result = await showDeleteHabitDialog(
                    context,
                    habitName: 'Leer',
                  );
                },
                child: const Text('Abrir'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();

      expect(find.text('Eliminar hábito'), findsOneWidget);
      expect(find.textContaining('Leer'), findsOneWidget);

      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();

      expect(result, isFalse);
    });

    testWidgets('retorna true al confirmar eliminación', (tester) async {
      bool? result;

      await tester.pumpWidget(
        wrapWithMaterialApp(
          Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  result = await showDeleteHabitDialog(context);
                },
                child: const Text('Abrir'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Eliminar'));
      await tester.pumpAndSettle();

      expect(result, isTrue);
    });
  });
}
