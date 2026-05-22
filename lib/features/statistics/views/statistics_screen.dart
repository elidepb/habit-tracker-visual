import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/shared/widgets/feature_placeholder.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estadísticas')),
      body: const FeaturePlaceholder(
        title: 'Analytics',
        subtitle: 'Gráficos, streaks y métricas de consistencia — PR-09.',
        icon: LucideIcons.trendingUp,
      ),
    );
  }
}
