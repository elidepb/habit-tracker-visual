import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/core/notifications/notification_bootstrap.dart';
import 'package:habit_tracker_visual/core/router/app_router.dart';
import 'package:habit_tracker_visual/core/theme/app_theme.dart';
import 'package:habit_tracker_visual/features/settings/providers/locale_providers.dart';
import 'package:habit_tracker_visual/features/settings/providers/theme_providers.dart';
import 'package:habit_tracker_visual/l10n/app_localizations.dart';

class HabitTrackerApp extends ConsumerWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    final localeCode = ref.watch(localePreferenceProvider);

    return NotificationBootstrap(
      child: MaterialApp.router(
        title: 'Habit Tracker Visual',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeMode,
        locale: localeFromPreference(localeCode),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
  }
}
