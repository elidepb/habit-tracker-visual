import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/core/theme/app_palette.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/app_text.dart';

class HeatmapLegend extends StatelessWidget {
  const HeatmapLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.appPalette;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText.caption(l10n.heatmapLegendLess),
        const HGap.sm(),
        ...palette.heatmapLevels.map(
          (color) => Padding(
            padding: const EdgeInsets.only(right: AppSpacing.xs),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: palette.border.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
        ),
        const HGap.sm(),
        AppText.caption(l10n.heatmapLegendMore),
      ],
    );
  }
}
