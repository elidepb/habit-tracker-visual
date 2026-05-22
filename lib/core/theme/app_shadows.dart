import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';

abstract final class AppShadows {
  static List<BoxShadow> get soft => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get card => [
        BoxShadow(
          color: AppColors.background.withValues(alpha: 0.6),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];
}
