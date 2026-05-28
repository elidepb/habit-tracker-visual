// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Habit Tracker';

  @override
  String get appNameSuffix => 'Visual';

  @override
  String get navHome => 'Home';

  @override
  String get navStatistics => 'Statistics';

  @override
  String get navSettings => 'Settings';

  @override
  String get homeTitle => 'Habits';

  @override
  String get homeStatsTooltip => 'Statistics';

  @override
  String get homeNewHabitTooltip => 'New habit';

  @override
  String get homeLoadError => 'Could not load habits';

  @override
  String get homeYourHabits => 'Your habits';

  @override
  String get homeEmptyTitle => 'No habits yet';

  @override
  String get homeEmptyBody =>
      'Create your first habit to start tracking your progress.';

  @override
  String get homeEmptyCreateButton => 'Create habit';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get dailySummaryNoHabits =>
      'Start by creating your first habit and build consistency day by day.';

  @override
  String get dailySummaryAllComplete =>
      'Excellent! You completed all your habits today. Keep it up.';

  @override
  String dailySummaryPartial(int remaining) {
    return 'You\'re on track. $remaining left to complete today.';
  }

  @override
  String get dailySummaryNoneComplete =>
      'You haven\'t completed any habits today yet. Take the first step!';

  @override
  String get dailySummaryKeepGoing =>
      'Every check counts. Keep moving forward with your habits.';

  @override
  String dateDisplay(String weekday, int day, String month) {
    return '$weekday, $month $day';
  }

  @override
  String get statCompleted => 'Completed';

  @override
  String get statProgress => 'Progress';

  @override
  String get statBestStreak => 'Best streak';

  @override
  String get statConsistency => 'Consistency';

  @override
  String get statActiveDays => 'Active days';

  @override
  String get statWeeklyAverage => 'Weekly average';

  @override
  String get statCompletion => 'Completion';

  @override
  String get statCurrentStreak => 'Current streak';

  @override
  String get unitDays => 'days';

  @override
  String get unitPercent => '%';

  @override
  String get heatmapIntensityNone => 'No activity';

  @override
  String get heatmapIntensityCompleted => 'Completed';

  @override
  String get heatmapIntensityLow => 'Low activity';

  @override
  String get heatmapIntensityMedium => 'Medium activity';

  @override
  String get heatmapIntensityHigh => 'High activity';

  @override
  String get heatmapIntensityAll => 'All completed';

  @override
  String get heatmapIntensityDefault => 'Activity';

  @override
  String get heatmapAnnualTitle => 'Annual activity';

  @override
  String heatmapActiveDaysThisYear(int count) {
    return '$count active days this year';
  }

  @override
  String get heatmapLegendLess => 'Less';

  @override
  String get heatmapLegendMore => 'More';

  @override
  String heatmapTooltipNoActivity(String date) {
    return '$date — No activity';
  }

  @override
  String heatmapTooltipLevel(String date, int level) {
    return '$date — Level $level';
  }

  @override
  String heatmapTooltipWithIntensity(String date, String intensity) {
    return '$date — $intensity';
  }

  @override
  String get statisticsTitle => 'Statistics';

  @override
  String get statisticsEmptyTitle => 'No data yet';

  @override
  String get statisticsEmptyBody =>
      'Create habits and log checks to see your global statistics.';

  @override
  String get statsOverviewTitle => 'Overview';

  @override
  String get weeklyChartEmpty => 'No activity this week';

  @override
  String get weeklyChartTitle => 'Weekly activity';

  @override
  String get weeklyChartSubtitle => 'Checks completed per day (last 7 days)';

  @override
  String get habitRankingEmpty => 'Create habits to see the ranking';

  @override
  String get habitRankingTitle => 'Habit ranking';

  @override
  String get habitRankingSubtitle => 'Sorted by completion rate';

  @override
  String habitRankingCompletion(int percent) {
    return '$percent% completion';
  }

  @override
  String get habitDetailEditTooltip => 'Edit';

  @override
  String get habitDetailAnnualActivity => 'Annual activity';

  @override
  String get habitDetailHistory => 'History';

  @override
  String get habitDetailReminder => 'Reminder';

  @override
  String get habitDetailEditButton => 'Edit habit';

  @override
  String get habitDetailDeleteButton => 'Delete habit';

  @override
  String get heatmapDayCompleted => 'Completed';

  @override
  String get heatmapDayNotCompleted => 'Not completed';

  @override
  String get habitStatusCompletedToday => 'Completed today';

  @override
  String get habitStatusPendingToday => 'Pending today';

  @override
  String habitCurrentStreak(int streak) {
    return 'Current streak: $streak days';
  }

  @override
  String get habitStatsTitle => 'Statistics';

  @override
  String get calendarTapHint => 'Tap a day to mark or unmark as completed.';

  @override
  String get formReminderTimeRequired => 'Select a time for the reminder';

  @override
  String get formEditTitle => 'Edit habit';

  @override
  String get formCreateTitle => 'New habit';

  @override
  String get formNameLabel => 'Habit name';

  @override
  String get formNameHint => 'e.g. Read 30 minutes';

  @override
  String get formSaveChanges => 'Save changes';

  @override
  String get formCreateButton => 'Create habit';

  @override
  String get formColorLabel => 'Color';

  @override
  String get formIconLabel => 'Icon';

  @override
  String get formFrequencyLabel => 'Frequency';

  @override
  String get reminderTitle => 'Reminder';

  @override
  String get reminderSubtitle => 'Get a daily notification';

  @override
  String get timeSelectFallback => 'Select time';

  @override
  String get timeEmptyFallback => '—';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get onboardingWelcomeTitle => 'Welcome';

  @override
  String get onboardingWelcomeSubtitle =>
      'Track your habits with a GitHub-inspired heatmap. Build consistency, one day at a time.';

  @override
  String get onboardingHeatmapTitle => 'Visual heatmap';

  @override
  String get onboardingHeatmapDescription =>
      'See your annual progress at a glance.';

  @override
  String get onboardingStreaksTitle => 'Streaks';

  @override
  String get onboardingStreaksDescription =>
      'Stay motivated with daily streaks.';

  @override
  String get onboardingStartButton => 'Get started';

  @override
  String get deleteHabitTitle => 'Delete habit';

  @override
  String deleteHabitMessageNamed(String habitName) {
    return 'Delete \"$habitName\"? This action cannot be undone.';
  }

  @override
  String get deleteHabitMessageGeneric =>
      'This action cannot be undone. Do you want to delete this habit?';

  @override
  String get habitNotFound => 'Habit not found';

  @override
  String checkFeedbackStreak(int streak) {
    return 'Done! $streak-day streak';
  }

  @override
  String get checkFeedbackCompleted => 'Habit completed today!';

  @override
  String get frequencyDaily => 'Daily';

  @override
  String get frequencyWeekly => 'Weekly';

  @override
  String get frequencyCustom => 'Custom';

  @override
  String get validationNameRequired => 'Name is required';

  @override
  String validationNameMaxLength(int max) {
    return 'Maximum $max characters';
  }

  @override
  String get notificationChannelName => 'Habit reminders';

  @override
  String get notificationChannelDescription =>
      'Daily reminders to complete your habits';

  @override
  String get notificationReminderTitle => 'Habit reminder';

  @override
  String notificationReminderBody(String habitName) {
    return 'Time to complete: $habitName';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsAppearanceSection => 'Appearance';

  @override
  String get settingsThemeTitle => 'Theme';

  @override
  String get settingsThemeSubtitle => 'Choose the app\'s color mode';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get settingsLanguageSection => 'Language';

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsLanguageSubtitle => 'Choose the app language';

  @override
  String get languageSystem => 'System';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageEnglish => 'English';

  @override
  String get settingsNotificationsSection => 'Notifications';

  @override
  String get settingsRemindersTitle => 'Reminders';

  @override
  String get settingsRemindersSubtitle =>
      'Daily alerts based on each habit\'s time';

  @override
  String get settingsNotificationsUnsupported =>
      'Notifications are not available on this platform.';

  @override
  String get settingsAllowNotifications => 'Allow notifications';

  @override
  String get monthShortJan => 'Jan';

  @override
  String get monthShortFeb => 'Feb';

  @override
  String get monthShortMar => 'Mar';

  @override
  String get monthShortApr => 'Apr';

  @override
  String get monthShortMay => 'May';

  @override
  String get monthShortJun => 'Jun';

  @override
  String get monthShortJul => 'Jul';

  @override
  String get monthShortAug => 'Aug';

  @override
  String get monthShortSep => 'Sep';

  @override
  String get monthShortOct => 'Oct';

  @override
  String get monthShortNov => 'Nov';

  @override
  String get monthShortDec => 'Dec';

  @override
  String get monthLongJan => 'January';

  @override
  String get monthLongFeb => 'February';

  @override
  String get monthLongMar => 'March';

  @override
  String get monthLongApr => 'April';

  @override
  String get monthLongMay => 'May';

  @override
  String get monthLongJun => 'June';

  @override
  String get monthLongJul => 'July';

  @override
  String get monthLongAug => 'August';

  @override
  String get monthLongSep => 'September';

  @override
  String get monthLongOct => 'October';

  @override
  String get monthLongNov => 'November';

  @override
  String get monthLongDec => 'December';

  @override
  String get weekdayMonday => 'Monday';

  @override
  String get weekdayTuesday => 'Tuesday';

  @override
  String get weekdayWednesday => 'Wednesday';

  @override
  String get weekdayThursday => 'Thursday';

  @override
  String get weekdayFriday => 'Friday';

  @override
  String get weekdaySaturday => 'Saturday';

  @override
  String get weekdaySunday => 'Sunday';

  @override
  String get weekdayLetterSun => 'S';

  @override
  String get weekdayLetterMon => 'M';

  @override
  String get weekdayLetterTue => 'T';

  @override
  String get weekdayLetterWed => 'W';

  @override
  String get weekdayLetterThu => 'T';

  @override
  String get weekdayLetterFri => 'F';

  @override
  String get weekdayLetterSat => 'S';

  @override
  String get monthCalendarJan => 'January';

  @override
  String get monthCalendarFeb => 'February';

  @override
  String get monthCalendarMar => 'March';

  @override
  String get monthCalendarApr => 'April';

  @override
  String get monthCalendarMay => 'May';

  @override
  String get monthCalendarJun => 'June';

  @override
  String get monthCalendarJul => 'July';

  @override
  String get monthCalendarAug => 'August';

  @override
  String get monthCalendarSep => 'September';

  @override
  String get monthCalendarOct => 'October';

  @override
  String get monthCalendarNov => 'November';

  @override
  String get monthCalendarDec => 'December';

  @override
  String get iconActivity => 'Activity';

  @override
  String get iconExercise => 'Exercise';

  @override
  String get iconReading => 'Reading';

  @override
  String get iconSleep => 'Sleep';

  @override
  String get iconWater => 'Water';

  @override
  String get iconMind => 'Mind';

  @override
  String get iconHealth => 'Health';

  @override
  String get iconTime => 'Time';
}
