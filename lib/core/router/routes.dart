abstract final class Routes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String statistics = '/statistics';
  static const String settings = '/settings';
  static const String createHabit = '/create-habit';
  static const String editHabit = '/edit-habit';
  static const String habitDetail = '/habit-detail';

  static String habitDetailPath(String id) => '$habitDetail/$id';
  static String editHabitPath(String id) => '$editHabit/$id';
}
