import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/router/routes.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_durations.dart';
import 'package:habit_tracker_visual/core/theme/app_radius.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/habits/constants/habit_icons.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/features/habits/utils/streak_calculator.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HabitTile extends ConsumerStatefulWidget {
  const HabitTile({super.key, required this.habit});

  final HabitModel habit;

  @override
  ConsumerState<HabitTile> createState() => _HabitTileState();
}

class _HabitTileState extends ConsumerState<HabitTile> {
  bool _isToggling = false;

  Future<void> _toggleCompletion() async {
    if (_isToggling) return;
    setState(() => _isToggling = true);

    await ref
        .read(habitRepositoryProvider)
        .toggleCompletion(widget.habit.id, DateTime.now());

    if (mounted) setState(() => _isToggling = false);
  }

  Future<bool> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const AppText.subtitle('Eliminar hábito'),
        content: AppText.body(
          '¿Eliminar "${widget.habit.name}"? Esta acción no se puede deshacer.',
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
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final habit = widget.habit;
    final isCompleted = habit.isCompletedToday();
    final streak = StreakCalculator.currentStreak(habit.completedDates);

    return Dismissible(
      key: ValueKey(habit.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _confirmDelete(),
      onDismissed: (_) {
        ref.read(habitRepositoryProvider).delete(habit.id);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        child: const Icon(LucideIcons.trash2, color: AppColors.error),
      ),
      child: AppCard(
        onTap: () => context.push(Routes.habitDetailPath(habit.id)),
        child: Row(
          children: [
            _CompletionButton(
              isCompleted: isCompleted,
              color: habit.color,
              isLoading: _isToggling,
              onTap: _toggleCompletion,
            ),
            const HGap.lg(),
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: habit.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.main),
              ),
              child: Icon(
                HabitIcons.fromName(habit.iconName),
                color: habit.color,
                size: 20,
              ),
            ),
            const HGap.md(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.subtitle(
                    habit.name,
                    color: isCompleted
                        ? AppColors.textSecondary
                        : AppColors.textPrimary,
                  ),
                  const VGap.xs(),
                  if (streak > 0)
                    Row(
                      children: [
                        AppText.caption(habit.frequency.label),
                        const HGap.xs(),
                        Icon(
                          LucideIcons.flame,
                          size: 12,
                          color: AppColors.accent,
                        ),
                        const HGap.xs(),
                        AppText.caption(
                          '$streak',
                          color: AppColors.accent,
                        ),
                      ],
                    )
                  else
                    AppText.caption(habit.frequency.label),
                ],
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              color: AppColors.textSecondary.withValues(alpha: 0.6),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _CompletionButton extends StatelessWidget {
  const _CompletionButton({
    required this.isCompleted,
    required this.color,
    required this.isLoading,
    required this.onTap,
  });

  final bool isCompleted;
  final Color color;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: AppDurations.normal,
        curve: Curves.easeOut,
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isCompleted ? color : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: isCompleted ? color : AppColors.border,
            width: 2,
          ),
        ),
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.all(6),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isCompleted ? Colors.white : color,
                ),
              )
            : isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : null,
      ),
    );
  }
}
