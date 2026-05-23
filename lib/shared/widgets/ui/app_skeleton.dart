import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_durations.dart';
import 'package:habit_tracker_visual/core/theme/app_radius.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';

class AppSkeletonBox extends StatelessWidget {
  const AppSkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = AppRadius.main,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.border.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: AppDurations.slow,
          color: AppColors.textSecondary.withValues(alpha: 0.12),
        );
  }
}

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.size = 28});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const CircularProgressIndicator(
        strokeWidth: 2.5,
        color: AppColors.primary,
      ),
    )
        .animate(onPlay: (c) => c.repeat())
        .fadeIn(duration: AppDurations.fast);
  }
}

class HomeLoadingSkeleton extends StatelessWidget {
  const HomeLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppSpacing.screenPadding,
      children: [
        const AppSkeletonBox(width: double.infinity, height: 72),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(child: AppSkeletonBox(width: double.infinity, height: 64)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: AppSkeletonBox(width: double.infinity, height: 64)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: AppSkeletonBox(width: double.infinity, height: 64)),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        const AppSkeletonBox(width: double.infinity, height: 120),
        const SizedBox(height: AppSpacing.xl),
        const AppSkeletonBox(width: 120, height: 18),
        const SizedBox(height: AppSpacing.md),
        for (var i = 0; i < 4; i++) ...[
          const AppSkeletonBox(
            width: double.infinity,
            height: 72,
            borderRadius: AppRadius.card,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}
