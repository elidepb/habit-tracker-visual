import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/shared/widgets/stat_metric_card.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeQuickStats extends StatelessWidget {
  const HomeQuickStats({
    super.key,
    required this.completed,
    required this.total,
    required this.rate,
    required this.bestStreak,
  });

  final int completed;
  final int total;
  final double rate;
  final int bestStreak;

  @override
  Widget build(BuildContext context) {
    final percent = (rate * 100).round();

    return Row(
      children: [
        Expanded(
          child: StatMetricCard(
            icon: LucideIcons.checkCircle2,
            label: 'Completados',
            value: '$completed/$total',
            color: AppColors.success,
            compact: true,
          ),
        ),
        const HGap.md(),
        Expanded(
          child: StatMetricCard(
            icon: LucideIcons.percent,
            label: 'Progreso',
            value: '$percent%',
            color: AppColors.secondary,
            compact: true,
          ),
        ),
        const HGap.md(),
        Expanded(
          child: StatMetricCard(
            icon: LucideIcons.flame,
            label: 'Mejor racha',
            value: '$bestStreak',
            color: AppColors.accent,
            compact: true,
          ),
        ),
      ],
    );
  }
}
