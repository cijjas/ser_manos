import 'package:flutter/material.dart';
import 'package:ser_manos/shared/tokens/colors.dart';
import 'package:ser_manos/shared/tokens/typography.dart';

class AppTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FloatingLabelBehavior labelBehavior;

  /// NEW  ➜  add a validator (optional) so it plays nice inside a `Form`
  final FormFieldValidator<String>? validator;

  const AppTextField({
    super.key,
    required this.labelText,
    this.hintText = '',
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.labelBehavior = FloatingLabelBehavior.auto,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(          // <-- switched from TextField ➜ TextFormField
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,        // <-- wire it up
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: AppTypography.caption.copyWith(color: AppColors.neutral75),
        hintStyle: AppTypography.subtitle01.copyWith(color: AppColors.neutral50),
        floatingLabelBehavior: labelBehavior,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.neutral75, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary200, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error100, width: 2),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}




class PasswordField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final FloatingLabelBehavior labelBehavior;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  /// NEW ➜  forward the validator
  final FormFieldValidator<String>? validator;

  const PasswordField({
    super.key,
    required this.labelText,
    this.hintText = '',
    this.controller,
    this.onChanged,
    this.labelBehavior = FloatingLabelBehavior.auto,
    this.validator,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: widget.labelText,
      hintText: widget.hintText,
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: _obscureText,
      labelBehavior: widget.labelBehavior,
      validator: widget.validator,           // <-- pass through
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: AppColors.neutral75,
        ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      ),
    );
  }
}