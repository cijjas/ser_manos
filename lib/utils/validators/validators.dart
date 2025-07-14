import 'package:flutter/widgets.dart';
import 'package:ser_manos/utils/app_strings.dart';

class AppValidators {
  static String? email(String? value, BuildContext context) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return context.strings.requiredFieldError;
    final regexp = RegExp(r'^[\w\-+]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!regexp.hasMatch(email)) return context.strings.invalidEmailError;
    return null;
  }

  static String? loginPassword(String? value, BuildContext context, {required bool submitPressed}) {
    if (!submitPressed) return null;
    final password = value ?? '';
    if (password.isEmpty) return context.strings.requiredFieldError;
    return null;
  }

  static String? registerPassword(String? value, BuildContext context) {
    final password = value ?? '';
    if (password.isEmpty) return context.strings.requiredFieldError;
    if (password.length < 6) return context.strings.passwordTooShortError;
    return null;
  }

  static String? required(String? value, BuildContext context, {required String label}) {
    if (value == null || value.trim().isEmpty) {
      return context.strings.requiredFieldError;
    }
    return null;
  }

  static String? phone(String? value, BuildContext context, {bool isFocused = false}) {
    if (isFocused) return null;
    final raw = value?.trim() ?? '';
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    final lengthOk = digits.length >= 8 && digits.length <= 15;
    final startsOk = RegExp(r'^[1-9]\d*$').hasMatch(digits);

    if (!(lengthOk && startsOk)) return context.strings.invalidPhoneError;
    return null;
  }
}
