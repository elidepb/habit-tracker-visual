import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_palette.dart';
import 'package:habit_tracker_visual/core/theme/app_radius.dart';
import 'package:habit_tracker_visual/core/theme/app_shadows.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';

enum AppCardVariant { outlined, elevated, filled }

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.outlined,
    this.padding,
    this.onTap,
    this.margin,
  });

  final Widget child;
  final AppCardVariant variant;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final palette = context.appPalette;

    final decoration = BoxDecoration(
      color: palette.surface,
      borderRadius: BorderRadius.circular(AppRadius.card),
      border: variant == AppCardVariant.outlined
          ? Border.all(color: palette.border)
          : null,
      boxShadow: variant == AppCardVariant.elevated ? AppShadows.card : null,
    );

    final content = Padding(
      padding: padding ?? AppSpacing.cardPadding,
      child: child,
    );

    final card = Container(
      margin: margin,
      decoration: decoration,
      child: content,
    );

    if (onTap == null) return card;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: card,
      ),
    );
  }
}
