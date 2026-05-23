import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/core/storage/hive_storage.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_frequency.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habits/repositories/habit_repository.dart';

void main() {
  late HabitRepository repository;

  setUp(() async {
    final tempDir = await Directory.systemTemp.createTemp('hive_test');
    await HiveStorage.initForTest(tempDir.path);
    repository = HabitRepository();
  });

  tearDown(() async {
    await HiveStorage.close();
  });

  HabitModel sampleHabit({String name = 'Leer'}) {
    return HabitModel.create(
      name: name,
      frequency: HabitFrequency.daily,
    );
  }

  test('save y getById persisten un hábito', () async {
    final habit = sampleHabit();
    await repository.save(habit);

    final stored = repository.getById(habit.id);
    expect(stored, isNotNull);
    expect(stored!.name, 'Leer');
    expect(stored.frequency, HabitFrequency.daily);
  });

  test('getAll ordena por fecha de creación descendente', () async {
    final first = sampleHabit(name: 'Primero');
    await Future<void>.delayed(const Duration(milliseconds: 5));
    final second = sampleHabit(name: 'Segundo');

    await repository.save(first);
    await repository.save(second);

    final all = repository.getAll();
    expect(all.length, 2);
    expect(all.first.name, 'Segundo');
  });

  test('delete elimina un hábito', () async {
    final habit = sampleHabit();
    await repository.save(habit);
    await repository.delete(habit.id);

    expect(repository.getById(habit.id), isNull);
    expect(repository.getAll(), isEmpty);
  });

  test('toggleCompletion agrega y quita fechas', () async {
    final habit = sampleHabit();
    await repository.save(habit);
    final today = DateTime(2026, 5, 22);

    final completed = await repository.toggleCompletion(habit.id, today);
    expect(completed!.isCompletedOn(today), isTrue);

    final uncompleted = await repository.toggleCompletion(habit.id, today);
    expect(uncompleted!.isCompletedOn(today), isFalse);
  });

  test('save actualiza un hábito existente', () async {
    final habit = sampleHabit(name: 'Original');
    await repository.save(habit);

    final updated = habit.copyWith(name: 'Actualizado');
    await repository.save(updated);

    expect(repository.getById(habit.id)?.name, 'Actualizado');
    expect(repository.getById(habit.id)?.completedDates, habit.completedDates);
  });

  test('todayCompletionRate calcula porcentaje del día', () async {
    final a = sampleHabit(name: 'A');
    final b = sampleHabit(name: 'B');
    await repository.save(a);
    await repository.save(b);
    await repository.toggleCompletion(a.id, DateTime.now());

    expect(repository.completedTodayCount, 1);
    expect(repository.todayCompletionRate, 0.5);
  });

  test('todayStatsFor calcula métricas en un solo paso', () async {
    final a = sampleHabit(name: 'A');
    final b = sampleHabit(name: 'B');
    await repository.save(a);
    await repository.save(b);
    await repository.toggleCompletion(a.id, DateTime.now());

    final stats = repository.todayStatsFor(repository.getAll());

    expect(stats.total, 2);
    expect(stats.completed, 1);
    expect(stats.rate, 0.5);
  });
}
