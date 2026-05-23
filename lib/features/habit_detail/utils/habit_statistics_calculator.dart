import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habits/utils/streak_calculator.dart';
import 'package:habit_tracker_visual/features/habit_detail/models/habit_statistics.dart';

abstract final class HabitStatisticsCalculator {
  static HabitStatistics fromHabit(HabitModel habit) {
    final created = DateTime(
      habit.createdAt.year,
      habit.createdAt.month,
      habit.createdAt.day,
    );
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final daysTracked = todayDate.difference(created).inDays + 1;

    final completedSet = habit.completedDates.toSet();
    var completedInRange = 0;
    for (var i = 0; i < daysTracked; i++) {
      final day = created.add(Duration(days: i));
      if (completedSet.contains(HabitModel.dateKey(day))) {
        completedInRange++;
      }
    }

    final rate = daysTracked > 0 ? completedInRange / daysTracked : 0.0;

    return HabitStatistics(
      activeDays: habit.completedDates.length,
      currentStreak: StreakCalculator.currentStreak(habit.completedDates),
      bestStreak: StreakCalculator.bestStreak(habit.completedDates),
      completionRate: rate,
      daysTracked: daysTracked,
    );
  }
}
