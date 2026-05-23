import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';

Future<bool> showDeleteHabitDialog(
  BuildContext context, {
  String? habitName,
}) async {
  final message = habitName != null
      ? '¿Eliminar "$habitName"? Esta acción no se puede deshacer.'
      : 'Esta acción no se puede deshacer. ¿Deseas eliminar este hábito?';

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.surface,
      title: const AppText.subtitle('Eliminar hábito'),
      content: AppText.body(message, color: AppColors.textSecondary),
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
