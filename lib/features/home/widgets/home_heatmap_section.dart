import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/features/heatmap/providers/heatmap_providers.dart';
import 'package:habit_tracker_visual/features/heatmap/widgets/contribution_heatmap.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';

class HomeHeatmapSection extends ConsumerWidget {
  const HomeHeatmapSection({super.key});

  String _intensityLabel(int level, int totalHabits) {
    if (level == 0) return 'Sin actividad';
    if (totalHabits <= 1) return 'Completado';
    return switch (level) {
      1 => 'Baja actividad',
      2 => 'Actividad media',
      3 => 'Alta actividad',
      4 => 'Todos completados',
      _ => 'Actividad',
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heatmap = ref.watch(globalHeatmapProvider);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText.subtitle('Actividad anual'),
          const VGap.xs(),
          AppText.caption(
            '${heatmap.totalActiveDays} días activos en el último año',
          ),
          const VGap.lg(),
          ContributionHeatmap(
            data: heatmap,
            intensityLabel: (level) => _intensityLabel(level, heatmap.totalHabits),
          ),
        ],
      ),
    );
  }
}
