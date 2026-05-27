import 'package:flutter/material.dart';

@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.heatmapLevels,
  });

  static const dark = AppPalette(
    background: Color(0xFF0D1117),
    surface: Color(0xFF161B22),
    textPrimary: Color(0xFFE6EDF3),
    textSecondary: Color(0xFF8B949E),
    border: Color(0xFF30363D),
    heatmapLevels: [
      Color(0xFF161B22),
      Color(0xFF0E4429),
      Color(0xFF006D32),
      Color(0xFF26A641),
      Color(0xFF39D353),
    ],
  );

  static const light = AppPalette(
    background: Color(0xFFF6F8FA),
    surface: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF1F2328),
    textSecondary: Color(0xFF656D76),
    border: Color(0xFFD0D7DE),
    heatmapLevels: [
      Color(0xFFEBEDF0),
      Color(0xFF9BE9A8),
      Color(0xFF40C463),
      Color(0xFF30A14E),
      Color(0xFF216E39),
    ],
  );

  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final List<Color> heatmapLevels;

  @override
  AppPalette copyWith({
    Color? background,
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    List<Color>? heatmapLevels,
  }) {
    return AppPalette(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
      heatmapLevels: heatmapLevels ?? this.heatmapLevels,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      heatmapLevels: List.generate(
        heatmapLevels.length,
        (index) => Color.lerp(
          heatmapLevels[index],
          other.heatmapLevels[index],
          t,
        )!,
      ),
    );
  }
}

extension AppPaletteContext on BuildContext {
  AppPalette get appPalette =>
      Theme.of(this).extension<AppPalette>() ?? AppPalette.dark;
}
