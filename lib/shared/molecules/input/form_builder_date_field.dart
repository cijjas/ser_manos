import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:ser_manos/shared/molecules/input/app_text_field.dart';
import 'package:ser_manos/shared/tokens/colors.dart';

class FormBuilderDateField extends StatelessWidget {
  final String name;
  final String label;
  final DateTime firstDate;
  final DateTime lastDate;
  final FormFieldValidator<String>? validator;

  const FormBuilderDateField({
    super.key,
    required this.name,
    required this.label,
    required this.firstDate,
    required this.lastDate,
    this.validator,
  });


  @override
  Widget build(BuildContext context) {
    return FormBuilderField<DateTime>(
      name: name,
      validator: (date) => validator?.call(
        date != null ? DateFormat('dd/MM/yyyy').format(date) : null,
      ),
      builder: (field) {
        final controller = TextEditingController(
          text: field.value != null
              ? DateFormat('dd/MM/yyyy').format(field.value!)
              : '',
        );

        return AppTextField(
          labelText: label,
          hintText: 'DD/MM/YYYY',
          errorText: field.errorText,
          controller: controller,
          readOnly: true,
          suffixIcon: const SizedBox(
            width: 24,
            height: 24,
            child: Icon(
              Icons.calendar_month,
              color: AppColors.primary100,
              size: 24,
            ),
          ),
          onTap: () async {
            final now = DateTime.now();
            final picked = await showDatePicker(
              context: context,
              initialDate: field.value ?? now,
              firstDate: firstDate,
              lastDate: lastDate,
              locale: Platform.isIOS ? const Locale('es') : null,
            );
            if (picked != null) {
              field.didChange(picked);
              field.validate();
            }
          },
        );
      },
    );
  }

}