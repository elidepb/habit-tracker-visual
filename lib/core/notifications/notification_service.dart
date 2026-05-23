import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_tracker_visual/core/notifications/notification_ids.dart';
import 'package:habit_tracker_visual/core/notifications/notification_schedule_rules.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
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

  Future<void> initialize() async {
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

    _initialized = true;
  }

  Future<bool> requestPermissions() async {
    if (!isSupported) return false;

    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      final granted = await androidPlugin?.requestNotificationsPermission();
      return granted ?? false;
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

  Future<void> scheduleHabitReminder(HabitModel habit) async {
    if (!isSupported || !_initialized) return;
    if (habit.reminderHour == null || habit.reminderMinute == null) return;

    final id = NotificationIds.forHabit(habit.id);
    final scheduled = NotificationScheduleRules.nextOccurrence(
      hour: habit.reminderHour!,
      minute: habit.reminderMinute!,
    );

    final tzScheduled = tz.TZDateTime.from(scheduled, tz.local);

    await _plugin.zonedSchedule(
      id: id,
      title: 'Recordatorio de hábito',
      body: 'Es hora de completar: ${habit.name}',
      scheduledDate: tzScheduled,
      notificationDetails: _details(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
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

  NotificationDetails _details() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'habit_reminders',
        'Recordatorios de hábitos',
        channelDescription: 'Avisos diarios para completar tus hábitos',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }
}
