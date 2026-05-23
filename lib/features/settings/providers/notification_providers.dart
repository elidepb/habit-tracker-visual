import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/core/notifications/notification_scheduler.dart';
import 'package:habit_tracker_visual/core/notifications/notification_service.dart';
import 'package:habit_tracker_visual/features/settings/repositories/settings_repository.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

final notificationSchedulerProvider = Provider<NotificationScheduler>((ref) {
  return NotificationScheduler(ref.watch(notificationServiceProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository();
});

class NotificationsEnabledNotifier extends Notifier<bool> {
  @override
  bool build() {
    return ref.read(settingsRepositoryProvider).notificationsEnabled;
  }

  Future<void> setEnabled(bool enabled) async {
    await ref.read(settingsRepositoryProvider).setNotificationsEnabled(enabled);
    state = enabled;
  }
}

final notificationsEnabledProvider =
    NotifierProvider<NotificationsEnabledNotifier, bool>(
  NotificationsEnabledNotifier.new,
);

final notificationPermissionProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(notificationServiceProvider);
  if (!service.isSupported) return false;
  await service.initialize();
  return service.hasPermission();
});
