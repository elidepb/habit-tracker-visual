import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_spacing.dart';
import 'package:habit_tracker_visual/core/utils/date_formatters.dart';
import 'package:habit_tracker_visual/l10n/app_localizations.dart';
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

  String _greeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.greetingMorning;
    if (hour < 19) return l10n.greetingAfternoon;
    return l10n.greetingEvening;
  }

  String _message(AppLocalizations l10n) {
    if (total == 0) {
      return l10n.dailySummaryNoHabits;
    }
    if (rate >= 1) {
      return l10n.dailySummaryAllComplete;
    }
    if (rate >= 0.5) {
      return l10n.dailySummaryPartial(total - completed);
    }
    if (completed == 0) {
      return l10n.dailySummaryNoneComplete;
    }
    return l10n.dailySummaryKeepGoing;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppCard(
      variant: AppCardVariant.elevated,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.caption(DateFormatters.displayDate(DateTime.now(), l10n)),
          const VGap.sm(),
          AppText.h1(_greeting(l10n)),
          const VGap.md(),
          AppText.body(_message(l10n), color: AppColors.textSecondary),
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
