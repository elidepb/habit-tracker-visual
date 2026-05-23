import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/settings/providers/notification_providers.dart';
import 'package:habit_tracker_visual/features/settings/utils/notification_sync_helper.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _toggleNotifications(WidgetRef ref, bool value) async {
    await ref.read(notificationsEnabledProvider.notifier).setEnabled(value);
    await syncNotifications(
      ref,
      notificationsEnabled: value,
      requestPermissionIfNeeded: value,
    );
  }

  Future<void> _requestPermissions(WidgetRef ref) async {
    final service = ref.read(notificationServiceProvider);
    await service.requestPermissions();
    await syncNotifications(ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsEnabled = ref.watch(notificationsEnabledProvider);
    final permissionAsync = ref.watch(notificationPermissionProvider);
    final service = ref.watch(notificationServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const AppText.subtitle('Ajustes')),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          const AppText.subtitle('Notificaciones'),
          const VGap.md(),
          AppCard(
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const AppText.subtitle('Recordatorios'),
                  subtitle: const AppText.caption(
                    'Avisos diarios según la hora de cada hábito',
                    color: AppColors.textSecondary,
                  ),
                  value: notificationsEnabled,
                  activeColor: AppColors.primary,
                  onChanged: service.isSupported
                      ? (value) => _toggleNotifications(ref, value)
                      : null,
                ),
                if (!service.isSupported) ...[
                  const VGap.sm(),
                  const AppText.caption(
                    'Notificaciones no disponibles en esta plataforma.',
                    color: AppColors.textSecondary,
                  ),
                ],
                permissionAsync.when(
                  data: (granted) {
                    if (granted || !notificationsEnabled) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      children: [
                        const VGap.md(),
                        AppButton(
                          label: 'Permitir notificaciones',
                          icon: LucideIcons.bell,
                          fullWidth: true,
                          onPressed: () => _requestPermissions(ref),
                        ),
                      ],
                    );
                  },
                  loading: () => const Padding(
                    padding: EdgeInsets.only(top: AppSpacing.md),
                    child: Center(child: AppLoadingIndicator()),
                  ),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          const VGap.xl(),
          const AppText.subtitle('Próximamente'),
          const VGap.md(),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SettingsRow(
                  icon: LucideIcons.palette,
                  title: 'Tema',
                  subtitle: 'Dark / Light / System',
                ),
                const Divider(),
                _SettingsRow(
                  icon: LucideIcons.cloud,
                  title: 'Backup',
                  subtitle: 'Sincronización en la nube',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 20),
          const HGap.md(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.subtitle(title),
                const VGap.xs(),
                AppText.caption(subtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
