import 'package:flutter/material.dart';

abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  static const EdgeInsets screenPadding = EdgeInsets.all(xl);
  static const EdgeInsets cardPadding = EdgeInsets.all(lg);
  static const EdgeInsets inputPadding =
      EdgeInsets.symmetric(horizontal: lg, vertical: md);
}

class VGap extends StatelessWidget {
  const VGap(this.size, {super.key});

  const VGap.xs({super.key}) : size = AppSpacing.xs;
  const VGap.sm({super.key}) : size = AppSpacing.sm;
  const VGap.md({super.key}) : size = AppSpacing.md;
  const VGap.lg({super.key}) : size = AppSpacing.lg;
  const VGap.xl({super.key}) : size = AppSpacing.xl;
  const VGap.xxl({super.key}) : size = AppSpacing.xxl;
  const VGap.xxxl({super.key}) : size = AppSpacing.xxxl;

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(height: size);
}

class HGap extends StatelessWidget {
  const HGap(this.size, {super.key});

  const HGap.xs({super.key}) : size = AppSpacing.xs;
  const HGap.sm({super.key}) : size = AppSpacing.sm;
  const HGap.md({super.key}) : size = AppSpacing.md;
  const HGap.lg({super.key}) : size = AppSpacing.lg;
  const HGap.xl({super.key}) : size = AppSpacing.xl;

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(width: size);
}
