import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';

class StatMetricCard extends StatelessWidget {
  const StatMetricCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.suffix,
    this.compact = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final String? suffix;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: compact
          ? const EdgeInsets.symmetric(horizontal: 12, vertical: 14)
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const VGap.sm(),
          if (suffix != null && suffix!.isNotEmpty)
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                AppText.h2(value),
                const HGap.xs(),
                AppText.caption(suffix!),
              ],
            )
          else
            AppText.h2(value),
          const VGap.xs(),
          AppText.caption(label),
        ],
      ),
    );
  }
}
