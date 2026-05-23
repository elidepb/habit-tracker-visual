import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/core/utils/date_formatters.dart';
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
                  child: _InteractiveHeatmapPaint(
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
              DateFormatters.shortMonthNames[date.month - 1],
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
              DateFormatters.heatmapDayLabels[index],
              color: AppColors.textSecondary,
            ),
          ),
        );
      }),
    );
  }
}

class _InteractiveHeatmapPaint extends StatefulWidget {
  const _InteractiveHeatmapPaint({
    required this.data,
    required this.cellSize,
    required this.cellGap,
    this.intensityLabel,
  });

  final HeatmapData data;
  final double cellSize;
  final double cellGap;
  final String Function(int level)? intensityLabel;

  @override
  State<_InteractiveHeatmapPaint> createState() =>
      _InteractiveHeatmapPaintState();
}

class _InteractiveHeatmapPaintState extends State<_InteractiveHeatmapPaint> {
  String? _selectedTooltip;

  ({int row, int col})? _cellAt(Offset position) {
    final col = (position.dx / (widget.cellSize + widget.cellGap)).floor();
    final row = (position.dy / (widget.cellSize + widget.cellGap)).floor();
    if (row < 0 ||
        col < 0 ||
        row >= HeatmapCalculator.daysPerWeek ||
        col >= widget.data.weeks) {
      return null;
    }
    return (row: row, col: col);
  }

  String _tooltipForCell(int row, int col) {
    final date = widget.data.startDate.add(Duration(days: col * 7 + row));
    final level = widget.data.intensityAt(row, col);
    return DateFormatters.heatmapTooltip(
      date,
      level: level,
      intensityLabel: widget.intensityLabel,
    );
  }

  void _handleTapUp(TapUpDetails details) {
    final cell = _cellAt(details.localPosition);
    if (cell == null) return;
    setState(() => _selectedTooltip = _tooltipForCell(cell.row, cell.col));
  }

  @override
  Widget build(BuildContext context) {
    final width =
        widget.data.weeks * (widget.cellSize + widget.cellGap) - widget.cellGap;
    final height = HeatmapCalculator.daysPerWeek *
            (widget.cellSize + widget.cellGap) -
        widget.cellGap;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTapUp: _handleTapUp,
          child: CustomPaint(
            size: Size(width, height),
            painter: _HeatmapPainter(
              data: widget.data,
              cellSize: widget.cellSize,
              cellGap: widget.cellGap,
            ),
          ),
        ),
        if (_selectedTooltip != null) ...[
          const VGap.sm(),
          AppText.caption(
            _selectedTooltip!,
            color: AppColors.textSecondary,
          ),
        ],
      ],
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
