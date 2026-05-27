import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/heatmap/models/heatmap_data.dart';

abstract final class HeatmapCalculator {
  static const int daysPerWeek = 7;

  static HeatmapData fromHabits(List<HabitModel> habits) {
    if (habits.isEmpty) return HeatmapData.empty();

    final completionCounts = <String, int>{};
    for (final habit in habits) {
      for (final dateKey in habit.completedDates) {
        completionCounts[dateKey] = (completionCounts[dateKey] ?? 0) + 1;
      }
    }

    return _build(
      totalHabits: habits.length,
      intensityForDate: (date) {
        final key = HabitModel.dateKey(date);
        final count = completionCounts[key] ?? 0;
        return _intensityFromRatio(count, habits.length);
      },
    );
  }

  static HeatmapData fromHabit(HabitModel habit) {
    final completedSet = habit.completedDates.toSet();

    return _build(
      totalHabits: 1,
      intensityForDate: (date) {
        return completedSet.contains(HabitModel.dateKey(date)) ? 4 : 0;
      },
    );
  }

  static HeatmapData _build({
    required int totalHabits,
    required int Function(DateTime date) intensityForDate,
  }) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yearStart = DateTime(now.year, 1, 1);

    final alignedStart = _alignToSunday(yearStart);
    final weeks = weekColumnFor(alignedStart, today) + 1;
    final grid = List.generate(
      daysPerWeek,
      (_) => List<int>.filled(weeks, 0),
    );

    var cursor = alignedStart;
    while (!cursor.isAfter(today)) {
      final row = cursor.weekday % 7;
      final col = cursor.difference(alignedStart).inDays ~/ daysPerWeek;
      if (col >= 0 && col < weeks && !cursor.isBefore(yearStart)) {
        grid[row][col] = intensityForDate(cursor);
      }
      cursor = cursor.add(const Duration(days: 1));
    }

    var activeDays = 0;
    for (final row in grid) {
      for (final level in row) {
        if (level > 0) activeDays++;
      }
    }

    return HeatmapData(
      grid: grid,
      weeks: weeks,
      startDate: alignedStart,
      endDate: today,
      totalHabits: totalHabits,
      totalActiveDays: activeDays,
    );
  }

  static int weekColumnFor(DateTime gridStart, DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final normalizedStart = DateTime(
      gridStart.year,
      gridStart.month,
      gridStart.day,
    );
    return normalizedDate.difference(normalizedStart).inDays ~/ daysPerWeek;
  }

  static DateTime _alignToSunday(DateTime date) {
    final daysFromSunday = date.weekday % 7;
    return DateTime(date.year, date.month, date.day)
        .subtract(Duration(days: daysFromSunday));
  }

  static int _intensityFromRatio(int completed, int total) {
    if (completed <= 0 || total <= 0) return 0;
    final ratio = completed / total;
    if (ratio >= 1) return 4;
    if (ratio >= 0.75) return 3;
    if (ratio >= 0.5) return 2;
    return 1;
  }
}
