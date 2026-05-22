import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/core/theme/app_colors.dart';
import 'package:habit_tracker_visual/features/habits/models/habit_frequency.dart';
import 'package:uuid/uuid.dart';

class HabitModel {
  const HabitModel({
    required this.id,
    required this.name,
    required this.colorValue,
    required this.iconName,
    required this.frequency,
    required this.createdAt,
    this.reminderEnabled = false,
    this.reminderHour,
    this.reminderMinute,
    this.completedDates = const [],
  });

  factory HabitModel.create({
    required String name,
    int? colorValue,
    String iconName = 'activity',
    HabitFrequency frequency = HabitFrequency.daily,
    bool reminderEnabled = false,
    int? reminderHour,
    int? reminderMinute,
  }) {
    return HabitModel(
      id: const Uuid().v4(),
      name: name,
      colorValue: colorValue ?? AppColors.primary.toARGB32(),
      iconName: iconName,
      frequency: frequency,
      reminderEnabled: reminderEnabled,
      reminderHour: reminderHour,
      reminderMinute: reminderMinute,
      createdAt: DateTime.now(),
    );
  }

  final String id;
  final String name;
  final int colorValue;
  final String iconName;
  final HabitFrequency frequency;
  final bool reminderEnabled;
  final int? reminderHour;
  final int? reminderMinute;
  final DateTime createdAt;
  final List<String> completedDates;

  Color get color => Color(colorValue);

  bool isCompletedOn(DateTime date) {
    return completedDates.contains(dateKey(date));
  }

  bool isCompletedToday() => isCompletedOn(DateTime.now());

  static String dateKey(DateTime date) {
    final local = DateTime(date.year, date.month, date.day);
    return '${local.year.toString().padLeft(4, '0')}-'
        '${local.month.toString().padLeft(2, '0')}-'
        '${local.day.toString().padLeft(2, '0')}';
  }

  HabitModel copyWith({
    String? name,
    int? colorValue,
    String? iconName,
    HabitFrequency? frequency,
    bool? reminderEnabled,
    int? reminderHour,
    int? reminderMinute,
    List<String>? completedDates,
    bool clearReminderHour = false,
    bool clearReminderMinute = false,
  }) {
    return HabitModel(
      id: id,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
      iconName: iconName ?? this.iconName,
      frequency: frequency ?? this.frequency,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderHour: clearReminderHour ? null : (reminderHour ?? this.reminderHour),
      reminderMinute:
          clearReminderMinute ? null : (reminderMinute ?? this.reminderMinute),
      createdAt: createdAt,
      completedDates: completedDates ?? this.completedDates,
    );
  }

  HabitModel toggleCompletion(DateTime date) {
    final key = dateKey(date);
    final updated = List<String>.from(completedDates);
    if (updated.contains(key)) {
      updated.remove(key);
    } else {
      updated.add(key);
    }
    return copyWith(completedDates: updated);
  }
}
