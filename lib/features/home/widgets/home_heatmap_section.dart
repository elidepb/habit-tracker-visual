import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/heatmap/providers/heatmap_providers.dart';
import 'package:habit_tracker_visual/features/heatmap/widgets/contribution_heatmap.dart';
import 'package:habit_tracker_visual/l10n/app_localizations.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';

class HomeHeatmapSection extends ConsumerWidget {
  const HomeHeatmapSection({super.key});

  String _intensityLabel(int level, int totalHabits, AppLocalizations l10n) {
    if (level == 0) return l10n.heatmapIntensityNone;
    if (totalHabits <= 1) return l10n.heatmapIntensityCompleted;
    return switch (level) {
      1 => l10n.heatmapIntensityLow,
      2 => l10n.heatmapIntensityMedium,
      3 => l10n.heatmapIntensityHigh,
      4 => l10n.heatmapIntensityAll,
      _ => l10n.heatmapIntensityDefault,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final heatmap = ref.watch(globalHeatmapProvider);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.subtitle(l10n.heatmapAnnualTitle),
          const VGap.xs(),
          AppText.caption(
            l10n.heatmapActiveDaysThisYear(heatmap.totalActiveDays),
          ),
          const VGap.lg(),
          ContributionHeatmap(
            data: heatmap,
            intensityLabel: (level) =>
                _intensityLabel(level, heatmap.totalHabits, l10n),
          ),
        ],
      ),
    );
  }
}
