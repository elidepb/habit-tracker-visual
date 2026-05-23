import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/animations/app_animate_extensions.dart';
import 'package:habit_tracker_visual/core/router/routes.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/features/habits/utils/streak_calculator.dart';
import 'package:habit_tracker_visual/features/home/widgets/home_daily_summary.dart';
import 'package:habit_tracker_visual/features/home/widgets/home_heatmap_section.dart';
import 'package:habit_tracker_visual/features/home/widgets/home_empty_state.dart';
import 'package:habit_tracker_visual/features/home/widgets/home_quick_stats.dart';
import 'package:habit_tracker_visual/features/home/widgets/habit_tile.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitsStreamProvider);
    final stats = ref.watch(todayStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const AppText.subtitle('Hábitos'),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.barChart2),
            tooltip: 'Estadísticas',
            onPressed: () => context.go(Routes.statistics),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.createHabit),
        tooltip: 'Nuevo hábito',
        child: const Icon(LucideIcons.plus),
      ).fadeSlideIn(delay: const Duration(milliseconds: 200)),
      body: habitsAsync.when(
        loading: () => const HomeLoadingSkeleton(),
        error: (error, _) => Center(
          child: AppText.body(
            'No se pudieron cargar los hábitos',
            color: AppColors.error,
          ),
        ),
        data: (habits) {
          if (habits.isEmpty) {
            return HomeEmptyState(
              onCreateTap: () => context.push(Routes.createHabit),
            );
          }

          final bestStreak = StreakCalculator.bestAcrossHabits(habits);

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(habitsStreamProvider);
            },
            color: AppColors.primary,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: AppSpacing.screenPadding,
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      HomeDailySummary(
                        completed: stats.completed,
                        total: stats.total,
                        rate: stats.rate,
                      ).fadeSlideIn(),
                      const VGap.lg(),
                      HomeQuickStats(
                        completed: stats.completed,
                        total: stats.total,
                        rate: stats.rate,
                        bestStreak: bestStreak,
                      ).fadeSlideIn(delay: const Duration(milliseconds: 50)),
                      const VGap.xl(),
                      const HomeHeatmapSection().fadeSlideIn(
                        delay: const Duration(milliseconds: 100),
                      ),
                      const VGap.xl(),
                      AppText.subtitle('Tus hábitos').fadeSlideIn(
                        delay: const Duration(milliseconds: 150),
                      ),
                      const VGap.md(),
                    ]),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                  ),
                  sliver: SliverList.builder(
                    itemCount: habits.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: HabitTile(habit: habits[index], index: index),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: VGap.xxxl()),
              ],
            ),
          );
        },
      ),
    );
  }
}
