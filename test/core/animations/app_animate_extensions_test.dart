import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/core/animations/app_animate_extensions.dart';

void main() {
  testWidgets('fadeSlideIn renderiza el widget hijo', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: const Text('Hola').fadeSlideIn(),
        ),
      ),
    );

    expect(find.text('Hola'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Hola'), findsOneWidget);
  });
}
