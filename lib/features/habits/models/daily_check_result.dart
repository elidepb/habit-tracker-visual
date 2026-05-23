import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';

class DailyCheckResult {
  const DailyCheckResult({
    required this.habit,
    required this.wasCompleted,
    required this.isCompleted,
    required this.streak,
  });

  final HabitModel habit;
  final bool wasCompleted;
  final bool isCompleted;
  final int streak;

  bool get justCompleted => !wasCompleted && isCompleted;
  bool get justUncompleted => wasCompleted && !isCompleted;
}
