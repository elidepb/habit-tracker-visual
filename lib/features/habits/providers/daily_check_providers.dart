import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_visual/features/habits/models/daily_check_result.dart';
import 'package:habit_tracker_visual/features/habits/providers/habit_providers.dart';
import 'package:habit_tracker_visual/features/habits/services/daily_check_service.dart';
import 'package:habit_tracker_visual/features/habits/utils/streak_calculator.dart';

final dailyCheckServiceProvider = Provider<DailyCheckService>((ref) {
  return DailyCheckService(ref.watch(habitRepositoryProvider));
});

class DailyCheckNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => {};

  bool isLoading(String habitId) => state.contains(habitId);

  Future<DailyCheckResult?> toggle(String habitId) async {
    if (state.contains(habitId)) return null;

    state = {...state, habitId};

    try {
      final result =
          await ref.read(dailyCheckServiceProvider).toggleToday(habitId);
      if (result != null) {
        _triggerHaptic(result);
      }
      return result;
    } finally {
      state = state.where((id) => id != habitId).toSet();
    }
  }

  void _triggerHaptic(DailyCheckResult result) {
    if (result.justCompleted) {
      HapticFeedback.mediumImpact();
    } else if (result.justUncompleted) {
      HapticFeedback.lightImpact();
    }
  }
}

final dailyCheckProvider =
    NotifierProvider<DailyCheckNotifier, Set<String>>(DailyCheckNotifier.new);

final isCompletedTodayProvider = Provider.family<bool, String>((ref, habitId) {
  ref.watch(habitsStreamProvider);
  return ref.watch(dailyCheckServiceProvider).isCompletedToday(habitId);
});

final habitStreakProvider = Provider.family<int, String>((ref, habitId) {
  ref.watch(habitsStreamProvider);
  final dates = ref.watch(dailyCheckServiceProvider).completedDatesFor(habitId);
  return StreakCalculator.currentStreak(dates);
});
