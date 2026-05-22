import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HabitIconOption {
  const HabitIconOption({required this.name, required this.icon, required this.label});

  final String name;
  final IconData icon;
  final String label;
}

abstract final class HabitIcons {
  static const List<HabitIconOption> options = [
    HabitIconOption(name: 'activity', icon: LucideIcons.activity, label: 'Actividad'),
    HabitIconOption(name: 'dumbbell', icon: LucideIcons.dumbbell, label: 'Ejercicio'),
    HabitIconOption(name: 'book', icon: LucideIcons.book, label: 'Lectura'),
    HabitIconOption(name: 'moon', icon: LucideIcons.moon, label: 'Sueño'),
    HabitIconOption(name: 'droplets', icon: LucideIcons.droplets, label: 'Agua'),
    HabitIconOption(name: 'brain', icon: LucideIcons.brain, label: 'Mente'),
    HabitIconOption(name: 'heart', icon: LucideIcons.heart, label: 'Salud'),
    HabitIconOption(name: 'timer', icon: LucideIcons.timer, label: 'Tiempo'),
  ];

  static IconData fromName(String name) {
    for (final option in options) {
      if (option.name == name) return option.icon;
    }
    return LucideIcons.activity;
  }

  static HabitIconOption optionFromName(String name) {
    for (final option in options) {
      if (option.name == name) return option;
    }
    return options.first;
  }
}
