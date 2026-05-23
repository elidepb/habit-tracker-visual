import 'package:habit_tracker_visual/core/notifications/notification_schedule_rules.dart';
import 'package:habit_tracker_visual/core/notifications/notification_service.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';

class NotificationScheduler {
  const NotificationScheduler(this._service);

  final NotificationService _service;

  Future<void> sync({
    required List<HabitModel> habits,
    required bool notificationsEnabled,
    required bool requestPermissionIfNeeded,
  }) async {
    if (!_service.isSupported) return;

    await _service.initialize();

    if (requestPermissionIfNeeded && notificationsEnabled) {
      final hasPermission = await _service.hasPermission();
      if (!hasPermission) {
        await _service.requestPermissions();
      }
    }

    await _service.cancelAll();

    if (!notificationsEnabled) return;

    final hasPermission = await _service.hasPermission();
    if (!hasPermission) return;

    for (final habit in habits) {
      if (NotificationScheduleRules.shouldSchedule(
        habit: habit,
        notificationsEnabled: notificationsEnabled,
      )) {
        await _service.scheduleHabitReminder(habit);
      }
    }
  }
}
