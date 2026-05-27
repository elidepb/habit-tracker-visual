import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/core/animations/app_animate_extensions.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/statistics/providers/statistics_providers.dart';
import 'package:habit_tracker_visual/features/statistics/widgets/habit_ranking_list.dart';
import 'package:habit_tracker_visual/features/statistics/widgets/stats_overview_section.dart';
import 'package:habit_tracker_visual/features/statistics/widgets/weekly_activity_chart.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final stats = ref.watch(globalStatisticsProvider);

    if (stats.totalHabits == 0) {
      return Scaffold(
        appBar: AppBar(title: AppText.subtitle(l10n.statisticsTitle)),
        body: Center(
          child: Padding(
            padding: AppSpacing.screenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LucideIcons.barChart2,
                  size: 48,
                  color: AppColors.textSecondary.withValues(alpha: 0.5),
                ).fadeSlideIn(),
                const VGap.lg(),
                AppText.subtitle(l10n.statisticsEmptyTitle).fadeSlideIn(
                  delay: const Duration(milliseconds: 60),
                ),
                const VGap.sm(),
                AppText.body(
                  l10n.statisticsEmptyBody,
                  color: AppColors.textSecondary,
                  textAlign: TextAlign.center,
                ).fadeSlideIn(delay: const Duration(milliseconds: 120)),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: AppText.subtitle(l10n.statisticsTitle)),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          StatsOverviewSection(stats: stats).fadeSlideIn(),
          const VGap.xl(),
          WeeklyActivityChart(weeklyActivity: stats.weeklyActivity).fadeSlideIn(
            delay: const Duration(milliseconds: 80),
          ),
          const VGap.xl(),
          HabitRankingList(rankings: stats.rankings).fadeSlideIn(
            delay: const Duration(milliseconds: 160),
          ),
          const VGap.xxxl(),
        ],
      ),
    );
  }
}
