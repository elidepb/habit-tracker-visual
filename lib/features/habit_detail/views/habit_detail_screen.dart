import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/shared/widgets/feature_placeholder.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HabitDetailScreen extends StatelessWidget {
  const HabitDetailScreen({super.key, required this.habitId});

  final String habitId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hábito $habitId'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => context.pop(),
        ),
      ),
      body: FeaturePlaceholder(
        title: 'Detalle del hábito',
        subtitle: 'Heatmap individual, estadísticas e historial — PR-08.',
        icon: LucideIcons.target,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => context.pop(),
              child: const Text('Volver'),
            ),
          ),
        ),
      ),
    );
  }
}
