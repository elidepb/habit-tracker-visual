import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';

class FeaturePlaceholder extends StatelessWidget {
  const FeaturePlaceholder({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.child,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 40, color: AppColors.primary),
              const VGap.lg(),
            ],
            AppText.h2(title),
            if (subtitle != null) ...[
              const VGap.sm(),
              AppText.body(subtitle!, color: AppColors.textSecondary),
            ],
            if (child != null) ...[
              const VGap.xl(),
              Expanded(child: child!),
            ],
          ],
        ),
      ),
    );
  }
}
