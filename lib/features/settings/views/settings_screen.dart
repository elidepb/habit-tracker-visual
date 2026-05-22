import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/shared/widgets/feature_placeholder.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppText.subtitle('Ajustes')),
      body: const FeaturePlaceholder(
        title: 'Configuración',
        subtitle: 'Tema, notificaciones y preferencias — PR-10+.',
        icon: LucideIcons.slidersHorizontal,
      ),
    );
  }
}
