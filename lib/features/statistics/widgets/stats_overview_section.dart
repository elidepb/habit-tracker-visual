import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/statistics/models/global_statistics.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StatsOverviewSection extends StatelessWidget {
  const StatsOverviewSection({super.key, required this.stats});

  final GlobalStatistics stats;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText.subtitle('Resumen'),
        const VGap.md(),
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                icon: LucideIcons.percent,
                label: 'Consistencia',
                value: '${stats.consistencyPercent}%',
                color: AppColors.secondary,
              ),
            ),
            const HGap.md(),
            Expanded(
              child: _MetricCard(
                icon: LucideIcons.calendarCheck,
                label: 'Días activos',
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
              child: _MetricCard(
                icon: LucideIcons.barChart2,
                label: 'Promedio semanal',
                value: stats.weeklyAverage.toStringAsFixed(1),
                color: AppColors.accent,
              ),
            ),
            const HGap.md(),
            Expanded(
              child: _MetricCard(
                icon: LucideIcons.flame,
                label: 'Mejor racha',
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

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const VGap.sm(),
          AppText.h2(value),
          const VGap.xs(),
          AppText.caption(label),
        ],
      ),
    );
  }
}
