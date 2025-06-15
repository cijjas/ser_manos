import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ser_manos/shared/molecules/input/app_text_field.dart';

class FormBuilderAppTextField extends StatefulWidget {
  final String name;
  final String labelText;
  final String hintText;
  final String? helperText;
  final TextInputType keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final ValueChanged<String>? onChanged;

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
    this.onChanged,
  });

  @override
  State<FormBuilderAppTextField> createState() => _FormBuilderAppTextFieldState();
}

class _FormBuilderAppTextFieldState extends State<FormBuilderAppTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _syncController(String? value) {
    if (_controller.text != (value ?? '')) {
      _controller.text = value ?? '';
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: widget.name,
      validator: widget.validator,
      builder: (field) {
        _syncController(field.value);
        return AppTextField(
          labelText: widget.labelText,
          hintText: widget.hintText,
          helperText: widget.helperText,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          controller: _controller,
          onChanged: (value) {
            field.didChange(value);
            if (widget.onChanged != null) widget.onChanged!(value);
          },
          validator: widget.validator,
        );
      },
    );
  }
}