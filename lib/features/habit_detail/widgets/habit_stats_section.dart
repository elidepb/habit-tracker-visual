import 'package:flutter/material.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText.subtitle('Estadísticas'),
        const VGap.md(),
        Row(
          children: [
            Expanded(
              child: StatMetricCard(
                icon: LucideIcons.flame,
                label: 'Mejor racha',
                value: '${stats.bestStreak}',
                suffix: 'días',
                color: AppColors.accent,
              ),
            ),
            const HGap.md(),
            Expanded(
              child: StatMetricCard(
                icon: LucideIcons.percent,
                label: 'Cumplimiento',
                value: '${stats.completionPercent}',
                suffix: '%',
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
                label: 'Días activos',
                value: '${stats.activeDays}',
                color: accentColor,
              ),
            ),
            const HGap.md(),
            Expanded(
              child: StatMetricCard(
                icon: LucideIcons.trendingUp,
                label: 'Racha actual',
                value: '${stats.currentStreak}',
                suffix: 'días',
                color: AppColors.success,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
