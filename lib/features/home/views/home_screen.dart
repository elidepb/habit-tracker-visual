import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/router/routes.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/features/habits/utils/streak_calculator.dart';
import 'package:habit_tracker_visual/features/home/widgets/home_daily_summary.dart';
import 'package:habit_tracker_visual/features/home/widgets/home_empty_state.dart';
import 'package:habit_tracker_visual/features/home/widgets/home_quick_stats.dart';
import 'package:habit_tracker_visual/features/home/widgets/habit_tile.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  int _bestStreak(List<HabitModel> habits) {
    if (habits.isEmpty) return 0;
    return habits
        .map((h) => StreakCalculator.currentStreak(h.completedDates))
        .reduce((a, b) => a > b ? a : b);
  }

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
      ),
      body: habitsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
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

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(habitsStreamProvider);
            },
            color: AppColors.primary,
            child: ListView(
              padding: AppSpacing.screenPadding,
              children: [
                HomeDailySummary(
                  completed: stats.completed,
                  total: stats.total,
                  rate: stats.rate,
                ),
                const VGap.lg(),
                HomeQuickStats(
                  completed: stats.completed,
                  total: stats.total,
                  rate: stats.rate,
                  bestStreak: _bestStreak(habits),
                ),
                const VGap.xl(),
                const AppText.subtitle('Tus hábitos'),
                const VGap.md(),
                ...habits.map(
                  (habit) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: HabitTile(habit: habit),
                  ),
                ),
                const VGap.xxxl(),
              ],
            ),
          );
        },
      ),
    );
  }
}
