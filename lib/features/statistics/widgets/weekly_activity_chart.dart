import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_palette.dart';
import 'package:habit_tracker_visual/core/theme/app_radius.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/statistics/models/global_statistics.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';

class WeeklyActivityChart extends StatelessWidget {
  const WeeklyActivityChart({super.key, required this.weeklyActivity});

  static const _chartHeight = 160.0;

  final List<WeeklyActivityPoint> weeklyActivity;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (weeklyActivity.isEmpty) {
      return AppText.caption(
        l10n.weeklyChartEmpty,
        color: AppColors.textSecondary,
      );
    }

    final maxCount = weeklyActivity
        .map((p) => p.completedCount)
        .fold(1, (a, b) => a > b ? a : b);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.subtitle(l10n.weeklyChartTitle),
          const VGap.xs(),
          AppText.caption(
            l10n.weeklyChartSubtitle,
            color: AppColors.textSecondary,
          ),
          const VGap.lg(),
          SizedBox(
            height: _chartHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: weeklyActivity.map((point) {
                final heightFactor =
                    maxCount > 0 ? point.completedCount / maxCount : 0.0;
                final barColor = Color.lerp(
                  context.appPalette.heatmapLevels[1],
                  context.appPalette.heatmapLevels[4],
                  point.rate,
                )!;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      children: [
                        if (point.completedCount > 0)
                          AppText.caption('${point.completedCount}'),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: FractionallySizedBox(
                              heightFactor: point.completedCount > 0
                                  ? heightFactor.clamp(0.08, 1.0)
                                  : 0,
                              widthFactor: 1,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                decoration: BoxDecoration(
                                  color: barColor,
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(AppRadius.input),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const VGap.sm(),
                        AppText.caption(
                          point.label,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
