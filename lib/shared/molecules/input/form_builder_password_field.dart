import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ser_manos/shared/molecules/input/app_text_field.dart';

class FormBuilderPasswordField extends StatefulWidget {
  final String name;
  final String labelText;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final ValueChanged<String>? onChanged;

  const FormBuilderPasswordField({
    super.key,
    required this.name,
    required this.labelText,
    this.hintText = '',
    this.validator,
    this.enabled = true,
    this.onChanged,
  });

  @override
  State<FormBuilderPasswordField> createState() => _FormBuilderPasswordFieldState();
}

class _FormBuilderPasswordFieldState extends State<FormBuilderPasswordField> {
  late final TextEditingController _controller;
  bool _obscure = true;

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
          obscureText: _obscure,
          enabled: widget.enabled,
          controller: _controller,
          onChanged: (value) {
            field.didChange(value);
            if (widget.onChanged != null) widget.onChanged!(value);
          },
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