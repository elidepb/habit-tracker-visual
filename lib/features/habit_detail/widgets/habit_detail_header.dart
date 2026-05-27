import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_model_extensions.dart';
import 'package:habit_tracker_visual/core/theme/app_radius.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/habits/constants/habit_icons.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habits/providers/daily_check_providers.dart';
import 'package:habit_tracker_visual/shared/widgets/habit_check_button.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';

class HabitDetailHeader extends ConsumerWidget {
  const HabitDetailHeader({super.key, required this.habit});

  final HabitModel habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final isCompleted = ref.watch(isCompletedTodayProvider(habit.id));
    final streak = ref.watch(habitStreakProvider(habit.id));

    return AppCard(
      variant: AppCardVariant.elevated,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: habit.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.main),
                ),
                child: Icon(
                  HabitIcons.fromName(habit.iconName),
                  color: habit.color,
                  size: 32,
                ),
              ),
              const HGap.lg(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.h2(habit.name),
                    const VGap.xs(),
                    AppText.caption(habit.frequency.localizedLabel(l10n)),
                  ],
                ),
              ),
              HabitCheckButton(
                habitId: habit.id,
                color: habit.color,
                size: HabitCheckSize.lg,
                onToggled: (result) => showDailyCheckFeedback(context, result),
              ),
            ],
          ),
          const VGap.lg(),
          AppText.subtitle(
            isCompleted
                ? l10n.habitStatusCompletedToday
                : l10n.habitStatusPendingToday,
          ),
          if (streak > 0) ...[
            const VGap.sm(),
            AppText.caption(
              l10n.habitCurrentStreak(streak),
              color: habit.color,
            ),
          ],
        ],
      ),
    );
  }
}
