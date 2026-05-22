import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/app.dart';
import 'package:habit_tracker_visual/core/storage/hive_storage.dart';
import 'package:habit_tracker_visual/features/splash/views/splash_screen.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final dir = await Directory.systemTemp.createTemp('widget_test_hive');
    await HiveStorage.initForTest(dir.path);
  });

  tearDownAll(() async {
    await HiveStorage.close();
  });

  testWidgets('App muestra splash al iniciar', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: HabitTrackerApp(),
      ),
    );
    await tester.pump();

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('Habit Tracker'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
  });
}
