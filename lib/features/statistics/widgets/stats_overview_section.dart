import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/statistics/models/global_statistics.dart';
import 'package:habit_tracker_visual/shared/widgets/stat_metric_card.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StatsOverviewSection extends StatelessWidget {
  const StatsOverviewSection({super.key, required this.stats});

  final GlobalStatistics stats;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.subtitle(l10n.statsOverviewTitle),
        const VGap.md(),
        Row(
          children: [
            Expanded(
              child: StatMetricCard(
                icon: LucideIcons.percent,
                label: l10n.statConsistency,
                value: '${stats.consistencyPercent}%',
                color: AppColors.secondary,
              ),
            ),
            const HGap.md(),
            Expanded(
              child: StatMetricCard(
                icon: LucideIcons.calendarCheck,
                label: l10n.statActiveDays,
                value: '${stats.activeDays}',
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const VGap.md(),
        Row(
          children: [
            Expanded(
              child: StatMetricCard(
                icon: LucideIcons.barChart2,
                label: l10n.statWeeklyAverage,
                value: stats.weeklyAverage.toStringAsFixed(1),
                color: AppColors.accent,
              ),
            ),
            const HGap.md(),
            Expanded(
              child: StatMetricCard(
                icon: LucideIcons.flame,
                label: l10n.statBestStreak,
                value: '${stats.bestStreak}',
                color: AppColors.warning,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
