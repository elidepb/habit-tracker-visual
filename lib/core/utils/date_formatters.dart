import 'package:flutter/material.dart';
import 'package:habit_tracker_visual/l10n/app_localizations.dart';

abstract final class DateFormatters {
  static List<String> shortMonthNames(AppLocalizations l10n) => [
        l10n.monthShortJan,
        l10n.monthShortFeb,
        l10n.monthShortMar,
        l10n.monthShortApr,
        l10n.monthShortMay,
        l10n.monthShortJun,
        l10n.monthShortJul,
        l10n.monthShortAug,
        l10n.monthShortSep,
        l10n.monthShortOct,
        l10n.monthShortNov,
        l10n.monthShortDec,
      ];

  static List<String> longMonthNames(AppLocalizations l10n) => [
        l10n.monthLongJan,
        l10n.monthLongFeb,
        l10n.monthLongMar,
        l10n.monthLongApr,
        l10n.monthLongMay,
        l10n.monthLongJun,
        l10n.monthLongJul,
        l10n.monthLongAug,
        l10n.monthLongSep,
        l10n.monthLongOct,
        l10n.monthLongNov,
        l10n.monthLongDec,
      ];

  static List<String> weekdayLabels(AppLocalizations l10n) => [
        l10n.weekdayMonday,
        l10n.weekdayTuesday,
        l10n.weekdayWednesday,
        l10n.weekdayThursday,
        l10n.weekdayFriday,
        l10n.weekdaySaturday,
        l10n.weekdaySunday,
      ];

  static List<String> heatmapDayLabels(AppLocalizations l10n) => [
        l10n.weekdayLetterSun,
        l10n.weekdayLetterMon,
        l10n.weekdayLetterTue,
        l10n.weekdayLetterWed,
        l10n.weekdayLetterThu,
        l10n.weekdayLetterFri,
        l10n.weekdayLetterSat,
      ];

  static List<String> calendarMonthNames(AppLocalizations l10n) => [
        l10n.monthCalendarJan,
        l10n.monthCalendarFeb,
        l10n.monthCalendarMar,
        l10n.monthCalendarApr,
        l10n.monthCalendarMay,
        l10n.monthCalendarJun,
        l10n.monthCalendarJul,
        l10n.monthCalendarAug,
        l10n.monthCalendarSep,
        l10n.monthCalendarOct,
        l10n.monthCalendarNov,
        l10n.monthCalendarDec,
      ];

  static List<String> calendarWeekdayLabels(AppLocalizations l10n) => [
        l10n.weekdayLetterMon,
        l10n.weekdayLetterTue,
        l10n.weekdayLetterWed,
        l10n.weekdayLetterThu,
        l10n.weekdayLetterFri,
        l10n.weekdayLetterSat,
        l10n.weekdayLetterSun,
      ];

  static String timeOfDay(
    TimeOfDay? value,
    AppLocalizations l10n,
  ) {
    if (value == null) return l10n.timeSelectFallback;
    return reminder(value.hour, value.minute, l10n);
  }

  static String reminder(
    int? hour,
    int? minute,
    AppLocalizations l10n,
  ) {
    if (hour == null || minute == null) return l10n.timeEmptyFallback;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  static String displayDate(DateTime date, AppLocalizations l10n) {
    return l10n.dateDisplay(
      weekdayLabels(l10n)[date.weekday - 1],
      date.day,
      longMonthNames(l10n)[date.month - 1],
    );
  }

  static String heatmapDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static String heatmapTooltip(
    DateTime date, {
    required int level,
    required AppLocalizations l10n,
    String Function(int level)? intensityLabel,
  }) {
    final dateStr = heatmapDate(date);
    if (intensityLabel != null) {
      return l10n.heatmapTooltipWithIntensity(
        dateStr,
        intensityLabel(level),
      );
    }
    if (level == 0) return l10n.heatmapTooltipNoActivity(dateStr);
    return l10n.heatmapTooltipLevel(dateStr, level);
  }
}
