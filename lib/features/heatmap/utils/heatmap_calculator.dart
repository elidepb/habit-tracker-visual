import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/heatmap/models/heatmap_data.dart';

abstract final class HeatmapCalculator {
  static const int weeksCount = 53;
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
    final end = DateTime.now();
    final endDate = DateTime(end.year, end.month, end.day);
    final alignedStart = _alignToSunday(
      endDate.subtract(Duration(days: (weeksCount - 1) * daysPerWeek)),
    );
    final grid = List.generate(
      daysPerWeek,
      (_) => List<int>.filled(weeksCount, 0),
    );

    var cursor = alignedStart;
    while (!cursor.isAfter(endDate)) {
      final row = cursor.weekday % 7;
      final col = cursor.difference(alignedStart).inDays ~/ daysPerWeek;
      if (col >= 0 && col < weeksCount) {
        grid[row][col] = intensityForDate(cursor);
      }
      cursor = cursor.add(const Duration(days: 1));
    }

    return HeatmapData(
      grid: grid,
      weeks: weeksCount,
      startDate: alignedStart,
      endDate: endDate,
      totalHabits: totalHabits,
    );
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
