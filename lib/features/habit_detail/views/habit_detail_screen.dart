import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/animations/app_animate_extensions.dart';
import 'package:habit_tracker_visual/core/router/routes.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/habit_detail/providers/habit_detail_providers.dart';
import 'package:habit_tracker_visual/features/habit_detail/widgets/habit_detail_header.dart';
import 'package:habit_tracker_visual/features/habit_detail/widgets/habit_history_calendar.dart';
import 'package:habit_tracker_visual/features/habit_detail/widgets/habit_stats_section.dart';
import 'package:habit_tracker_visual/features/heatmap/providers/heatmap_providers.dart';
import 'package:habit_tracker_visual/features/heatmap/widgets/contribution_heatmap.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HabitDetailScreen extends ConsumerWidget {
  const HabitDetailScreen({super.key, required this.habitId});

  final String habitId;

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const AppText.subtitle('Eliminar hábito'),
        content: const AppText.body(
          'Esta acción no se puede deshacer. ¿Deseas eliminar este hábito?',
          color: AppColors.textSecondary,
        ),
        actions: [
          AppButton(
            label: 'Cancelar',
            variant: AppButtonVariant.ghost,
            size: AppButtonSize.sm,
            onPressed: () => Navigator.of(context).pop(false),
          ),
          AppButton(
            label: 'Eliminar',
            variant: AppButtonVariant.danger,
            size: AppButtonSize.sm,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    await ref.read(habitRepositoryProvider).delete(habitId);
    if (!context.mounted) return;
    context.pop();
  }

  static String _formatReminder(int? hour, int? minute) {
    if (hour == null || minute == null) return '—';
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habit = ref.watch(habitByIdProvider(habitId));

    if (habit == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(child: AppText.body('Hábito no encontrado')),
      );
    }

    final stats = ref.watch(habitStatisticsProvider(habitId));
    final heatmap = ref.watch(habitHeatmapProvider(habitId));

    return Scaffold(
      appBar: AppBar(
        title: AppText.subtitle(habit.name),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.pencil),
            tooltip: 'Editar',
            onPressed: () => context.push(Routes.editHabitPath(habitId)),
          ),
        ],
      ),
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: [
          HabitDetailHeader(habit: habit).fadeSlideIn(),
          const VGap.xl(),
          HabitStatsSection(stats: stats, accentColor: habit.color).fadeSlideIn(
            delay: const Duration(milliseconds: 60),
          ),
          const VGap.xl(),
          AppText.subtitle('Actividad anual').fadeSlideIn(
            delay: const Duration(milliseconds: 100),
          ),
          const VGap.md(),
          AppCard(
            child: ContributionHeatmap(
              data: heatmap,
              cellSize: 14,
              intensityLabel: (level) =>
                  level > 0 ? 'Completado' : 'Sin completar',
            ),
          ).fadeSlideIn(delay: const Duration(milliseconds: 120)),
          const VGap.xl(),
          AppText.subtitle('Historial').fadeSlideIn(
            delay: const Duration(milliseconds: 140),
          ),
          const VGap.md(),
          HabitHistoryCalendar(
            habitId: habitId,
            accentColor: habit.color,
            createdAt: habit.createdAt,
          ).fadeSlideIn(delay: const Duration(milliseconds: 160)),
          if (habit.reminderEnabled) ...[
            const VGap.lg(),
            AppCard(
              child: Row(
                children: [
                  const Icon(
                    LucideIcons.bell,
                    color: AppColors.textSecondary,
                    size: 18,
                  ),
                  const HGap.md(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppText.subtitle('Recordatorio'),
                        const VGap.xs(),
                        AppText.caption(
                          _formatReminder(
                            habit.reminderHour,
                            habit.reminderMinute,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          const VGap.xxxl(),
          AppButton(
            label: 'Editar hábito',
            variant: AppButtonVariant.secondary,
            icon: LucideIcons.pencil,
            fullWidth: true,
            onPressed: () => context.push(Routes.editHabitPath(habitId)),
          ).fadeSlideIn(delay: const Duration(milliseconds: 200)),
          const VGap.md(),
          AppButton(
            label: 'Eliminar hábito',
            variant: AppButtonVariant.danger,
            icon: LucideIcons.trash2,
            fullWidth: true,
            onPressed: () => _confirmDelete(context, ref),
          ).fadeSlideIn(delay: const Duration(milliseconds: 240)),
          const VGap.xl(),
        ],
      ),
    );
  }
}
