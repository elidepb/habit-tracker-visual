import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';

abstract final class HabitPalette {
  static const List<Color> colors = [
    AppColors.primary,
    AppColors.secondary,
    AppColors.accent,
    AppColors.success,
    AppColors.warning,
    AppColors.error,
  ];

  static int toValue(Color color) => color.toARGB32();
}
