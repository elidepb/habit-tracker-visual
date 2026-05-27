import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/animations/app_animate_extensions.dart';
import 'package:habit_tracker_visual/core/router/routes.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_radius.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_model_extensions.dart';
import 'package:habit_tracker_visual/features/habits/constants/habit_icons.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habits/providers/daily_check_providers.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/shared/widgets/confirm_delete_habit_dialog.dart';
import 'package:habit_tracker_visual/shared/widgets/habit_check_button.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HabitTile extends ConsumerWidget {
  const HabitTile({super.key, required this.habit, this.index = 0});

  final HabitModel habit;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = ref.watch(isCompletedTodayProvider(habit.id));
    final streak = ref.watch(habitStreakProvider(habit.id));

    final l10n = context.l10n;

    return Dismissible(
      key: ValueKey(habit.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) =>
          showDeleteHabitDialog(context, habitName: habit.name),
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
            HabitCheckButton(
              habitId: habit.id,
              color: habit.color,
              onToggled: (result) => showDailyCheckFeedback(context, result),
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
                        AppText.caption(habit.frequency.localizedLabel(l10n)),
                        const HGap.xs(),
                        const Icon(
                          LucideIcons.flame,
                          size: 12,
                          color: AppColors.accent,
                        ),
                        const HGap.xs(),
                        AppText.caption('$streak', color: AppColors.accent),
                      ],
                    )
                  else
                    AppText.caption(habit.frequency.localizedLabel(l10n)),
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
    ).listItemIn(index + 3);
  }
}
