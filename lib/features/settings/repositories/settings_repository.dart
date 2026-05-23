import 'package:hive/hive.dart';
import 'package:habit_tracker_visual/core/storage/hive_storage.dart';

class SettingsRepository {
  Box<dynamic> get _box => Hive.box(HiveBoxes.settings);

  bool get notificationsEnabled =>
      _box.get(SettingsKeys.notificationsEnabled, defaultValue: true) as bool;

  Future<void> setNotificationsEnabled(bool enabled) async {
    await _box.put(SettingsKeys.notificationsEnabled, enabled);
  }
}
