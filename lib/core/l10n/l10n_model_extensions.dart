import 'package:habit_tracker_visual/features/habits/models/habit_frequency.dart';
import 'package:habit_tracker_visual/l10n/app_localizations.dart';

extension HabitFrequencyL10n on HabitFrequency {
  String localizedLabel(AppLocalizations l10n) {
    return switch (this) {
      HabitFrequency.daily => l10n.frequencyDaily,
      HabitFrequency.weekly => l10n.frequencyWeekly,
      HabitFrequency.custom => l10n.frequencyCustom,
    };
  }
}

String localizedIconLabel(String iconName, AppLocalizations l10n) {
  return switch (iconName) {
    'activity' => l10n.iconActivity,
    'dumbbell' => l10n.iconExercise,
    'book' => l10n.iconReading,
    'moon' => l10n.iconSleep,
    'droplets' => l10n.iconWater,
    'brain' => l10n.iconMind,
    'heart' => l10n.iconHealth,
    'timer' => l10n.iconTime,
    _ => iconName,
  };
}
