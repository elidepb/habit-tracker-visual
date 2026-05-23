import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/animations/app_animate_extensions.dart';
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
            ).fadeSlideIn(),
            const VGap.lg(),
            AppText.subtitle('Sin hábitos aún').fadeSlideIn(
              delay: Duration(milliseconds: 60),
            ),
            const VGap.sm(),
            AppText.body(
              'Crea tu primer hábito para empezar a trackear tu progreso.',
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
            ).fadeSlideIn(delay: Duration(milliseconds: 120)),
            const VGap.xl(),
            AppButton(
              label: 'Crear hábito',
              icon: LucideIcons.plus,
              onPressed: onCreateTap,
            ).fadeSlideIn(delay: Duration(milliseconds: 180)),
          ],
        ),
      ),
    );
  }
}
