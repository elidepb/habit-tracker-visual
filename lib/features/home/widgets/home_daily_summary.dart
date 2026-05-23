import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/core/utils/date_formatters.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';

class HomeDailySummary extends StatelessWidget {
  const HomeDailySummary({
    super.key,
    required this.completed,
    required this.total,
    required this.rate,
  });

  final int completed;
  final int total;
  final double rate;

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Buenos días';
    if (hour < 19) return 'Buenas tardes';
    return 'Buenas noches';
  }

  String _message() {
    if (total == 0) {
      return 'Empieza creando tu primer hábito y construye consistencia día a día.';
    }
    if (rate >= 1) {
      return '¡Excelente! Completaste todos tus hábitos hoy. Sigue así.';
    }
    if (rate >= 0.5) {
      return 'Vas por buen camino. Te faltan ${total - completed} por completar hoy.';
    }
    if (completed == 0) {
      return 'Aún no has completado hábitos hoy. ¡Da el primer paso!';
    }
    return 'Cada check cuenta. Sigue avanzando con tus hábitos.';
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      variant: AppCardVariant.elevated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.caption(DateFormatters.displayDate(DateTime.now())),
          const VGap.sm(),
          AppText.h1(_greeting()),
          const VGap.md(),
          AppText.body(_message(), color: AppColors.textSecondary),
          if (total > 0) ...[
            const VGap.lg(),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: rate,
                minHeight: 8,
                backgroundColor: AppColors.border,
                color: AppColors.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
