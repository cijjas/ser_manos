import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/molecules/input/text_field.dart';

import '../atoms/symbols/app_symbol_text.dart';
import '../molecules/status_bar/status_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _canLogin = ValueNotifier(false);

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Add your login logic here
    debugPrint('Email: $email');
    debugPrint('Password: $password');
  }

  void _updateCanLogin() {
    _canLogin.value = _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StatusBar(
        style: StatusBarStyle.blue,
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
                        labelText: "Email",
                        hintText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        onChanged: (_) => _updateCanLogin(),
                      ),
                      PasswordField(
                        labelText: "Contraseña",
                        hintText: "Contraseña",
                        controller: _passwordController,
                        onChanged: (_) => _updateCanLogin(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: _canLogin,
                    builder: (context, canLogin, child) {
                      return AppButton(
                        label: "Iniciar Sesión",
                        onPressed: canLogin ? _handleLogin : null,
                        type: AppButtonType.filled,
                        fillWidth: true,
                      );
                    },
                  ),
                  AppButton(
                    label: "No tengo cuenta",
                    onPressed: () => debugPrint("No tengo cuenta"),
                    type: AppButtonType.tonal,
                    fillWidth: true,
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
