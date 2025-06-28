// login_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/constants/app_routes.dart';
import 'package:ser_manos/providers/auth_provider.dart';
import 'package:ser_manos/providers/user_provider.dart';
import 'package:ser_manos/services/fcm_token_service.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/molecules/input/form_builder_app_text_field.dart';
import 'package:ser_manos/shared/molecules/input/form_builder_password_field.dart';
import 'package:ser_manos/shared/atoms/symbols/app_symbol_text.dart';
import 'package:ser_manos/shared/molecules/status_bar/status_bar.dart';
import 'package:ser_manos/shared/tokens/colors.dart';

import '../../../utils/validators/validators.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  /// --- Form & focus -----------------------------------------------
  final _formKey = GlobalKey<FormBuilderState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  /// --- UI state ----------------------------------------------------
  final ValueNotifier<bool> _canLogin = ValueNotifier(false);
  bool _isLoading = false;
  String? _errorMessage;
  bool _submitPressed = false; // sólo mostramos errores de contraseña al enviar

  // ───────────────────────── Validators ────────────────────────────
  String? _emailValidator(String? value) =>
      AppValidators.email(value, isFocused: _emailFocus.hasFocus);

  String? _passwordValidator(String? value) =>
      AppValidators.loginPassword(value, submitPressed: _submitPressed);

  // ───────────────────────── Lifecycle ─────────────────────────────
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  // ───────────────────────── Helpers ───────────────────────────────
  void _updateCanLogin() {
    final form = _formKey.currentState;
    if (form == null) return;
    final email = (form.fields['email']?.value ?? '') as String;
    final password = (form.fields['password']?.value ?? '') as String;
    _canLogin.value = email.isNotEmpty && password.isNotEmpty;
  }

  // ───────────────────────── Actions ───────────────────────────────
  Future<void> _handleLogin() async {
    setState(() {
      _submitPressed = true;
      _errorMessage = null;
    });

    // Guarda y valida el formulario completo
    final isValid = _formKey.currentState?.saveAndValidate() ?? false;
    if (!isValid) return;

    setState(() => _isLoading = true);

    final email = _formKey.currentState!.value['email'] as String;
    final password = _formKey.currentState!.value['password'] as String;

    try {
      await ref.read(authServiceProvider).signIn(email, password);
      final updatedUser = await ref.read(currentUserProvider.future);
      await saveFcmTokenToFirestore(updatedUser.id);

      if (!mounted) return;
      if (!(updatedUser.hasSeenOnboarding)) {
        context.go(AppRoutes.welcome);
      } else {
        context.go(AppRoutes.homeVolunteering);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'user-not-found':
          case 'wrong-password':
          case 'invalid-credential':
            _errorMessage = 'El email o contraseña son incorrectos.';
            break;
          default:
            _errorMessage = 'Error: ${e.message}';
        }
      });
    } catch (_) {
      setState(() => _errorMessage = 'Error al iniciar sesión.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ───────────────────────── Build ─────────────────────────────────
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.neutral0,
      appBar: const StatusBar(style: StatusBarStyle.light),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            children: [
              // ---------- Logo & campos ----------
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.7,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const AppSymbolText(),
                          const SizedBox(height: 32),

                          /// ---------------- FORM ----------------
                          FormBuilder(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            child: Column(
                              children: [
                                FormBuilderAppTextField(
                                  focusNode: _emailFocus,
                                  name: 'email',
                                  labelText: 'Email',
                                  hintText: 'Email',
                                  keyboardType: TextInputType.emailAddress,
                                  validator: _emailValidator,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) {
                                    _formKey.currentState?.fields['email']
                                        ?.validate();
                                    FocusScope.of(context)
                                        .requestFocus(_passwordFocus);
                                  },
                                  onChanged: (_) => _updateCanLogin(),
                                ),
                                const SizedBox(height: 24),
                                FormBuilderPasswordField(
                                  focusNode: _passwordFocus,
                                  name: 'password',
                                  labelText: 'Contraseña',
                                  hintText: 'Contraseña',
                                  validator: _passwordValidator,
                                  onChanged: (_) => _updateCanLogin(),
                                  textInputAction: TextInputAction.done,
                                ),
                              ],
                            ),
                          ),
                          if (_errorMessage != null) ...[
                            const SizedBox(height: 16),
                            Text(
                              _errorMessage!,
                              style: const TextStyle(color: AppColors.error100),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // ---------- Botones ----------
              ValueListenableBuilder<bool>(
                valueListenable: _canLogin,
                builder: (_, canLogin, __) => Column(
                  children: [
                    AppButton(
                      label:
                          _isLoading ? 'Iniciando sesión...' : 'Iniciar Sesión',
                      onPressed:
                          (_isLoading || !canLogin) ? null : _handleLogin,
                      type: AppButtonType.filled,
                    ),
                    AppButton(
                      label: 'No tengo cuenta',
                      onPressed: _isLoading
                          ? null
                          : () => context.go(AppRoutes.register),
                      type: AppButtonType.tonal,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
