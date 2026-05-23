import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/core/theme/app_durations.dart';
import 'package:habit_tracker_visual/features/habits/models/daily_check_result.dart';
import 'package:habit_tracker_visual/features/habits/providers/daily_check_providers.dart';

enum HabitCheckSize { sm, md, lg }

class HabitCheckButton extends ConsumerStatefulWidget {
  const HabitCheckButton({
    super.key,
    required this.habitId,
    required this.color,
    this.size = HabitCheckSize.md,
    this.onToggled,
  });

  final String habitId;
  final Color color;
  final HabitCheckSize size;
  final ValueChanged<DailyCheckResult>? onToggled;

  @override
  ConsumerState<HabitCheckButton> createState() => _HabitCheckButtonState();
}

class _HabitCheckButtonState extends ConsumerState<HabitCheckButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  double get _dimension => switch (widget.size) {
        HabitCheckSize.sm => 32,
        HabitCheckSize.md => 40,
        HabitCheckSize.lg => 56,
      };

  double get _iconSize => switch (widget.size) {
        HabitCheckSize.sm => 18,
        HabitCheckSize.md => 22,
        HabitCheckSize.lg => 28,
      };

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: AppDurations.normal,
    );
    _pulseAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    final result = await ref.read(dailyCheckProvider.notifier).toggle(widget.habitId);
    if (result?.justCompleted == true) {
      await _pulseController.forward(from: 0);
    }
    if (result != null) {
      widget.onToggled?.call(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted = ref.watch(isCompletedTodayProvider(widget.habitId));
    final loadingIds = ref.watch(dailyCheckProvider);
    final isLoading = loadingIds.contains(widget.habitId);

    return GestureDetector(
      onTap: isLoading ? null : _handleTap,
      child: ScaleTransition(
        scale: _pulseAnimation,
        child: AnimatedContainer(
          duration: AppDurations.normal,
          curve: Curves.easeOut,
          width: _dimension,
          height: _dimension,
          decoration: BoxDecoration(
            color: isCompleted ? widget.color : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: isCompleted ? widget.color : AppColors.border,
              width: 2,
            ),
            boxShadow: isCompleted
                ? [
                    BoxShadow(
                      color: widget.color.withValues(alpha: 0.35),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: isLoading
              ? Padding(
                  padding: EdgeInsets.all(_dimension * 0.2),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: isCompleted ? Colors.white : widget.color,
                  ),
                )
              : isCompleted
                  ? Icon(Icons.check, color: Colors.white, size: _iconSize)
                  : null,
        ),
      ),
    );
  }
}

void showDailyCheckFeedback(BuildContext context, DailyCheckResult result) {
  if (!result.justCompleted) return;

  final message = result.streak > 1
      ? '¡Completado! Racha de ${result.streak} días'
      : '¡Hábito completado hoy!';

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
}
