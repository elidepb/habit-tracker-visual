import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';

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
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 40, color: AppColors.primary),
              const SizedBox(height: AppSpacing.lg),
            ],
            Text(title, style: theme.textTheme.displayMedium),
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(subtitle!, style: theme.textTheme.bodyMedium),
            ],
            if (child != null) ...[
              const SizedBox(height: AppSpacing.xl),
              Expanded(child: child!),
            ],
          ],
        ),
      ),
    );
  }
}
