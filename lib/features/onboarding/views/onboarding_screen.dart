import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/router/routes.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/shared/widgets/feature_placeholder.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
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
            const _OnboardingHighlight(
              icon: LucideIcons.grid,
              title: 'Heatmap visual',
              description: 'Visualiza tu progreso anual de un vistazo.',
            ),
            const VGap.lg(),
            const _OnboardingHighlight(
              icon: LucideIcons.flame,
              title: 'Rachas',
              description: 'Mantén la motivación con streaks diarios.',
            ),
            const Spacer(),
            AppButton(
              label: 'Comenzar',
              fullWidth: true,
              size: AppButtonSize.lg,
              onPressed: () => context.go(Routes.home),
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
    return AppCard(
      child: Row(
        children: [
          Icon(icon, color: AppColors.secondary),
          const HGap.lg(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.subtitle(title),
                const VGap.xs(),
                AppText.caption(description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
