import 'package:flutter/material.dart';

enum AppTextVariant {
  h1,
  h2,
  subtitle,
  body,
  caption,
}

extension AppTextVariantX on AppTextVariant {
  TextStyle resolve(TextTheme theme) {
    return switch (this) {
      AppTextVariant.h1 => theme.displayLarge!,
      AppTextVariant.h2 => theme.displayMedium!,
      AppTextVariant.subtitle => theme.titleMedium!,
      AppTextVariant.body => theme.bodyLarge!,
      AppTextVariant.caption => theme.labelMedium!,
    };
  }
}
