import 'package:flutter/material.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:ser_manos/shared/tokens/colors.dart';
import 'package:ser_manos/shared/tokens/typography.dart';

import '../../atoms/icons/app_icons.dart';

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

  const AppTextField({
    super.key,
    required this.labelText,
    this.hintText = "",
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text, // Default to text input
    this.obscureText = false, // Default to not obscured
    this.suffixIcon,
    this.prefixIcon,
    this.labelBehavior = FloatingLabelBehavior.auto,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: AppTypography.caption.copyWith(color: AppColors.neutral75),
        hintStyle: AppTypography.subtitle01.copyWith(color: AppColors.neutral50),
        floatingLabelBehavior: labelBehavior,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.neutral75, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary200, width: 2.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error100, width: 2.0),
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

  const PasswordField({
    super.key,
    required this.labelText,
    this.hintText = "",
    this.controller,
    this.onChanged,
    this.labelBehavior = FloatingLabelBehavior.auto,
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
      suffixIcon: IconButton(
        icon: AppIcon(
          icon: _obscureText ? AppIcons.MOSTRAR : AppIcons.OCULTAR,
          overrideColor: AppColors.neutral75,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final FloatingLabelBehavior labelBehavior;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const SearchField({
    super.key,
    required this.labelText,
    this.hintText = "",
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text, // Default to text input
    this.obscureText = false, // Default to not obscured
    this.suffixIcon,
    this.prefixIcon,
    this.labelBehavior = FloatingLabelBehavior.auto,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: labelText,
      hintText: hintText,
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      suffixIcon: suffixIcon,
      labelBehavior: labelBehavior,
      prefixIcon: const AppIcon(icon: AppIcons.BUSCAR, overrideColor: AppColors.neutral75),
    );
  }
}