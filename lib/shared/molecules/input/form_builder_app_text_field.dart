import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:ser_manos/shared/molecules/input/app_text_field.dart';

class FormBuilderAppTextField extends StatefulWidget {
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
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
  });

  final String name;
  final String labelText;
  final String hintText;
  final String? helperText;
  final TextInputType keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;

  @override
  State<FormBuilderAppTextField> createState() =>
      _FormBuilderAppTextFieldState();
}

class _FormBuilderAppTextFieldState extends State<FormBuilderAppTextField> {
  late final TextEditingController _controller = TextEditingController();

  // ────────────────────────── INTERNAL ──────────────────────────

  /// Keeps the controller in sync with the form-field value,
  /// **without mutating it during the build phase**.
  void _syncController(String? newValue) {
    final text = newValue ?? '';
    if (_controller.text == text) return;

    // Defer the change to the end of the current frame → no assertion.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _controller.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    });
  }

  // ────────────────────────── WIDGET LIFECYCLE ──────────────────────────

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final field = FormBuilder.of(context)?.fields[widget.name];
    _syncController(field?.value);
  }

  @override
  void didUpdateWidget(covariant FormBuilderAppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final field = FormBuilder.of(context)?.fields[widget.name];
    _syncController(field?.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ────────────────────────── BUILD ──────────────────────────

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: widget.name,
      validator: widget.validator,
      enabled: widget.enabled,
      builder: (field) {
        // Make sure controller stays current once per frame, not during build.
        _syncController(field.value);

        return AppTextField(
          focusNode: widget.focusNode,
          labelText: widget.labelText,
          hintText: widget.hintText,
          helperText: widget.helperText,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          controller: _controller,
          validator: widget.validator,
          onChanged: (value) {
            field.didChange(value);
            widget.onChanged?.call(value);
          },
          onFieldSubmitted: widget.onFieldSubmitted,
          textInputAction: widget.textInputAction,
        );
      },
    );
  }
}
