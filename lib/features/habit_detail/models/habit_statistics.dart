class HabitStatistics {
  const HabitStatistics({
    required this.activeDays,
    required this.currentStreak,
    required this.bestStreak,
    required this.completionRate,
    required this.daysTracked,
  });

  const HabitStatistics.empty()
      : activeDays = 0,
        currentStreak = 0,
        bestStreak = 0,
        completionRate = 0,
        daysTracked = 0;

  final int activeDays;
  final int currentStreak;
  final int bestStreak;
  final double completionRate;
  final int daysTracked;

  int get completionPercent => (completionRate * 100).round();
}
