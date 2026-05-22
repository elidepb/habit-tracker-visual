import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/shared/widgets/feature_placeholder.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HabitDetailScreen extends StatelessWidget {
  const HabitDetailScreen({super.key, required this.habitId});

  final String habitId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText.subtitle('Hábito $habitId'),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => context.pop(),
        ),
      ),
      body: FeaturePlaceholder(
        title: 'Detalle del hábito',
        subtitle: 'Heatmap individual, estadísticas e historial — PR-08.',
        icon: LucideIcons.target,
        child: Column(
          children: [
            const Spacer(),
            AppButton(
              label: 'Editar',
              variant: AppButtonVariant.secondary,
              icon: LucideIcons.pencil,
              fullWidth: true,
              onPressed: null,
            ),
            const VGap.md(),
            AppButton(
              label: 'Eliminar',
              variant: AppButtonVariant.danger,
              icon: LucideIcons.trash2,
              fullWidth: true,
              onPressed: null,
            ),
            const VGap.md(),
            AppButton(
              label: 'Volver',
              variant: AppButtonVariant.ghost,
              fullWidth: true,
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
