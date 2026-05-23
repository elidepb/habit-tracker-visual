import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker_visual/core/storage/hive_storage.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_model.dart';
import 'package:habit_tracker_visual/features/habits/repositories/habit_repository.dart';
import 'package:habit_tracker_visual/features/habits/services/daily_check_service.dart';

void main() {
  late HabitRepository repository;
  late DailyCheckService service;

  setUp(() async {
    final tempDir = await Directory.systemTemp.createTemp('daily_check_test');
    await HiveStorage.initForTest(tempDir.path);
    repository = HabitRepository();
    service = DailyCheckService(repository);
  });

  tearDown(() async {
    await HiveStorage.close();
  });

  test('toggleToday marca hábito como completado', () async {
    final habit = HabitModel.create(name: 'Meditar');
    await repository.save(habit);

    final result = await service.toggleToday(habit.id);

    expect(result, isNotNull);
    expect(result!.justCompleted, isTrue);
    expect(result.isCompleted, isTrue);
    expect(result.streak, 1);
    expect(service.isCompletedToday(habit.id), isTrue);
  });

  test('toggleToday desmarca hábito completado', () async {
    final habit = HabitModel.create(name: 'Meditar');
    await repository.save(habit);
    await service.toggleToday(habit.id);

    final result = await service.toggleToday(habit.id);

    expect(result!.justUncompleted, isTrue);
    expect(result.isCompleted, isFalse);
    expect(service.isCompletedToday(habit.id), isFalse);
  });

  test('toggleToday retorna null si el hábito no existe', () async {
    final result = await service.toggleToday('invalid-id');
    expect(result, isNull);
  });

  test('toggleToday persiste entre lecturas', () async {
    final habit = HabitModel.create(name: 'Correr');
    await repository.save(habit);

    await service.toggleToday(habit.id);

    final reloaded = DailyCheckService(HabitRepository());
    expect(reloaded.isCompletedToday(habit.id), isTrue);
  });
}
