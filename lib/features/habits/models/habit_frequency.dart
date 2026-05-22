enum HabitFrequency {
  daily,
  weekly,
  custom;

  String get label => switch (this) {
        HabitFrequency.daily => 'Diario',
        HabitFrequency.weekly => 'Semanal',
        HabitFrequency.custom => 'Personalizado',
      };

  static HabitFrequency fromIndex(int index) {
    return HabitFrequency.values[index.clamp(0, HabitFrequency.values.length - 1)];
  }
}
