import 'package:flutter/material.dart';

abstract final class DateFormatters {
  static const shortMonthNames = [
    'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
    'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic',
  ];

  static const longMonthNames = [
    'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
    'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre',
  ];

  static const weekdayLabels = [
    'Lunes', 'Martes', 'Miércoles', 'Jueves',
    'Viernes', 'Sábado', 'Domingo',
  ];

  static const heatmapDayLabels = ['D', 'L', 'M', 'X', 'J', 'V', 'S'];

  static const calendarMonthNames = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre',
  ];

  static const calendarWeekdayLabels = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

  static String timeOfDay(TimeOfDay? value, {String fallback = 'Seleccionar hora'}) {
    if (value == null) return fallback;
    return reminder(value.hour, value.minute);
  }

  static String reminder(int? hour, int? minute, {String fallback = '—'}) {
    if (hour == null || minute == null) return fallback;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  static String displayDate(DateTime date) {
    return '${weekdayLabels[date.weekday - 1]}, ${date.day} de ${longMonthNames[date.month - 1]}';
  }

  static String heatmapDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static String heatmapTooltip(
    DateTime date, {
    required int level,
    String Function(int level)? intensityLabel,
  }) {
    final dateStr = heatmapDate(date);
    if (intensityLabel != null) {
      return '$dateStr — ${intensityLabel(level)}';
    }
    if (level == 0) return '$dateStr — Sin actividad';
    return '$dateStr — Nivel $level';
  }
}
