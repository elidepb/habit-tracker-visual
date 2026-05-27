import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/settings/providers/locale_providers.dart';
import 'package:habit_tracker_visual/features/settings/providers/notification_providers.dart';
import 'package:habit_tracker_visual/features/settings/providers/theme_providers.dart';
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
    await syncNotifications(ref, requestPermissionIfNeeded: true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final notificationsEnabled = ref.watch(notificationsEnabledProvider);
    final permissionAsync = ref.watch(notificationPermissionProvider);
    final service = ref.watch(notificationServiceProvider);
    final themeMode = ref.watch(themeModeProvider);
    final localePreference = ref.watch(localePreferenceProvider);

    return Scaffold(
      appBar: AppBar(title: AppText.subtitle(l10n.settingsTitle)),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          AppText.subtitle(l10n.settingsAppearanceSection),
          const VGap.md(),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.subtitle(l10n.settingsThemeTitle),
                const VGap.xs(),
                AppText.caption(
                  l10n.settingsThemeSubtitle,
                ),
                const VGap.lg(),
                SegmentedButton<ThemeMode>(
                  segments: [
                    ButtonSegment(
                      value: ThemeMode.system,
                      label: Text(l10n.themeSystem),
                      icon: Icon(LucideIcons.monitor, size: 16),
                    ),
                    ButtonSegment(
                      value: ThemeMode.light,
                      label: Text(l10n.themeLight),
                      icon: Icon(LucideIcons.sun, size: 16),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      label: Text(l10n.themeDark),
                      icon: Icon(LucideIcons.moon, size: 16),
                    ),
                  ],
                  selected: {themeMode},
                  onSelectionChanged: (selection) {
                    ref
                        .read(themeModeProvider.notifier)
                        .setThemeMode(selection.first);
                  },
                ),
              ],
            ),
          ),
          const VGap.xl(),
          AppText.subtitle(l10n.settingsLanguageSection),
          const VGap.md(),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.subtitle(l10n.settingsLanguageTitle),
                const VGap.xs(),
                AppText.caption(l10n.settingsLanguageSubtitle),
                const VGap.lg(),
                SegmentedButton<String>(
                  segments: [
                    ButtonSegment(
                      value: 'system',
                      label: Text(l10n.languageSystem),
                    ),
                    ButtonSegment(
                      value: 'es',
                      label: Text(l10n.languageSpanish),
                    ),
                    ButtonSegment(
                      value: 'en',
                      label: Text(l10n.languageEnglish),
                    ),
                  ],
                  selected: {localePreference},
                  onSelectionChanged: (selection) {
                    ref
                        .read(localePreferenceProvider.notifier)
                        .setLocaleCode(selection.first);
                  },
                ),
              ],
            ),
          ),
          const VGap.xl(),
          AppText.subtitle(l10n.settingsNotificationsSection),
          const VGap.md(),
          AppCard(
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: AppText.subtitle(l10n.settingsRemindersTitle),
                  subtitle: AppText.caption(
                    l10n.settingsRemindersSubtitle,
                  ),
                  value: notificationsEnabled,
                  activeColor: AppColors.primary,
                  onChanged: service.isSupported
                      ? (value) => _toggleNotifications(ref, value)
                      : null,
                ),
                if (!service.isSupported) ...[
                  const VGap.sm(),
                  AppText.caption(
                    l10n.settingsNotificationsUnsupported,
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
                          label: l10n.settingsAllowNotifications,
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
        ],
      ),
    );
  }
}
