import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/heatmap/models/heatmap_data.dart';
import 'package:habit_tracker_visual/features/heatmap/utils/heatmap_calculator.dart';
import 'package:habit_tracker_visual/features/heatmap/widgets/heatmap_legend.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/app_text.dart';

class ContributionHeatmap extends StatelessWidget {
  const ContributionHeatmap({
    super.key,
    required this.data,
    this.cellSize = 12,
    this.cellGap = 3,
    this.showMonthLabels = true,
    this.intensityLabel,
  });

  final HeatmapData data;
  final double cellSize;
  final double cellGap;
  final bool showMonthLabels;
  final String Function(int level)? intensityLabel;

  static const _monthNames = [
    'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
    'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic',
  ];

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const AppText.caption(
        'Sin datos de actividad',
        color: AppColors.textSecondary,
      );
    }

    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showMonthLabels) ...[
            _MonthLabels(
              data: data,
              cellSize: cellSize,
              cellGap: cellGap,
            ),
            const VGap.sm(),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DayLabels(cellSize: cellSize, cellGap: cellGap),
              const HGap.sm(),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _HeatmapGrid(
                    data: data,
                    cellSize: cellSize,
                    cellGap: cellGap,
                    intensityLabel: intensityLabel,
                  ),
                ),
              ),
            ],
          ),
          const VGap.md(),
          const Align(
            alignment: Alignment.centerRight,
            child: HeatmapLegend(),
          ),
        ],
      ),
    );
  }
}

class _MonthLabels extends StatelessWidget {
  const _MonthLabels({
    required this.data,
    required this.cellSize,
    required this.cellGap,
  });

  final HeatmapData data;
  final double cellSize;
  final double cellGap;

  @override
  Widget build(BuildContext context) {
    final labels = <Widget>[];
    var lastMonth = -1;
    const leftPadding = 20.0;

    for (var col = 0; col < data.weeks; col++) {
      final date = data.startDate.add(Duration(days: col * 7));
      if (date.month != lastMonth) {
        lastMonth = date.month;
        labels.add(
          SizedBox(
            width: cellSize + cellGap,
            child: AppText.caption(
              ContributionHeatmap._monthNames[date.month - 1],
              color: AppColors.textSecondary,
            ),
          ),
        );
      } else {
        labels.add(SizedBox(width: cellSize + cellGap));
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: leftPadding),
      child: Row(children: labels),
    );
  }
}

class _DayLabels extends StatelessWidget {
  const _DayLabels({required this.cellSize, required this.cellGap});

  final double cellSize;
  final double cellGap;

  @override
  Widget build(BuildContext context) {
    const labels = ['D', 'L', 'M', 'X', 'J', 'V', 'S'];
    return Column(
      children: List.generate(7, (index) {
        if (index.isOdd) {
          return SizedBox(height: cellSize + cellGap);
        }
        return SizedBox(
          height: cellSize + cellGap,
          child: Align(
            alignment: Alignment.centerLeft,
            child: AppText.caption(
              labels[index],
              color: AppColors.textSecondary,
            ),
          ),
        );
      }),
    );
  }
}

class _HeatmapGrid extends StatelessWidget {
  const _HeatmapGrid({
    required this.data,
    required this.cellSize,
    required this.cellGap,
    this.intensityLabel,
  });

  final HeatmapData data;
  final double cellSize;
  final double cellGap;
  final String Function(int level)? intensityLabel;

  String _tooltipForCell(int row, int col) {
    final date = data.startDate.add(Duration(days: col * 7 + row));
    final level = data.intensityAt(row, col);
    final dateStr = '${date.day}/${date.month}/${date.year}';
    if (intensityLabel != null) {
      return '$dateStr — ${intensityLabel!(level)}';
    }
    if (level == 0) return '$dateStr — Sin actividad';
    return '$dateStr — Nivel $level';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(HeatmapCalculator.daysPerWeek, (row) {
        return Padding(
          padding: EdgeInsets.only(bottom: row < 6 ? cellGap : 0),
          child: Row(
            children: List.generate(data.weeks, (col) {
              final intensity = data.intensityAt(row, col);
              return Padding(
                padding: EdgeInsets.only(right: col < data.weeks - 1 ? cellGap : 0),
                child: Tooltip(
                  message: _tooltipForCell(row, col),
                  child: _HeatmapCell(
                    intensity: intensity,
                    size: cellSize,
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}

class _HeatmapCell extends StatelessWidget {
  const _HeatmapCell({required this.intensity, required this.size});

  final int intensity;
  final double size;

  @override
  Widget build(BuildContext context) {
    final level = intensity.clamp(0, AppColors.heatmapLevels.length - 1);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.heatmapLevels[level],
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
    );
  }
}

class ContributionHeatmapPaint extends StatelessWidget {
  const ContributionHeatmapPaint({
    super.key,
    required this.data,
    this.cellSize = 12,
    this.cellGap = 3,
  });

  final HeatmapData data;
  final double cellSize;
  final double cellGap;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();

    final width = data.weeks * (cellSize + cellGap) - cellGap;
    final height = HeatmapCalculator.daysPerWeek * (cellSize + cellGap) - cellGap;

    return RepaintBoundary(
      child: CustomPaint(
        size: Size(width, height),
        painter: _HeatmapPainter(
          data: data,
          cellSize: cellSize,
          cellGap: cellGap,
        ),
      ),
    );
  }
}

class _HeatmapPainter extends CustomPainter {
  _HeatmapPainter({
    required this.data,
    required this.cellSize,
    required this.cellGap,
  });

  final HeatmapData data;
  final double cellSize;
  final double cellGap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (var row = 0; row < HeatmapCalculator.daysPerWeek; row++) {
      for (var col = 0; col < data.weeks; col++) {
        final level = data.intensityAt(row, col).clamp(0, 4);
        paint.color = AppColors.heatmapLevels[level];

        final x = col * (cellSize + cellGap);
        final y = row * (cellSize + cellGap);
        final rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, cellSize, cellSize),
          const Radius.circular(2),
        );
        canvas.drawRRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _HeatmapPainter oldDelegate) {
    return oldDelegate.data != data;
  }
}
