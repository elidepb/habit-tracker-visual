import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';

abstract final class NotificationScheduleRules {
  static bool shouldSchedule({
    required HabitModel habit,
    required bool notificationsEnabled,
  }) {
    if (!notificationsEnabled) return false;
    if (!habit.reminderEnabled) return false;
    if (habit.reminderHour == null || habit.reminderMinute == null) {
      return false;
    }
    return true;
  }

  static DateTime nextOccurrence({
    required int hour,
    required int minute,
    DateTime? from,
  }) {
    final now = from ?? DateTime.now();
    var scheduled = DateTime(now.year, now.month, now.day, hour, minute);
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
