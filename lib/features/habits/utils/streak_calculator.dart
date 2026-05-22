import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';

abstract final class StreakCalculator {
  static int currentStreak(List<String> completedDates) {
    if (completedDates.isEmpty) return 0;

    final dates = completedDates.toSet();
    var cursor = DateTime.now();
    final todayKey = HabitModel.dateKey(cursor);

    if (!dates.contains(todayKey)) {
      cursor = cursor.subtract(const Duration(days: 1));
    }

    var streak = 0;
    while (dates.contains(HabitModel.dateKey(cursor))) {
      streak++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return streak;
  }

  static int bestStreak(List<String> completedDates) {
    if (completedDates.isEmpty) return 0;

    final sorted = completedDates.toList()..sort();
    var best = 1;
    var current = 1;

    for (var i = 1; i < sorted.length; i++) {
      final previous = _parseDate(sorted[i - 1]);
      final currentDate = _parseDate(sorted[i]);
      final diff = currentDate.difference(previous).inDays;

      if (diff == 1) {
        current++;
        if (current > best) best = current;
      } else if (diff > 1) {
        current = 1;
      }
    }

    return best;
  }

  static DateTime _parseDate(String key) {
    final parts = key.split('-');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }
}
