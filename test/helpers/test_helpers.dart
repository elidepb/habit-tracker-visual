import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/core/storage/hive_storage.dart';
import 'package:habit_tracker_visual/core/theme/app_theme.dart';
import 'package:habit_tracker_visual/l10n/app_localizations.dart';

Future<void> initTestHive() async {
  final dir = await Directory.systemTemp.createTemp('hive_test_');
  await HiveStorage.initForTest(dir.path);
}

Widget wrapWithMaterialApp(Widget child, {Locale locale = const Locale('es')}) {
  return MaterialApp(
    theme: AppTheme.dark,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: locale,
    home: Scaffold(body: child),
  );
}

Widget wrapWithProviders(Widget child, {Locale locale = const Locale('es')}) {
  return ProviderScope(
    child: MaterialApp(
      theme: AppTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      home: Scaffold(body: child),
    ),
  );
}

Future<void> pumpAnimations(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
}

AppLocalizations testL10n([Locale locale = const Locale('es')]) {
  return lookupAppLocalizations(locale);
}
