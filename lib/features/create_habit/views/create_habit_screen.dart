import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/shared/widgets/feature_placeholder.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CreateHabitScreen extends StatelessWidget {
  const CreateHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText.subtitle('Nuevo hábito'),
        leading: IconButton(
          icon: const Icon(LucideIcons.x),
          onPressed: () => context.pop(),
        ),
      ),
      body: FeaturePlaceholder(
        title: 'Crear hábito',
        subtitle: 'Formulario completo en PR-04.',
        icon: LucideIcons.plusCircle,
        child: Column(
          children: [
            const AppInput(
              label: 'Nombre del hábito',
              hint: 'Ej. Leer 30 minutos',
              prefixIcon: LucideIcons.pencil,
              maxLength: 50,
            ),
            const VGap.xl(),
            const Spacer(),
            AppButton(
              label: 'Guardar',
              fullWidth: true,
              icon: LucideIcons.check,
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
