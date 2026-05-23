import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/router/routes.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_radius.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/habits/constants/habit_icons.dart';
import 'package:habit_tracker_visual/features/statistics/models/global_statistics.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HabitRankingList extends StatelessWidget {
  const HabitRankingList({super.key, required this.rankings});

  final List<HabitRanking> rankings;

  @override
  Widget build(BuildContext context) {
    if (rankings.isEmpty) {
      return const AppText.caption(
        'Crea hábitos para ver el ranking',
        color: AppColors.textSecondary,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText.subtitle('Ranking de hábitos'),
        const VGap.xs(),
        const AppText.caption(
          'Ordenados por tasa de cumplimiento',
          color: AppColors.textSecondary,
        ),
        const VGap.md(),
        ...rankings.asMap().entries.map((entry) {
          final index = entry.key;
          final ranking = entry.value;
          final color = Color(ranking.colorValue);

          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: AppCard(
              onTap: () => context.push(Routes.habitDetailPath(ranking.habitId)),
              child: Row(
                children: [
                  SizedBox(
                    width: 28,
                    child: AppText.subtitle(
                      '${index + 1}',
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadius.main),
                    ),
                    child: Icon(
                      HabitIcons.fromName(ranking.iconName),
                      color: color,
                      size: 18,
                    ),
                  ),
                  const HGap.md(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.subtitle(ranking.name),
                        const VGap.xs(),
                        Row(
                          children: [
                            AppText.caption(
                              '${ranking.completionPercent}% cumplimiento',
                            ),
                            if (ranking.currentStreak > 0) ...[
                              const AppText.caption(' · '),
                              const Icon(
                                LucideIcons.flame,
                                size: 12,
                                color: AppColors.accent,
                              ),
                              const HGap.xs(),
                              AppText.caption(
                                '${ranking.currentStreak}',
                                color: AppColors.accent,
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  _CompletionBadge(percent: ranking.completionPercent),
                  const HGap.sm(),
                  Icon(
                    LucideIcons.chevronRight,
                    size: 16,
                    color: AppColors.textSecondary.withValues(alpha: 0.6),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _CompletionBadge extends StatelessWidget {
  const _CompletionBadge({required this.percent});

  final int percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.input),
      ),
      child: AppText.caption(
        '$percent%',
        color: AppColors.primary,
      ),
    );
  }
}
