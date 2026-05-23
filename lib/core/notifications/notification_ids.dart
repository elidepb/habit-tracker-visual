abstract final class NotificationIds {
  static int forHabit(String habitId) => habitId.hashCode & 0x7FFFFFFF;
}
