import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeEmptyState extends StatelessWidget {
  const HomeEmptyState({super.key, required this.onCreateTap});

  final VoidCallback onCreateTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
        child: Column(
          children: [
            Icon(
              LucideIcons.layoutList,
              size: 48,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
            const VGap.lg(),
            const AppText.subtitle('Sin hábitos aún'),
            const VGap.sm(),
            const AppText.body(
              'Crea tu primer hábito para empezar a trackear tu progreso.',
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ),
            const VGap.xl(),
            AppButton(
              label: 'Crear hábito',
              icon: LucideIcons.plus,
              onPressed: onCreateTap,
            ),
          ],
        ),
      ),
    );
  }
}
