import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_palette.dart';
import 'package:habit_tracker_visual/core/theme/app_text_styles.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    this.variant = AppTextVariant.body,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semibold = false,
  });

  const AppText.h1(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  })  : variant = AppTextVariant.h1,
        semibold = false;

  const AppText.h2(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  })  : variant = AppTextVariant.h2,
        semibold = false;

  const AppText.subtitle(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  })  : variant = AppTextVariant.subtitle,
        semibold = false;

  const AppText.body(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  })  : variant = AppTextVariant.body,
        semibold = false;

  const AppText.caption(
    this.data, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  })  : variant = AppTextVariant.caption,
        semibold = false;

  final String data;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool semibold;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var style = variant.resolve(theme.textTheme);

    if (color != null) {
      style = style.copyWith(color: color);
    }
    if (semibold) {
      style = style.copyWith(fontWeight: FontWeight.w600);
    }
    if (variant == AppTextVariant.caption && color == null) {
      style = style.copyWith(color: context.appPalette.textSecondary);
    }

    return Text(
      data,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
