import 'package:flutter/material.dart';
import 'package:ser_manos/shared/molecules/input/app_text_field.dart';

/// A reusable register form that only renders the input fields
/// and exposes a public `submit` method for validation and submission.
class RegisterForm extends StatefulWidget {
  final void Function(
      String name,
      String surname,
      String email,
      String password,
      ) onSubmit;

  const RegisterForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _surname = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _surname.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  /// Checks if form fields are valid without submitting.
  bool validateFieldsOnly() {
    return _formKey.currentState?.validate() ?? false;
  }

  /// Call this from an external button to validate and submit the registration form.
  bool submit() {
    if (!_formKey.currentState!.validate()) return false;
    widget.onSubmit(
      _name.text.trim(),
      _surname.text.trim(),
      _email.text.trim(),
      _password.text.trim(),
    );
    return true;
  }

  String? _required(String? value, String field) =>
      (value == null || value.trim().isEmpty) ? '$field requerido' : null;

  String? _emailValidator(String? value) {
    final basic = _required(value, 'Email');
    if (basic != null) return basic;
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(value!.trim()) ? null : 'Ingrese un email válido';
  }

  String? _passwordValidator(String? value) {
    final basic = _required(value, 'Contraseña');
    if (basic != null) return basic;
    if (value!.trim().length < 6) return 'Mínimo 6 caracteres';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // Validates on input change; adjust as needed.
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          AppTextField(
            labelText: 'Nombre',
            hintText: 'Ej: Juan',
            labelBehavior: FloatingLabelBehavior.always,
            keyboardType: TextInputType.name,
            controller: _name,
            validator: (v) => _required(v, 'Nombre'),
          ),
          const SizedBox(height: 24),
          AppTextField(
            labelText: 'Apellido',
            hintText: 'Ej: Bárcena',
            labelBehavior: FloatingLabelBehavior.always,
            keyboardType: TextInputType.name,
            controller: _surname,
            validator: (v) => _required(v, 'Apellido'),
          ),
          const SizedBox(height: 24),
          AppTextField(
            labelText: 'Email',
            hintText: 'Ej: juanbarcena@mail.com',
            labelBehavior: FloatingLabelBehavior.always,
            keyboardType: TextInputType.emailAddress,
            controller: _email,
            validator: _emailValidator,
          ),
          const SizedBox(height: 24),
          PasswordField(
            labelText: 'Contraseña',
            hintText: 'Ej: ABCD1234',
            labelBehavior: FloatingLabelBehavior.always,
            controller: _password,
            validator: _passwordValidator,
          ),
        ],
      ),
    );
  }
}