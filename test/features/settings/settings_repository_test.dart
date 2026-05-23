import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/core/storage/hive_storage.dart';
import 'package:habit_tracker_visual/features/settings/repositories/settings_repository.dart';

void main() {
  late SettingsRepository repository;

  setUp(() async {
    final tempDir = await Directory.systemTemp.createTemp('settings_test');
    await HiveStorage.initForTest(tempDir.path);
    repository = SettingsRepository();
  });

  tearDown(() async {
    await HiveStorage.close();
  });

  group('SettingsRepository', () {
    test('notificationsEnabled es true por defecto', () {
      expect(repository.notificationsEnabled, isTrue);
    });

    test('setNotificationsEnabled persiste el valor', () async {
      await repository.setNotificationsEnabled(false);
      expect(repository.notificationsEnabled, isFalse);

      await repository.setNotificationsEnabled(true);
      expect(repository.notificationsEnabled, isTrue);
    });
  });
}
