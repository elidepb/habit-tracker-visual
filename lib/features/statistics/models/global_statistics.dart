class WeeklyActivityPoint {
  const WeeklyActivityPoint({
    required this.label,
    required this.completedCount,
    required this.totalPossible,
  });

  final String label;
  final int completedCount;
  final int totalPossible;

  double get rate =>
      totalPossible > 0 ? completedCount / totalPossible : 0;
}

class HabitRanking {
  const HabitRanking({
    required this.habitId,
    required this.name,
    required this.colorValue,
    required this.iconName,
    required this.completionRate,
    required this.currentStreak,
    required this.activeDays,
  });

  final String habitId;
  final String name;
  final int colorValue;
  final String iconName;
  final double completionRate;
  final int currentStreak;
  final int activeDays;

  int get completionPercent => (completionRate * 100).round();
}

class GlobalStatistics {
  const GlobalStatistics({
    required this.totalHabits,
    required this.consistencyRate,
    required this.activeDays,
    required this.weeklyAverage,
    required this.bestStreak,
    required this.weeklyActivity,
    required this.rankings,
  });

  const GlobalStatistics.empty()
      : totalHabits = 0,
        consistencyRate = 0,
        activeDays = 0,
        weeklyAverage = 0,
        bestStreak = 0,
        weeklyActivity = const [],
        rankings = const [];

  final int totalHabits;
  final double consistencyRate;
  final int activeDays;
  final double weeklyAverage;
  final int bestStreak;
  final List<WeeklyActivityPoint> weeklyActivity;
  final List<HabitRanking> rankings;

  int get consistencyPercent => (consistencyRate * 100).round();
}
