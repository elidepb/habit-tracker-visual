import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
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
          child: _StatCard(
            icon: LucideIcons.checkCircle2,
            label: 'Completados',
            value: '$completed/$total',
            color: AppColors.success,
          ),
        ),
        const HGap.md(),
        Expanded(
          child: _StatCard(
            icon: LucideIcons.percent,
            label: 'Progreso',
            value: '$percent%',
            color: AppColors.secondary,
          ),
        ),
        const HGap.md(),
        Expanded(
          child: _StatCard(
            icon: LucideIcons.flame,
            label: 'Mejor racha',
            value: '$bestStreak',
            color: AppColors.accent,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
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
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
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
