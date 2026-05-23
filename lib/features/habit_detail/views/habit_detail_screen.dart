import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/router/routes.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/habits/constants/habit_icons.dart';
import 'package:habit_tracker_visual/features/habits/providers/daily_check_providers.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/shared/widgets/habit_check_button.dart';
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

    final isCompleted = ref.watch(isCompletedTodayProvider(habitId));
    final streak = ref.watch(habitStreakProvider(habitId));
    final completedCount = habit.completedDates.length;

    return Scaffold(
      appBar: AppBar(
        title: AppText.subtitle(habit.name),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              variant: AppCardVariant.elevated,
              child: Column(
                children: [
                  HabitCheckButton(
                    habitId: habitId,
                    color: habit.color,
                    size: HabitCheckSize.lg,
                    onToggled: (result) => showDailyCheckFeedback(context, result),
                  ),
                  const VGap.lg(),
                  AppText.subtitle(
                    isCompleted ? 'Completado hoy' : 'Marcar como completado',
                  ),
                  const VGap.xs(),
                  AppText.caption(
                    isCompleted
                        ? '¡Buen trabajo! Vuelve mañana para mantener la racha.'
                        : 'Toca el círculo para registrar el check de hoy.',
                  ),
                  if (streak > 0) ...[
                    const VGap.md(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          LucideIcons.flame,
                          color: AppColors.accent,
                          size: 16,
                        ),
                        const HGap.xs(),
                        AppText.caption(
                          'Racha actual: $streak días',
                          color: AppColors.accent,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const VGap.lg(),
            AppCard(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: habit.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      HabitIcons.fromName(habit.iconName),
                      color: habit.color,
                      size: 28,
                    ),
                  ),
                  const HGap.lg(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.h2(habit.name),
                        const VGap.xs(),
                        AppText.caption(habit.frequency.label),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const VGap.lg(),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText.subtitle('Resumen'),
                  const VGap.md(),
                  _DetailRow(
                    label: 'Estado hoy',
                    value: isCompleted ? 'Completado' : 'Pendiente',
                  ),
                  const VGap.sm(),
                  _DetailRow(
                    label: 'Días registrados',
                    value: '$completedCount',
                  ),
                  if (streak > 0) ...[
                    const VGap.sm(),
                    _DetailRow(label: 'Racha actual', value: '$streak días'),
                  ],
                  if (habit.reminderEnabled) ...[
                    const VGap.sm(),
                    _DetailRow(
                      label: 'Recordatorio',
                      value: _formatReminder(
                        habit.reminderHour,
                        habit.reminderMinute,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Spacer(),
            AppText.caption(
              'Heatmap y estadísticas detalladas — PR-08.',
              color: AppColors.textSecondary,
            ),
            const VGap.xl(),
            AppButton(
              label: 'Editar',
              variant: AppButtonVariant.secondary,
              icon: LucideIcons.pencil,
              fullWidth: true,
              onPressed: () => context.push(Routes.editHabitPath(habitId)),
            ),
            const VGap.md(),
            AppButton(
              label: 'Eliminar',
              variant: AppButtonVariant.danger,
              icon: LucideIcons.trash2,
              fullWidth: true,
              onPressed: () => _confirmDelete(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  static String _formatReminder(int? hour, int? minute) {
    if (hour == null || minute == null) return '—';
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.body(label, color: AppColors.textSecondary),
        AppText.body(value),
      ],
    );
  }
}
