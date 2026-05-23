import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habits/utils/streak_calculator.dart';
import 'package:habit_tracker_visual/features/habit_detail/utils/habit_statistics_calculator.dart';
import 'package:habit_tracker_visual/features/statistics/models/global_statistics.dart';

abstract final class GlobalStatisticsCalculator {
  static const _weekdayLabels = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

  static GlobalStatistics fromHabits(List<HabitModel> habits) {
    if (habits.isEmpty) return const GlobalStatistics.empty();

    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    final uniqueActiveDays = <String>{};
    for (final habit in habits) {
      uniqueActiveDays.addAll(habit.completedDates);
    }

    final weeklyActivity = _buildWeeklyActivity(habits, todayDate);
    final weeklyTotal = weeklyActivity.fold<int>(
      0,
      (sum, point) => sum + point.completedCount,
    );
    final weeklyAverage = weeklyTotal / weeklyActivity.length;

    final rankings = habits.map((habit) {
      final stats = HabitStatisticsCalculator.fromHabit(habit);
      return HabitRanking(
        habitId: habit.id,
        name: habit.name,
        colorValue: habit.colorValue,
        iconName: habit.iconName,
        completionRate: stats.completionRate,
        currentStreak: stats.currentStreak,
        activeDays: stats.activeDays,
      );
    }).toList()
      ..sort((a, b) => b.completionRate.compareTo(a.completionRate));

    final consistencyRate = rankings.isEmpty
        ? 0.0
        : rankings.map((r) => r.completionRate).reduce((a, b) => a + b) /
            rankings.length;

    final bestStreak = habits
        .map((h) => StreakCalculator.currentStreak(h.completedDates))
        .fold(0, (a, b) => a > b ? a : b);

    return GlobalStatistics(
      totalHabits: habits.length,
      consistencyRate: consistencyRate,
      activeDays: uniqueActiveDays.length,
      weeklyAverage: weeklyAverage,
      bestStreak: bestStreak,
      weeklyActivity: weeklyActivity,
      rankings: rankings,
    );
  }

  static List<WeeklyActivityPoint> _buildWeeklyActivity(
    List<HabitModel> habits,
    DateTime todayDate,
  ) {
    return List.generate(7, (index) {
      final day = todayDate.subtract(Duration(days: 6 - index));
      final dayKey = HabitModel.dateKey(day);

      var completed = 0;
      var possible = 0;
      for (final habit in habits) {
        final created = DateTime(
          habit.createdAt.year,
          habit.createdAt.month,
          habit.createdAt.day,
        );
        if (!day.isBefore(created) && !day.isAfter(todayDate)) {
          possible++;
          if (habit.completedDates.contains(dayKey)) {
            completed++;
          }
        }
      }

      return WeeklyActivityPoint(
        label: _weekdayLabels[day.weekday - 1],
        completedCount: completed,
        totalPossible: possible,
      );
    });
  }
}
