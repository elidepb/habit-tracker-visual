import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:habit_tracker_visual/core/storage/hive_storage.dart';

class SettingsRepository {
  Box<dynamic> get _box => Hive.box(HiveBoxes.settings);

  bool get notificationsEnabled =>
      _box.get(SettingsKeys.notificationsEnabled, defaultValue: true) as bool;

  Future<void> setNotificationsEnabled(bool enabled) async {
    await _box.put(SettingsKeys.notificationsEnabled, enabled);
  }

  ThemeMode get themeMode {
    final stored = _box.get(SettingsKeys.themeMode, defaultValue: 'system');
    return switch (stored) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await _box.put(SettingsKeys.themeMode, value);
  }

  String get localeCode =>
      _box.get(SettingsKeys.localeCode, defaultValue: 'system') as String;

  Future<void> setLocaleCode(String code) async {
    await _box.put(SettingsKeys.localeCode, code);
  }
}
