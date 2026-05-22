import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/app.dart';
import 'package:habit_tracker_visual/core/storage/hive_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveStorage.init();

  runApp(
    const ProviderScope(
      child: HabitTrackerApp(),
    ),
  );
}
