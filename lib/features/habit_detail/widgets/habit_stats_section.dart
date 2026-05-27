import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/habit_detail/models/habit_statistics.dart';
import 'package:habit_tracker_visual/shared/widgets/stat_metric_card.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HabitStatsSection extends StatelessWidget {
  const HabitStatsSection({
    super.key,
    required this.stats,
    required this.accentColor,
  });

  final HabitStatistics stats;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.subtitle(l10n.habitStatsTitle),
        const VGap.md(),
        Row(
          children: [
            Expanded(
              child: StatMetricCard(
                icon: LucideIcons.flame,
                label: l10n.statBestStreak,
                value: '${stats.bestStreak}',
                suffix: l10n.unitDays,
                color: AppColors.accent,
              ),
            ),
            const HGap.md(),
            Expanded(
              child: StatMetricCard(
                icon: LucideIcons.percent,
                label: l10n.statCompletion,
                value: '${stats.completionPercent}',
                suffix: l10n.unitPercent,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
        const VGap.md(),
        Row(
          children: [
            Expanded(
              child: StatMetricCard(
                icon: LucideIcons.calendarCheck,
                label: l10n.statActiveDays,
                value: '${stats.activeDays}',
                color: accentColor,
              ),
            ),
            const HGap.md(),
            Expanded(
              child: StatMetricCard(
                icon: LucideIcons.trendingUp,
                label: l10n.statCurrentStreak,
                value: '${stats.currentStreak}',
                suffix: l10n.unitDays,
                color: AppColors.success,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
