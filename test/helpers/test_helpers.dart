import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/core/storage/hive_storage.dart';
import 'package:habit_tracker_visual/core/theme/app_theme.dart';

Future<void> initTestHive() async {
  final dir = await Directory.systemTemp.createTemp('hive_test_');
  await HiveStorage.initForTest(dir.path);
}

Widget wrapWithMaterialApp(Widget child) {
  return MaterialApp(
    theme: AppTheme.dark,
    home: Scaffold(body: child),
  );
}

Widget wrapWithProviders(Widget child) {
  return ProviderScope(
    child: MaterialApp(
      theme: AppTheme.dark,
      home: Scaffold(body: child),
    ),
  );
}

Future<void> pumpAnimations(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
}
