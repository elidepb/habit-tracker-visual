import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/core/theme/app_theme.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/features/statistics/views/statistics_screen.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('StatisticsScreen muestra empty state sin hábitos', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          habitsProvider.overrideWith((ref) => []),
        ],
        child: MaterialApp(
          theme: AppTheme.dark,
          home: const StatisticsScreen(),
        ),
      ),
    );
    await pumpAnimations(tester);

    expect(find.text('Estadísticas'), findsOneWidget);
    expect(find.text('Sin datos aún'), findsOneWidget);
  });

  testWidgets('StatisticsScreen muestra resumen con hábitos', (tester) async {
    final habit = HabitModel.create(name: 'Leer');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          habitsProvider.overrideWith((ref) => [habit]),
        ],
        child: MaterialApp(
          theme: AppTheme.dark,
          home: const StatisticsScreen(),
        ),
      ),
    );
    await pumpAnimations(tester);

    expect(find.text('Resumen'), findsOneWidget);
    expect(find.text('Consistencia'), findsOneWidget);
  });
}
