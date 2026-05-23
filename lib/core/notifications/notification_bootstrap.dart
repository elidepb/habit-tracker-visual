import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
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

  Future<void> _sync({bool requestPermission = false}) async {
    final habits = ref.read(habitsProvider);
    final enabled = ref.read(notificationsEnabledProvider);
    await ref.read(notificationSchedulerProvider).sync(
        habits: habits,
        notificationsEnabled: enabled,
        requestPermissionIfNeeded: requestPermission,
      );
    ref.invalidate(notificationPermissionProvider);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(habitsStreamProvider, (_, __) => _sync());
    ref.listen(notificationsEnabledProvider, (_, __) => _sync());

    return widget.child;
  }
}
