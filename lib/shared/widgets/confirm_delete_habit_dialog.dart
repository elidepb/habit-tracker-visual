import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';

Future<bool> showDeleteHabitDialog(
  BuildContext context, {
  String? habitName,
}) async {
  final l10n = context.l10n;
  final message = habitName != null
      ? l10n.deleteHabitMessageNamed(habitName)
      : l10n.deleteHabitMessageGeneric;

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.surface,
      title: AppText.subtitle(l10n.deleteHabitTitle),
      content: AppText.body(message, color: AppColors.textSecondary),
      actions: [
        AppButton(
          label: l10n.cancel,
          variant: AppButtonVariant.ghost,
          size: AppButtonSize.sm,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        AppButton(
          label: l10n.delete,
          variant: AppButtonVariant.danger,
          size: AppButtonSize.sm,
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );

  return confirmed ?? false;
}
