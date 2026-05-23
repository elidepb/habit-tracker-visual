import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final stats = ref.watch(globalStatisticsProvider);

    if (stats.totalHabits == 0) {
      return Scaffold(
        appBar: AppBar(title: const AppText.subtitle('Estadísticas')),
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
                ),
                const VGap.lg(),
                const AppText.subtitle('Sin datos aún'),
                const VGap.sm(),
                const AppText.body(
                  'Crea hábitos y registra checks para ver tus estadísticas globales.',
                  color: AppColors.textSecondary,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const AppText.subtitle('Estadísticas')),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          StatsOverviewSection(stats: stats),
          const VGap.xl(),
          WeeklyActivityChart(weeklyActivity: stats.weeklyActivity),
          const VGap.xl(),
          HabitRankingList(rankings: stats.rankings),
          const VGap.xxxl(),
        ],
      ),
    );
  }
}
