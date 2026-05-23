import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/core/notifications/notification_ids.dart';
import 'package:habit_tracker_visual/core/notifications/notification_schedule_rules.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';

void main() {
  group('NotificationIds', () {
    test('genera id estable por hábito', () {
      expect(NotificationIds.forHabit('abc'), NotificationIds.forHabit('abc'));
      expect(NotificationIds.forHabit('abc'), isNot(NotificationIds.forHabit('xyz')));
    });
  });

  group('NotificationScheduleRules', () {
    test('shouldSchedule requiere recordatorio configurado', () {
      final habit = HabitModel.create(name: 'Leer');
      expect(
        NotificationScheduleRules.shouldSchedule(
          habit: habit,
          notificationsEnabled: true,
        ),
        isFalse,
      );

      final withReminder = habit.copyWith(
        reminderEnabled: true,
        reminderHour: 9,
        reminderMinute: 0,
      );
      expect(
        NotificationScheduleRules.shouldSchedule(
          habit: withReminder,
          notificationsEnabled: true,
        ),
        isTrue,
      );
    });

    test('nextOccurrence programa para mañana si la hora ya pasó', () {
      final from = DateTime(2026, 5, 22, 15, 0);
      final next = NotificationScheduleRules.nextOccurrence(
        hour: 9,
        minute: 0,
        from: from,
      );

      expect(next.day, 23);
      expect(next.hour, 9);
    });
  });
}
