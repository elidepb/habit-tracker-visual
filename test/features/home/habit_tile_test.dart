import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/core/theme/app_theme.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habits/providers/daily_check_providers.dart';
import 'package:habit_tracker_visual/features/home/widgets/habit_tile.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('HabitTile muestra nombre y frecuencia del hábito', (tester) async {
    final habit = HabitModel.create(name: 'Meditar');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          isCompletedTodayProvider(habit.id).overrideWith((ref) => false),
          habitStreakProvider(habit.id).overrideWith((ref) => 0),
        ],
        child: MaterialApp(
          theme: AppTheme.dark,
          home: Scaffold(body: HabitTile(habit: habit, index: 0)),
        ),
      ),
    );
    await pumpAnimations(tester);

    expect(find.text('Meditar'), findsOneWidget);
    expect(find.text('Diario'), findsOneWidget);
  });
}
