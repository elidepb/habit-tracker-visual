import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/router/routes.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/shared/widgets/feature_placeholder.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitsStreamProvider);
    final stats = ref.watch(todayStatsProvider);

    final subtitle = habitsAsync.when(
      data: (habits) {
        if (habits.isEmpty) {
          return 'Sin hábitos aún. Crea el primero con el botón +';
        }
        final percent = (stats.rate * 100).round();
        return '${habits.length} hábitos · $percent% completado hoy';
      },
      loading: () => 'Cargando hábitos...',
      error: (_, __) => 'Error al cargar hábitos',
    );

    return Scaffold(
      appBar: AppBar(title: const AppText.subtitle('Hábitos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.createHabit),
        child: const Icon(LucideIcons.plus),
      ),
      body: FeaturePlaceholder(
        title: 'Dashboard',
        subtitle: subtitle,
        icon: LucideIcons.layoutDashboard,
        child: habitsAsync.when(
          data: (habits) {
            if (habits.isEmpty) return const SizedBox.shrink();
            return ListView.separated(
              itemCount: habits.length,
              separatorBuilder: (_, __) => const VGap.md(),
              itemBuilder: (context, index) {
                final habit = habits[index];
                return AppCard(
                  onTap: () => context.push(Routes.habitDetailPath(habit.id)),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.circle,
                        color: habit.color,
                        size: 12,
                      ),
                      const HGap.md(),
                      Expanded(
                        child: AppText.subtitle(habit.name),
                      ),
                      if (habit.isCompletedToday())
                        const Icon(
                          LucideIcons.check,
                          color: AppColors.success,
                          size: 20,
                        ),
                    ],
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
