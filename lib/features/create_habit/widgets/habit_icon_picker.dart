import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_model_extensions.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_radius.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/habits/constants/habit_icons.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/app_text.dart';

class HabitIconPicker extends StatelessWidget {
  const HabitIconPicker({
    super.key,
    required this.selectedIconName,
    required this.accentColor,
    required this.onIconSelected,
  });

  final String selectedIconName;
  final Color accentColor;
  final ValueChanged<String> onIconSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.subtitle(l10n.formIconLabel, color: AppColors.textPrimary),
        const VGap.md(),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: HabitIcons.options.map((option) {
            final isSelected = option.name == selectedIconName;

            return GestureDetector(
              onTap: () => onIconSelected(option.name),
              child: Tooltip(
                message: localizedIconLabel(option.name, l10n),
                child: Semantics(
                  label: localizedIconLabel(option.name, l10n),
                  button: true,
                  selected: isSelected,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? accentColor.withValues(alpha: 0.2)
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.main),
                      border: Border.all(
                        color: isSelected ? accentColor : AppColors.border,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Icon(
                      option.icon,
                      color: isSelected ? accentColor : AppColors.textSecondary,
                      size: 22,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
