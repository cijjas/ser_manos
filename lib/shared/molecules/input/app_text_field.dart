import 'package:flutter/material.dart';
import 'package:ser_manos/shared/tokens/colors.dart';
import 'package:ser_manos/shared/tokens/typography.dart';

/// Campo de texto base del Design-System Ser Manos.
class AppTextField extends StatelessWidget {
  // ───────── Config ─────────
  final String labelText;
  final String hintText;
  final String? helperText;

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final bool obscureText;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FloatingLabelBehavior labelBehavior;
  final FormFieldValidator<String>? validator;
  final bool enabled;

  final bool readOnly;
  final VoidCallback? onTap;

  const AppTextField({
    super.key,
    required this.labelText,
    this.hintText = '',
    this.helperText,
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.labelBehavior = FloatingLabelBehavior.auto,
    this.validator,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: enabled,
      readOnly: readOnly,
      onTap: onTap,
      style: AppTypography.subtitle01.copyWith(
        color: enabled ? AppColors.neutral100 : AppColors.neutral50,
      ),
      cursorColor: AppColors.secondary200,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        floatingLabelBehavior: labelBehavior,

        // ─ Texto ─
        floatingLabelStyle: AppTypography.caption.copyWith(color: AppColors.secondary200),
        labelStyle: AppTypography.caption.copyWith(color: AppColors.neutral75),
        hintStyle:
        AppTypography.subtitle01.copyWith(color: AppColors.neutral50),
        helperStyle:
        AppTypography.caption.copyWith(color: AppColors.neutral75),
        errorStyle:
        AppTypography.caption.copyWith(color: AppColors.error100),

        // ─ Bordes ─
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.neutral75),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.neutral75),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary200, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error100, width: 2),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.neutral25),
        ),

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

// ───────────────────────── Password wrapper ────────────────────────────
class PasswordField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final FloatingLabelBehavior labelBehavior;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool enabled;

  const PasswordField({
    super.key,
    required this.labelText,
    this.hintText = '',
    this.controller,
    this.onChanged,
    this.labelBehavior = FloatingLabelBehavior.auto,
    this.validator,
    this.enabled = true,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: widget.labelText,
      hintText: widget.hintText,
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: _obscure,
      labelBehavior: widget.labelBehavior,
      validator: widget.validator,
      enabled: widget.enabled,
      suffixIcon: IconButton(
        splashRadius: 20,
        icon: Icon(
          _obscure ? Icons.visibility_off : Icons.visibility,
          color: AppColors.neutral75,
        ),
        onPressed: () => setState(() => _obscure = !_obscure),
      ),
    );
  }
}
