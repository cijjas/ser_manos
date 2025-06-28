// lib/utils/validators/validators.dart

class AppValidators {
  static String? email(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Ingresá un email.';
    final regexp = RegExp(r'^[\w\-+]+@([\w\-]+\.)+[\w\-]{2,4}$');
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
  static String? registerPassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return 'Ingresá una contraseña.';
    if (password.length < 6) return 'Debe tener al menos 6 caracteres.';
    return null;
  }

  static String? required(String? value, {required String label}) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingresá tu $label.';
    }
    return null;
  }

  static String? phone(String? value, {bool isFocused = false}) {
    if (isFocused) return null;
    final raw = value?.trim() ?? '';
    if (raw.isEmpty) return 'Ingresá tu teléfono.';

    final digits = raw.replaceAll(RegExp(r'\D'), '');
    final lengthOk = digits.length >= 8 && digits.length <= 15;
    final startsOk = RegExp(r'^[1-9]\d*$').hasMatch(digits);

    if (!(lengthOk && startsOk)) return 'Ingresá un número de 8‑15 dígitos.';
    return null;
  }
}