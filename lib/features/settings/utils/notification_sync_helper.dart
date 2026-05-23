import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/features/settings/providers/notification_providers.dart';

Future<void> syncNotifications(
  WidgetRef ref, {
  bool? notificationsEnabled,
  bool requestPermissionIfNeeded = false,
}) async {
  await ref.read(notificationSchedulerProvider).sync(
        habits: ref.read(habitsProvider),
        notificationsEnabled:
            notificationsEnabled ?? ref.read(notificationsEnabledProvider),
        requestPermissionIfNeeded: requestPermissionIfNeeded,
      );
  ref.invalidate(notificationPermissionProvider);
}
