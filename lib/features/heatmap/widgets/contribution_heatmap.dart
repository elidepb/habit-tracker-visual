import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/core/theme/app_palette.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/core/utils/date_formatters.dart';
import 'package:habit_tracker_visual/features/heatmap/models/heatmap_data.dart';
import 'package:habit_tracker_visual/features/heatmap/utils/heatmap_calculator.dart';
import 'package:habit_tracker_visual/features/heatmap/widgets/heatmap_legend.dart';
import 'package:habit_tracker_visual/l10n/app_localizations.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/app_text.dart';

class ContributionHeatmap extends StatefulWidget {
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
  State<ContributionHeatmap> createState() => _ContributionHeatmapState();
}

class _ContributionHeatmapState extends State<ContributionHeatmap> {
  static const _maxScrollRetries = 12;

  late final ScrollController _scrollController;
  var _scrollRetryCount = 0;
  double _viewportWidth = 0;

  double get _cellStride => widget.cellSize + widget.cellGap;

  double get _gridWidth =>
      widget.data.weeks * _cellStride - widget.cellGap;

  double get _gridHeight =>
      HeatmapCalculator.daysPerWeek * widget.cellSize +
      (HeatmapCalculator.daysPerWeek - 1) * widget.cellGap;

  int get _currentWeekColumn {
    final today = DateTime.now();
    return HeatmapCalculator.weekColumnFor(
      widget.data.startDate,
      DateTime(today.year, today.month, today.day),
    ).clamp(0, widget.data.weeks - 1);
  }

  double _trailingScrollOffset(double viewportWidth) {
    if (_gridWidth <= viewportWidth) return 0;

    final trailingEdge = (_currentWeekColumn + 1) * _cellStride;
    return trailingEdge - viewportWidth;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_viewportWidth > 0) _scrollToTrailingEdge(_viewportWidth);
    });
  }

  @override
  void didUpdateWidget(covariant ContributionHeatmap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data.startDate != widget.data.startDate ||
        oldWidget.data.weeks != widget.data.weeks ||
        oldWidget.data.endDate != widget.data.endDate ||
        oldWidget.cellSize != widget.cellSize ||
        oldWidget.cellGap != widget.cellGap) {
      _scrollRetryCount = 0;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_viewportWidth > 0) _scrollToTrailingEdge(_viewportWidth);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scheduleScrollRetry(double viewportWidth) {
    if (_scrollRetryCount >= _maxScrollRetries || !mounted) return;
    _scrollRetryCount++;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToTrailingEdge(viewportWidth);
    });
  }

  void _scrollToTrailingEdge(double viewportWidth) {
    if (!mounted) return;

    if (_gridWidth <= viewportWidth) return;

    if (!_scrollController.hasClients) {
      _scheduleScrollRetry(viewportWidth);
      return;
    }

    final position = _scrollController.position;
    final maxOffset = position.maxScrollExtent;
    final target = _trailingScrollOffset(viewportWidth);

    if (maxOffset <= 0 && target > 0) {
      _scheduleScrollRetry(viewportWidth);
      return;
    }

    final clamped = target.clamp(0.0, maxOffset);
    if ((position.pixels - clamped).abs() > 0.5) {
      _scrollController.jumpTo(clamped);
    }
  }

  Widget _buildGridContent() {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showMonthLabels) ...[
          _MonthLabels(
            data: widget.data,
            cellStride: _cellStride,
            gridWidth: _gridWidth,
            l10n: l10n,
          ),
          const VGap.sm(),
        ],
        _HeatmapGrid(
          data: widget.data,
          cellSize: widget.cellSize,
          cellGap: widget.cellGap,
          gridWidth: _gridWidth,
          gridHeight: _gridHeight,
          intensityLabel: widget.intensityLabel,
          l10n: l10n,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (widget.data.isEmpty) {
      return AppText.caption(
        l10n.heatmapIntensityNone,
        color: context.appPalette.textSecondary,
      );
    }

    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DayLabels(
                cellSize: widget.cellSize,
                cellGap: widget.cellGap,
                height: _gridHeight,
                l10n: l10n,
              ),
              const HGap.sm(),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final viewportWidth = constraints.maxWidth;
                    if (_viewportWidth != viewportWidth) {
                      _viewportWidth = viewportWidth;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollToTrailingEdge(viewportWidth);
                      });
                    }

                    final gridContent = _buildGridContent();

                    if (_gridWidth <= viewportWidth) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: gridContent,
                      );
                    }

                    return SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.hardEdge,
                      child: gridContent,
                    );
                  },
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
    required this.cellStride,
    required this.gridWidth,
    required this.l10n,
  });

  final HeatmapData data;
  final double cellStride;
  final double gridWidth;
  final AppLocalizations l10n;

  static const _minLabelSpacing = 28.0;
  static const _labelHeight = 18.0;

  @override
  Widget build(BuildContext context) {
    final markers = <Widget>[];
    var lastMonth = -1;
    var lastLabelEnd = -_minLabelSpacing;

    for (var col = 0; col < data.weeks; col++) {
      final date = data.startDate.add(Duration(days: col * 7));
      if (date.year < data.endDate.year) continue;
      if (date.month == lastMonth) continue;

      lastMonth = date.month;
      final left = col * cellStride;
      if (left < lastLabelEnd + 4) continue;

      markers.add(
        Positioned(
          left: left,
          top: 0,
          child: AppText.caption(
            DateFormatters.shortMonthNames(l10n)[date.month - 1],
            color: context.appPalette.textSecondary,
          ),
        ),
      );
      lastLabelEnd = left + _minLabelSpacing;
    }

    return SizedBox(
      height: _labelHeight,
      width: gridWidth,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: markers,
      ),
    );
  }
}

