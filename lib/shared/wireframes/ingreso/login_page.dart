import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/providers/auth_provider.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/molecules/input/app_text_field.dart';

import '../../../providers/user_provider.dart';
import '../../atoms/symbols/app_symbol_text.dart';
import '../../molecules/status_bar/status_bar.dart';
import '../../tokens/colors.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _canLogin = ValueNotifier(false);
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      await ref.read(authServiceProvider).signIn(email, password);

      if (context.mounted) {
        final updatedUser = await ref.read(currentUserProvider.future);

        if (context.mounted) {
          if (!(updatedUser.hasSeenOnboarding ?? true)) {
            context.go('/welcome');
          } else {
            context.go('/home/postularse');
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'user-not-found':
            _errorMessage = 'No existe usuario con ese email.';
            break;
          case 'wrong-password':
            _errorMessage = 'Contraseña incorrecta.';
            break;
          case 'invalid-credential':
            _errorMessage = 'Credenciales inválidas.';
            break;
          default:
            _errorMessage = 'Error: ${e.message}';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al iniciar sesión.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateCanLogin() {
    _canLogin.value =
        _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen for authentication state changes
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      backgroundColor: AppColors.neutral0,
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
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
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
                        label: _isLoading
                            ? "Iniciando sesión..."
                            : "Iniciar Sesión",
                        onPressed:
                            (_isLoading || !canLogin) ? null : _handleLogin,
                        type: AppButtonType.filled,
                      );
                    },
                  ),
                  AppButton(
                    label: "No tengo cuenta",
                    onPressed:
                        _isLoading ? null : () => context.go('/register'),
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
