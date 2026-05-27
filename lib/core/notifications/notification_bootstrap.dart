import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/features/settings/providers/locale_providers.dart';
import 'package:habit_tracker_visual/features/settings/providers/notification_providers.dart';

class NotificationBootstrap extends ConsumerStatefulWidget {
  const NotificationBootstrap({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<NotificationBootstrap> createState() =>
      _NotificationBootstrapState();
}

class _NotificationBootstrapState extends ConsumerState<NotificationBootstrap> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _sync());
  }

  bool _shouldRequestPermission(
    List<HabitModel> habits,
    bool notificationsEnabled,
  ) {
    return notificationsEnabled &&
        habits.any((habit) => habit.reminderEnabled);
  }

  Future<void> _sync({bool requestPermission = false}) async {
    final habits = ref.read(habitsProvider);
    final enabled = ref.read(notificationsEnabledProvider);

    await ref.read(notificationSchedulerProvider).sync(
          habits: habits,
          notificationsEnabled: enabled,
          requestPermissionIfNeeded: requestPermission ||
              _shouldRequestPermission(habits, enabled),
          l10n: ref.read(appLocalizationsProvider),
        );
    ref.invalidate(notificationPermissionProvider);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(habitsStreamProvider, (_, next) {
      if (next.hasValue) {
        _sync(
          requestPermission: _shouldRequestPermission(
            next.requireValue,
            ref.read(notificationsEnabledProvider),
          ),
        );
      }
    });
    ref.listen(notificationsEnabledProvider, (_, enabled) {
      _sync(requestPermission: enabled);
    });

    return widget.child;
  }
}
