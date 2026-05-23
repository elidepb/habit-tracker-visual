import 'package:habit_tracker_visual/features/habits/models/daily_check_result.dart';
import 'package:habit_tracker_visual/features/habits/repositories/habit_repository.dart';
import 'package:habit_tracker_visual/features/habits/utils/streak_calculator.dart';

class DailyCheckService {
  const DailyCheckService(this._repository);

  final HabitRepository _repository;

  Future<DailyCheckResult?> toggleToday(String habitId, {DateTime? date}) async {
    final targetDate = date ?? DateTime.now();
    final habit = _repository.getById(habitId);
    if (habit == null) return null;

    final wasCompleted = habit.isCompletedOn(targetDate);
    final updated = await _repository.toggleCompletion(habitId, targetDate);
    if (updated == null) return null;

    return DailyCheckResult(
      habit: updated,
      wasCompleted: wasCompleted,
      isCompleted: updated.isCompletedOn(targetDate),
      streak: StreakCalculator.currentStreak(updated.completedDates),
    );
  }

  bool isCompletedToday(String habitId) {
    return _repository.getById(habitId)?.isCompletedToday() ?? false;
  }

  bool isCompletedOn(String habitId, DateTime date) {
    return _repository.getById(habitId)?.isCompletedOn(date) ?? false;
  }

  List<String> completedDatesFor(String habitId) {
    return _repository.getById(habitId)?.completedDates ?? const [];
  }
}
