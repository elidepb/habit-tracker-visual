import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_tracker_visual/core/notifications/notification_ids.dart';
import 'package:habit_tracker_visual/core/notifications/notification_schedule_rules.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/l10n/app_localizations.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService({FlutterLocalNotificationsPlugin? plugin})
      : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;

  bool get isSupported {
    if (kIsWeb) return false;
    if (Platform.environment['FLUTTER_TEST'] == 'true') return false;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  Future<void> initialize({AppLocalizations? l10n}) async {
    if (_initialized || !isSupported) return;

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      settings: const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
    );

    if (defaultTargetPlatform == TargetPlatform.android && l10n != null) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(
            AndroidNotificationChannel(
              'habit_reminders',
              l10n.notificationChannelName,
              description: l10n.notificationChannelDescription,
              importance: Importance.high,
            ),
          );
    }

    _initialized = true;
  }

  Future<bool> requestPermissions() async {
    if (!isSupported) return false;
    await initialize();

    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      final exactGranted =
          await androidPlugin?.requestExactAlarmsPermission() ?? true;
      final notificationsGranted =
          await androidPlugin?.requestNotificationsPermission() ?? false;

      return exactGranted && notificationsGranted;
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosPlugin = _plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      final granted = await iosPlugin?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    return false;
  }

  Future<bool> hasPermission() async {
    if (!isSupported) return false;
    await initialize();

    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      return await androidPlugin?.areNotificationsEnabled() ?? false;
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosPlugin = _plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      final settings = await iosPlugin?.checkPermissions();
      return settings?.isEnabled ?? false;
    }

    return false;
  }

  Future<void> scheduleHabitReminder(
    HabitModel habit, {
    required AppLocalizations l10n,
  }) async {
    if (!isSupported || !_initialized) return;
    if (habit.reminderHour == null || habit.reminderMinute == null) return;

    final id = NotificationIds.forHabit(habit.id);
    final scheduled = NotificationScheduleRules.nextOccurrence(
      hour: habit.reminderHour!,
      minute: habit.reminderMinute!,
    );

    final tzScheduled = tz.TZDateTime(
      tz.local,
      scheduled.year,
      scheduled.month,
      scheduled.day,
      scheduled.hour,
      scheduled.minute,
    );

    await _plugin.zonedSchedule(
      id: id,
      title: l10n.notificationReminderTitle,
      body: l10n.notificationReminderBody(habit.name),
      scheduledDate: tzScheduled,
      notificationDetails: _details(l10n),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelHabitReminder(String habitId) async {
    if (!isSupported) return;
    await _plugin.cancel(id: NotificationIds.forHabit(habitId));
  }

  Future<void> cancelAll() async {
    if (!isSupported) return;
    await _plugin.cancelAll();
  }

  NotificationDetails _details(AppLocalizations l10n) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'habit_reminders',
        l10n.notificationChannelName,
        channelDescription: l10n.notificationChannelDescription,
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    );
  }
}
