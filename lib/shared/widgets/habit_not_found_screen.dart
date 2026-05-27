import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker_visual/core/l10n/l10n_extensions.dart';
import 'package:habit_tracker_visual/shared/widgets/ui/ui.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HabitNotFoundScreen extends StatelessWidget {
  const HabitNotFoundScreen({
    super.key,
    this.leadingIcon = LucideIcons.arrowLeft,
  });

  final IconData leadingIcon;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(leadingIcon),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(child: AppText.body(l10n.habitNotFound)),
    );
  }
}
