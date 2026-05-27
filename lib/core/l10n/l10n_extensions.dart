import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/l10n/app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

Locale? localeFromPreference(String code) {
  return switch (code) {
    'es' => const Locale('es'),
    'en' => const Locale('en'),
    _ => null,
  };
}

AppLocalizations lookupL10nFromPreference(String code) {
  final locale = localeFromPreference(code) ?? const Locale('es');
  return lookupAppLocalizations(locale);
}
