import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'app_text_field.dart';
import 'package:ser_manos/shared/tokens/colors.dart';

/// Campo solo-lectura que abre un selector de fecha.
class DateField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final FormFieldValidator<String>? validator;
  final ValueChanged<DateTime?>? onChanged;

  const DateField({
    Key? key,
    required this.label,
    required this.controller,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: label,
      hintText: 'DD/MM/YYYY',
      controller: controller,
      readOnly: true,
      validator: validator,
      prefixIcon: const Icon(
        Icons.calendar_month,
        color: AppColors.primary100,
        size: 20,
      ),
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: initialDate ?? (controller.text.isNotEmpty
              ? DateFormat('dd/MM/yyyy').parse(controller.text)
              : now),
          firstDate: firstDate ?? DateTime(1900),
          lastDate: lastDate ?? now,
          locale: Platform.isIOS ? const Locale('es') : null,
        );
        if (picked != null) {
          controller.text = DateFormat('dd/MM/yyyy').format(picked);
          onChanged?.call(picked);
        }
      },
    );
  }
}