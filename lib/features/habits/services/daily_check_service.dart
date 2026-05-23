import 'package:habit_tracker_visual/features/habits/models/daily_check_result.dart';
import 'package:habit_tracker_visual/features/habits/repositories/habit_repository.dart';
import 'package:habit_tracker_visual/features/habits/utils/streak_calculator.dart';

class DailyCheckService {
  const DailyCheckService(this._repository);

  final HabitRepository _repository;

  Future<DailyCheckResult?> toggleForDate(String habitId, DateTime date) async {
    final targetDate = DateTime(date.year, date.month, date.day);
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    if (targetDate.isAfter(todayDate)) return null;

    final habit = _repository.getById(habitId);
    if (habit == null) return null;

    final created = DateTime(
      habit.createdAt.year,
      habit.createdAt.month,
      habit.createdAt.day,
    );
    if (targetDate.isBefore(created)) return null;

    return _toggle(habitId, targetDate);
  }

  Future<DailyCheckResult?> toggleToday(String habitId) async {
    return toggleForDate(habitId, DateTime.now());
  }

  Future<DailyCheckResult?> _toggle(String habitId, DateTime targetDate) async {
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
