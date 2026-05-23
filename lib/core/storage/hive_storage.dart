import 'package:hive_flutter/hive_flutter.dart';
import 'package:habit_tracker_visual/features/habits/adapters/habit_model_adapter.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';

abstract final class HiveBoxes {
  static const String habits = 'habits';
  static const String settings = 'settings';
}

abstract final class SettingsKeys {
  static const String notificationsEnabled = 'notifications_enabled';
}

abstract final class HiveStorage {
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(HabitModelAdapter().typeId)) {
      Hive.registerAdapter(HabitModelAdapter());
    }

    await Hive.openBox<HabitModel>(HiveBoxes.habits);
    await Hive.openBox(HiveBoxes.settings);
    _initialized = true;
  }

  static Future<void> initForTest(String path) async {
    Hive.init(path);

    if (!Hive.isAdapterRegistered(HabitModelAdapter().typeId)) {
      Hive.registerAdapter(HabitModelAdapter());
    }

    await Hive.openBox<HabitModel>(HiveBoxes.habits);
    await Hive.openBox(HiveBoxes.settings);
  }

  static Future<void> close() async {
    await Hive.close();
    _initialized = false;
  }
}
