enum HabitFrequency {
  daily,
  weekly,
  custom;

  static HabitFrequency fromIndex(int index) {
    return HabitFrequency.values[index.clamp(0, HabitFrequency.values.length - 1)];
  }
}
