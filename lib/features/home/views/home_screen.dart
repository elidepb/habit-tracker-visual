import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/router/routes.dart';
import 'package:habit_tracker_visual/shared/widgets/feature_placeholder.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hábitos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(Routes.createHabit),
        child: const Icon(LucideIcons.plus),
      ),
      body: const FeaturePlaceholder(
        title: 'Dashboard',
        subtitle: 'Lista de hábitos, heatmap y resumen diario — PR-05.',
        icon: LucideIcons.layoutDashboard,
      ),
    );
  }
}
