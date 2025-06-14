import 'package:flutter/material.dart';
import 'package:ser_manos/shared/molecules/input/app_text_field.dart';

/// A reusable login form that only renders the input fields
/// and exposes a public `submit` method to trigger validation and submission.
class LoginForm extends StatefulWidget {
  final void Function(String email, String password) onSubmit;

  const LoginForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  /// Call this method from an external button to perform validation and submit the form.
  bool submit() {
    if (!_formKey.currentState!.validate()) return false;

    widget.onSubmit(_email.text.trim(), _password.text.trim());
    return true;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'El email es requerido';
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(value.trim()) ? null : 'Ingrese un email válido';
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'La contraseña es requerida';
    if (value.trim().length < 6) return 'Mínimo 6 caracteres';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          AppTextField(
            labelText: 'Email',
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            controller: _email,
            validator: _emailValidator,
          ),
          const SizedBox(height: 24),
          PasswordField(
            labelText: 'Contraseña',
            hintText: 'Contraseña',
            controller: _password,
            validator: _passwordValidator,
          ),
        ],
      ),
    );
  }
}