import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_frequency.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/app_text.dart';

class HabitFrequencySelector extends StatelessWidget {
  const HabitFrequencySelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final HabitFrequency selected;
  final ValueChanged<HabitFrequency> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText.subtitle('Frecuencia', color: AppColors.textPrimary),
        const VGap.md(),
        SegmentedButton<HabitFrequency>(
          segments: HabitFrequency.values
              .map(
                (f) => ButtonSegment(
                  value: f,
                  label: Text(f.label),
                ),
              )
              .toList(),
          selected: {selected},
          onSelectionChanged: (values) => onChanged(values.first),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.primary.withValues(alpha: 0.2);
              }
              return AppColors.surface;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.primary;
              }
              return AppColors.textSecondary;
            }),
          ),
        ),
      ],
    );
  }
}