class _DayLabels extends StatelessWidget {
  const _DayLabels({
    required this.cellSize,
    required this.cellGap,
    required this.height,
    required this.l10n,
  });

  final double cellSize;
  final double cellGap;
  final double height;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: List.generate(HeatmapCalculator.daysPerWeek, (row) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: row < HeatmapCalculator.daysPerWeek - 1 ? cellGap : 0,
            ),
            child: SizedBox(
              height: cellSize,
              child: row.isOdd
                  ? const SizedBox.shrink()
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: AppText.caption(
                        DateFormatters.heatmapDayLabels(l10n)[row],
                        color: context.appPalette.textSecondary,
                      ),
                    ),
            ),
          );
        }),
      ),
    );
  }
}

class _HeatmapGrid extends StatefulWidget {
  const _HeatmapGrid({
    required this.data,
    required this.cellSize,
    required this.cellGap,
    required this.gridWidth,
    required this.gridHeight,
    required this.l10n,
    this.intensityLabel,
  });

  final HeatmapData data;
  final double cellSize;
  final double cellGap;
  final double gridWidth;
  final double gridHeight;
  final AppLocalizations l10n;
  final String Function(int level)? intensityLabel;

  @override
  State<_HeatmapGrid> createState() => _HeatmapGridState();
}

class _HeatmapGridState extends State<_HeatmapGrid> {
  String? _selectedTooltip;

  void _onCellTap(int row, int col) {
    final date = widget.data.startDate.add(Duration(days: col * 7 + row));
    final level = widget.data.intensityAt(row, col);
    setState(() {
      _selectedTooltip = DateFormatters.heatmapTooltip(
        date,
        level: level,
        l10n: widget.l10n,
        intensityLabel: widget.intensityLabel,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.gridWidth,
          height: widget.gridHeight,
          child: Column(
            children: List.generate(HeatmapCalculator.daysPerWeek, (row) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: row < HeatmapCalculator.daysPerWeek - 1
                      ? widget.cellGap
                      : 0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(widget.data.weeks, (col) {
                    final level =
                        widget.data.intensityAt(row, col).clamp(0, 4);
                    return Padding(
                      padding: EdgeInsets.only(
                        right: col < widget.data.weeks - 1
                            ? widget.cellGap
                            : 0,
                      ),
                      child: _HeatmapCell(
                        level: level,
                        size: widget.cellSize,
                        onTap: () => _onCellTap(row, col),
                      ),
                    );
                  }),
                ),
              );
            }),
          ),
        ),
        if (_selectedTooltip != null) ...[
          const VGap.sm(),
          AppText.caption(
            _selectedTooltip!,
            color: context.appPalette.textSecondary,
          ),
        ],
      ],
    );
  }
}

class _HeatmapCell extends StatelessWidget {
  const _HeatmapCell({
    required this.level,
    required this.size,
    required this.onTap,
  });

  final int level;
  final double size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final palette = context.appPalette;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: palette.heatmapLevels[level],
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            color: palette.border.withValues(
              alpha: level == 0 ? 0.6 : 0.35,
            ),
          ),
        ),
      ),
    );
  }
}
