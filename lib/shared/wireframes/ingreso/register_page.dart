import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/molecules/input/app_text_field.dart';

import '../../atoms/symbols/app_symbol_text.dart';
import '../../molecules/status_bar/status_bar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _canRegister = ValueNotifier(false);

  void _handleRegister() {
    final name = _nameController.text.trim();
    final surname = _surnameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Add your login logic here
    debugPrint('Name: $name');
    debugPrint('Surname: $surname');
    debugPrint('Email: $email');
    debugPrint('Password: $password');
    context.go('/welcome');
  }

  void _updateCanRegister() {
    _canRegister.value = _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty && _surnameController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StatusBar(
        style: StatusBarStyle.light,
        timeText: '',
        showPlaceHolders: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AppSymbolText(),
                    const SizedBox(height: 32),
                    Column(
                      spacing: 24,
                      children: [
                        AppTextField(
                          labelText: "Nombre",
                          hintText: "Ej: Juan",
                          labelBehavior: FloatingLabelBehavior.always,
                          keyboardType: TextInputType.name,
                          controller: _nameController,
                          onChanged: (_) => _updateCanRegister(),
                        ),
                        AppTextField(
                          labelText: "Apellido",
                          hintText: "Ej: Barcena",
                          labelBehavior: FloatingLabelBehavior.always,
                          keyboardType: TextInputType.name,
                          controller: _surnameController,
                          onChanged: (_) => _updateCanRegister(),
                        ),
                        AppTextField(
                          labelText: "Email",
                          hintText: "Ej: juanbarcena@mail.com",
                          labelBehavior: FloatingLabelBehavior.always,
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          onChanged: (_) => _updateCanRegister(),
                        ),
                        PasswordField(
                          labelText: "Contraseña",
                          hintText: "Ej: ABCD1234",
                          labelBehavior: FloatingLabelBehavior.always,
                          controller: _passwordController,
                          onChanged: (_) => _updateCanRegister(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: _canRegister,
                    builder: (context, canRegister, child) {
                      return AppButton(
                        label: "Registrarse",
                        onPressed: canRegister ? _handleRegister : null,
                        type: AppButtonType.filled,
                      );
                    },
                  ),
                  AppButton(
                    label: "Ya tengo cuenta",
                    onPressed: () => context.go('/login'),
                    type: AppButtonType.tonal,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
