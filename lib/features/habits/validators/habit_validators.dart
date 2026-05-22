abstract final class HabitValidators {
  static const int maxNameLength = 50;

  static String? name(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'El nombre es obligatorio';
    }
    if (trimmed.length > maxNameLength) {
      return 'Máximo $maxNameLength caracteres';
    }
    return null;
  }
}
