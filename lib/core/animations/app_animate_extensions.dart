import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:habit_tracker_visual/core/theme/app_durations.dart';

extension AppAnimateX on Widget {
  Widget fadeSlideIn({
    Duration? delay,
    Duration duration = AppDurations.normal,
    double beginY = 0.06,
  }) {
    return animate(delay: delay)
        .fadeIn(duration: duration, curve: Curves.easeOut)
        .slideY(
          begin: beginY,
          end: 0,
          duration: duration,
          curve: Curves.easeOutCubic,
        );
  }

  Widget listItemIn(int index, {int staggerMs = 40}) {
    return fadeSlideIn(
      delay: Duration(milliseconds: index * staggerMs),
      duration: AppDurations.normal,
    );
  }
}
