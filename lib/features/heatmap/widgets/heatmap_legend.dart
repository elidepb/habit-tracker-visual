import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/app_text.dart';

class HeatmapLegend extends StatelessWidget {
  const HeatmapLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AppText.caption('Menos'),
        const HGap.sm(),
        ...AppColors.heatmapLevels.map(
          (color) => Padding(
            padding: const EdgeInsets.only(right: AppSpacing.xs),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: AppColors.border.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
        ),
        const HGap.sm(),
        const AppText.caption('Más'),
      ],
    );
  }
}
