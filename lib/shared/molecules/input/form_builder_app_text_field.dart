import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ser_manos/shared/molecules/input/app_text_field.dart';

class FormBuilderAppTextField extends StatelessWidget {
  final String name;
  final String labelText;
  final String hintText;
  final String? helperText;
  final TextInputType keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final ValueChanged<String>? onChanged; // AGREGADO

  const FormBuilderAppTextField({
    super.key,
    required this.name,
    required this.labelText,
    this.hintText = '',
    this.helperText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.enabled = true,
    this.onChanged, // AGREGADO
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: name,
      validator: validator,
      builder: (field) {
        return AppTextField(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
          keyboardType: keyboardType,
          obscureText: obscureText,
          enabled: enabled,
          controller: TextEditingController(text: field.value)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: field.value?.length ?? 0),
            ),
          onChanged: (value) {
            field.didChange(value);
            if (onChanged != null) onChanged!(value);
          },
          validator: validator,
        );
      },
    );
  }
}
