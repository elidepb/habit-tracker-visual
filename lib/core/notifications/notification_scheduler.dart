import 'package:flutter/foundation.dart';
import 'package:habit_tracker_visual/core/notifications/notification_schedule_rules.dart';
import 'package:habit_tracker_visual/core/notifications/notification_service.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/l10n/app_localizations.dart';

class NotificationScheduler {
  const NotificationScheduler(this._service);

  final NotificationService _service;

  Future<void> sync({
    required List<HabitModel> habits,
    required bool notificationsEnabled,
    required bool requestPermissionIfNeeded,
    required AppLocalizations l10n,
  }) async {
    if (!_service.isSupported) return;

    await _service.initialize(l10n: l10n);

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
        try {
          await _service.scheduleHabitReminder(habit, l10n: l10n);
        } catch (error, stackTrace) {
          debugPrint(
            'No se pudo programar recordatorio para ${habit.name}: $error',
          );
          debugPrint('$stackTrace');
        }
      }
    }
  }
}
