import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_radius.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/app_text.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HabitReminderSection extends StatelessWidget {
  const HabitReminderSection({
    super.key,
    required this.enabled,
    required this.time,
    required this.onEnabledChanged,
    required this.onTimeSelected,
  });

  final bool enabled;
  final TimeOfDay? time;
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<TimeOfDay> onTimeSelected;

  String _formatTime(TimeOfDay? value) {
    if (value == null) return 'Seleccionar hora';
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: time ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              surface: AppColors.surface,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) onTimeSelected(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const AppText.subtitle(
            'Recordatorio',
            color: AppColors.textPrimary,
          ),
          subtitle: const AppText.caption('Recibe un aviso diario'),
          value: enabled,
          activeColor: AppColors.primary,
          onChanged: onEnabledChanged,
        ),
        if (enabled) ...[
          const VGap.sm(),
          InkWell(
            onTap: () => _pickTime(context),
            borderRadius: BorderRadius.circular(AppRadius.input),
            child: Container(
              width: double.infinity,
              padding: AppSpacing.inputPadding,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.input),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Icon(
                    LucideIcons.clock,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  const HGap.md(),
                  AppText.body(_formatTime(time)),
                  const Spacer(),
                  const Icon(
                    LucideIcons.chevronDown,
                    color: AppColors.textSecondary,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
