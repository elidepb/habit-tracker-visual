import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/features/settings/providers/notification_providers.dart';
import 'package:habit_tracker_visual/l10n/app_localizations.dart';

class LocalePreferenceNotifier extends Notifier<String> {
  @override
  String build() {
    return ref.read(settingsRepositoryProvider).localeCode;
  }

  Future<void> setLocaleCode(String code) async {
    await ref.read(settingsRepositoryProvider).setLocaleCode(code);
    state = code;
  }
}

final localePreferenceProvider =
    NotifierProvider<LocalePreferenceNotifier, String>(
  LocalePreferenceNotifier.new,
);

Locale resolveAppLocale(String code) {
  final explicit = localeFromPreference(code);
  if (explicit != null) return explicit;

  final device = PlatformDispatcher.instance.locale;
  if (device.languageCode == 'en') return const Locale('en');
  return const Locale('es');
}

final resolvedLocaleProvider = Provider<Locale>((ref) {
  return resolveAppLocale(ref.watch(localePreferenceProvider));
});

final appLocalizationsProvider = Provider<AppLocalizations>((ref) {
  return lookupAppLocalizations(ref.watch(resolvedLocaleProvider));
});
