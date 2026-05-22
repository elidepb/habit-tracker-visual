import 'package:hive/hive.dart';
import 'package:habit_tracker_visual/core/storage/hive_storage.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';

class HabitRepository {
  Box<HabitModel> get _box => Hive.box<HabitModel>(HiveBoxes.habits);

  List<HabitModel> getAll() {
    final habits = _box.values.toList();
    habits.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return habits;
  }

  HabitModel? getById(String id) => _box.get(id);

  Stream<List<HabitModel>> watchAll() async* {
    yield getAll();
    await for (final _ in _box.watch()) {
      yield getAll();
    }
  }

  Future<HabitModel> save(HabitModel habit) async {
    await _box.put(habit.id, habit);
    return habit;
  }

  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  Future<HabitModel?> toggleCompletion(String id, DateTime date) async {
    final habit = getById(id);
    if (habit == null) return null;

    final updated = habit.toggleCompletion(date);
    await save(updated);
    return updated;
  }

  int get completedTodayCount {
    final today = DateTime.now();
    return getAll().where((h) => h.isCompletedOn(today)).length;
  }

  double get todayCompletionRate {
    final habits = getAll();
    if (habits.isEmpty) return 0;
    return completedTodayCount / habits.length;
  }
}
