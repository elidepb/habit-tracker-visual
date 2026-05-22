import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/router/routes.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/shared/widgets/feature_placeholder.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FeaturePlaceholder(
        title: 'Bienvenido',
        subtitle:
            'Rastrea tus hábitos con un heatmap inspirado en GitHub. '
            'Construye consistencia, un día a la vez.',
        icon: LucideIcons.sparkles,
        child: Column(
          children: [
            _OnboardingHighlight(
              icon: LucideIcons.grid,
              title: 'Heatmap visual',
              description: 'Visualiza tu progreso anual de un vistazo.',
            ),
            const SizedBox(height: AppSpacing.lg),
            _OnboardingHighlight(
              icon: LucideIcons.flame,
              title: 'Rachas',
              description: 'Mantén la motivación con streaks diarios.',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => context.go(Routes.home),
                child: const Text('Comenzar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingHighlight extends StatelessWidget {
  const _OnboardingHighlight({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.secondary),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(description, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
