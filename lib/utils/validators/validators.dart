// lib/utils/validators.dart

class AppValidators {
  static String? email(String? value, {bool isFocused = false}) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Ingresá un email.';
    final regexp = RegExp(r'^[\w\-\.+]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!regexp.hasMatch(email)) return 'El email no es válido.';
    return null;
  }

  /// Validates login password only after submit.
  static String? loginPassword(String? value, {required bool submitPressed}) {
    if (!submitPressed) return null;
    final password = value ?? '';
    if (password.isEmpty) return 'Ingresá una contraseña.';
    return null;
  }

  /// Validates register password after submit.
  static String? registerPassword(String? value, {required bool submitPressed}) {
    if (!submitPressed) return null;
    final password = value ?? '';
    if (password.isEmpty) return 'Ingresá una contraseña.';
    if (password.length < 6) return 'Debe tener al menos 6 caracteres.';
    return null;
  }

  /// Validates non-empty fields, skips if field has focus.
  static String? nonEmpty(String? value, {required bool isFocused, required String label}) {
    if (isFocused) return null;
    if ((value ?? '').trim().isEmpty) return 'Ingresá tu $label.';
    return null;
  }

  static String? required(String? value, {required String label, bool isFocused = false}) {
    if (isFocused) return null;
    if ((value ?? '').trim().isEmpty) return 'Ingresá tu $label.';
    return null;
  }

  static String? phone(String? value, {bool isFocused = false}) {
    if (isFocused) return null;
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Ingresá tu teléfono.';
    final isValid = RegExp(r'^\+?\d{6,15}$').hasMatch(v);
    if (!isValid) return 'El teléfono no es válido.';
    return null;
  }

}
