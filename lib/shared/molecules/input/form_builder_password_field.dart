// form_builder_password_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ser_manos/shared/molecules/input/app_text_field.dart';

class FormBuilderPasswordField extends StatefulWidget {
  final String name;
  final String labelText;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool enabled;

  const FormBuilderPasswordField({
    super.key,
    required this.name,
    required this.labelText,
    this.hintText = '',
    this.validator,
    this.enabled = true,
  });

  @override
  State<FormBuilderPasswordField> createState() => _FormBuilderPasswordFieldState();
}

class _FormBuilderPasswordFieldState extends State<FormBuilderPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: widget.name,
      validator: widget.validator,
      builder: (field) {
        return AppTextField(
          labelText: widget.labelText,
          hintText: widget.hintText,
          obscureText: _obscure,
          enabled: widget.enabled,
          controller: TextEditingController(text: field.value)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: field.value?.length ?? 0),
            ),
          onChanged: field.didChange,
          validator: widget.validator,
          suffixIcon: IconButton(
            splashRadius: 20,
            icon: Icon(
              _obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () => setState(() => _obscure = !_obscure),
          ),
        );
      },
    );
  }
}

