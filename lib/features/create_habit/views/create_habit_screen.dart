import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/shared/widgets/feature_placeholder.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CreateHabitScreen extends StatelessWidget {
  const CreateHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo hábito'),
        leading: IconButton(
          icon: const Icon(LucideIcons.x),
          onPressed: () => context.pop(),
        ),
      ),
      body: FeaturePlaceholder(
        title: 'Crear hábito',
        subtitle: 'Formulario con nombre, color, icono y recordatorio — PR-04.',
        icon: LucideIcons.plusCircle,
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
