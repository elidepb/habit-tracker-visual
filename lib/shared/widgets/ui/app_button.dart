import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_durations.dart';
import 'package:habit_tracker_visual/core/theme/app_radius.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';

enum AppButtonVariant { primary, secondary, ghost, danger }

enum AppButtonSize { sm, md, lg }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;

  bool get _isDisabled => onPressed == null || isLoading;

  EdgeInsets get _padding => switch (size) {
        AppButtonSize.sm => const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
        AppButtonSize.md => const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
        AppButtonSize.lg => const EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.lg,
          ),
      };

  double get _fontSize => switch (size) {
        AppButtonSize.sm => 13,
        AppButtonSize.md => 14,
        AppButtonSize.lg => 16,
      };

  double get _iconSize => switch (size) {
        AppButtonSize.sm => 16,
        AppButtonSize.md => 18,
        AppButtonSize.lg => 20,
      };

  @override
  Widget build(BuildContext context) {
    final child = _buildChild(context);
    final button = switch (variant) {
      AppButtonVariant.primary => FilledButton(
          onPressed: _isDisabled ? null : onPressed,
          style: _filledStyle(AppColors.primary, Colors.white),
          child: child,
        ),
      AppButtonVariant.secondary => OutlinedButton(
          onPressed: _isDisabled ? null : onPressed,
          style: _outlinedStyle(AppColors.border, AppColors.textPrimary),
          child: child,
        ),
      AppButtonVariant.ghost => TextButton(
          onPressed: _isDisabled ? null : onPressed,
          style: _textStyle(AppColors.textSecondary),
          child: child,
        ),
      AppButtonVariant.danger => FilledButton(
          onPressed: _isDisabled ? null : onPressed,
          style: _filledStyle(AppColors.error, Colors.white),
          child: child,
        ),
    };

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  Widget _buildChild(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppDurations.fast,
      child: isLoading
          ? SizedBox(
              key: const ValueKey('loading'),
              height: _iconSize,
              width: _iconSize,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: variant == AppButtonVariant.ghost
                    ? AppColors.textSecondary
                    : Colors.white,
              ),
            )
          : KeyedSubtree(
              key: const ValueKey('label'),
              child: _buildLabel(context),
            ),
    );
  }

  Widget _buildLabel(BuildContext context) {
    final text = Text(
      label,
      style: TextStyle(
        fontSize: _fontSize,
        fontWeight: FontWeight.w600,
      ),
    );

    if (icon == null) return text;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: _iconSize),
        const SizedBox(width: AppSpacing.sm),
        text,
      ],
    );
  }

  ButtonStyle _filledStyle(Color background, Color foreground) {
    return FilledButton.styleFrom(
      backgroundColor: background,
      foregroundColor: foreground,
      disabledBackgroundColor: background.withValues(alpha: 0.4),
      disabledForegroundColor: foreground.withValues(alpha: 0.6),
      padding: _padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.main),
      ),
      animationDuration: AppDurations.fast,
    );
  }

  ButtonStyle _outlinedStyle(Color border, Color foreground) {
    return OutlinedButton.styleFrom(
      foregroundColor: foreground,
      disabledForegroundColor: foreground.withValues(alpha: 0.4),
      padding: _padding,
      side: BorderSide(color: border),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.main),
      ),
      animationDuration: AppDurations.fast,
    );
  }

  ButtonStyle _textStyle(Color foreground) {
    return TextButton.styleFrom(
      foregroundColor: foreground,
      disabledForegroundColor: foreground.withValues(alpha: 0.4),
      padding: _padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.main),
      ),
      animationDuration: AppDurations.fast,
    );
  }
}
