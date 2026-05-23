import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/app.dart';
import 'package:habit_tracker_visual/core/storage/hive_storage.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStorage.init();

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.local);

  runApp(
    const ProviderScope(
      child: HabitTrackerApp(),
    ),
  );
}
