import 'package:habit_tracker_visual/l10n/app_localizations.dart';

abstract final class HabitValidators {
  static const int maxNameLength = 50;

  static String? name(String? value, AppLocalizations l10n) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return l10n.validationNameRequired;
    }
    if (trimmed.length > maxNameLength) {
      return l10n.validationNameMaxLength(maxNameLength);
    }
    return null;
  }
}
