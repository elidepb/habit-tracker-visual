import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_radius.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/statistics/models/global_statistics.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';

class WeeklyActivityChart extends StatelessWidget {
  const WeeklyActivityChart({super.key, required this.weeklyActivity});

  final List<WeeklyActivityPoint> weeklyActivity;

  @override
  Widget build(BuildContext context) {
    if (weeklyActivity.isEmpty) {
      return const AppText.caption(
        'Sin actividad esta semana',
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
          const AppText.subtitle('Actividad semanal'),
          const VGap.xs(),
          const AppText.caption(
            'Checks completados por día (últimos 7 días)',
            color: AppColors.textSecondary,
          ),
          const VGap.lg(),
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: weeklyActivity.map((point) {
                final heightFactor =
                    maxCount > 0 ? point.completedCount / maxCount : 0.0;
                final barColor = Color.lerp(
                  AppColors.heatmapLevels[1],
                  AppColors.heatmapLevels[4],
                  point.rate,
                )!;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (point.completedCount > 0)
                          AppText.caption('${point.completedCount}'),
                        const VGap.xs(),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          height: 120 * heightFactor + (point.completedCount > 0 ? 8 : 0),
                          decoration: BoxDecoration(
                            color: barColor,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(AppRadius.input),
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
