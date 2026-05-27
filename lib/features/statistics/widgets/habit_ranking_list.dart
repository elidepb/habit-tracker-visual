import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
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
    final l10n = context.l10n;

    if (rankings.isEmpty) {
      return AppText.caption(
        l10n.habitRankingEmpty,
        color: AppColors.textSecondary,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.subtitle(l10n.habitRankingTitle),
        const VGap.xs(),
        AppText.caption(
          l10n.habitRankingSubtitle,
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
                    width: 24,
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
                  const HGap.sm(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.subtitle(
                          ranking.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const VGap.xs(),
                        Wrap(
                          spacing: AppSpacing.xs,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            AppText.caption(
                              l10n.habitRankingCompletion(
                                ranking.completionPercent,
                              ),
                            ),
                            if (ranking.currentStreak > 0) ...[
                              const Icon(
                                LucideIcons.flame,
                                size: 12,
                                color: AppColors.accent,
                              ),
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
                  const HGap.sm(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _CompletionBadge(percent: ranking.completionPercent),
                      const HGap.xs(),
                      Icon(
                        LucideIcons.chevronRight,
                        size: 16,
                        color: AppColors.textSecondary.withValues(alpha: 0.6),
                      ),
                    ],
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
