// register_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/providers/auth_provider.dart';
import 'package:ser_manos/providers/user_provider.dart';
import 'package:ser_manos/services/fcm_token_service.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/molecules/input/form_builder_app_text_field.dart';
import 'package:ser_manos/shared/molecules/input/form_builder_password_field.dart';
import 'package:ser_manos/shared/atoms/symbols/app_symbol_text.dart';
import 'package:ser_manos/shared/molecules/status_bar/status_bar.dart';
import 'package:ser_manos/shared/tokens/colors.dart';
import 'package:ser_manos/models/user.dart' as model;

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  final _nameFocus = FocusNode();
  final _surnameFocus = FocusNode();
  final _emailFocus = FocusNode();

  final ValueNotifier<bool> _canRegister = ValueNotifier(false);
  bool _isLoading = false;
  String? _errorMessage;
  bool _submitPressed = false;

  String? _nonEmptyValidator(String? value, FocusNode focus, String label) {
    if (focus.hasFocus) return null; // No molestar mientras escribe
    if ((value ?? '').trim().isEmpty) return 'Ingresá tu $label.';
    return null;
  }

  String? _emailValidator(String? value) {
    if (_emailFocus.hasFocus) return null;
    final email = (value ?? '').trim();
    if (email.isEmpty) return 'Ingresá un email.';
    final re = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!re.hasMatch(email)) return 'El formato del email no es válido.';
    return null;
  }

  String? _passwordValidator(String? value) {
    if (!_submitPressed) return null; // Sólo al enviar
    final pass = value ?? '';
    if (pass.isEmpty) return 'Ingresá una contraseña.';
    if (pass.length < 6) return 'Debe tener al menos 6 caracteres.';
    return null;
  }

  @override
  void initState() {
    super.initState();

    // Disparar validacion onBlur
    [_nameFocus, _surnameFocus, _emailFocus].forEach((fn) {
      fn.addListener(() {
        if (!fn.hasFocus) {
          final name = fn == _nameFocus
              ? 'name'
              : fn == _surnameFocus
              ? 'surname'
              : 'email';
          _formKey.currentState?.fields[name]?.validate();
        }
      });
    });
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _surnameFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  void _updateCanRegister() {
    final form = _formKey.currentState;
    if (form == null) return;
    final name = (form.fields['name']?.value ?? '') as String;
    final surname = (form.fields['surname']?.value ?? '') as String;
    final email = (form.fields['email']?.value ?? '') as String;
    final password = (form.fields['password']?.value ?? '') as String;

    _canRegister.value =
        name.isNotEmpty && surname.isNotEmpty && email.isNotEmpty && password.isNotEmpty;
  }

  Future<void> _handleRegister() async {
    setState(() {
      _submitPressed = true;
      _errorMessage = null;
    });

    final valid = _formKey.currentState?.saveAndValidate() ?? false;
    if (!valid) return;

    setState(() => _isLoading = true);

    final name     = _formKey.currentState!.value['name'] as String;
    final surname  = _formKey.currentState!.value['surname'] as String;
    final email    = _formKey.currentState!.value['email'] as String;
    final password = _formKey.currentState!.value['password'] as String;

    try {
      final cred = await ref.read(authServiceProvider).register(email, password);
      final uid  = cred.user!.uid;

      final newUser = model.User(
        id: uid,
        nombre: name,
        apellido: surname,
        email: email,
      );

      await ref.read(createUserProvider(newUser).future);
      await saveFcmTokenToFirestore(uid);

      if (!mounted) return;
      context.go('/welcome');
    } on FirebaseAuthException catch (e) {
      // Si fallo el registro y el usuario quedó creado, lo borramos
      final current = FirebaseAuth.instance.currentUser;
      if (current != null) await current.delete();

      setState(() {
        switch (e.code) {
          case 'email-already-in-use':
            _errorMessage = 'Este email ya está registrado.';
            break;
          case 'invalid-email':
            _errorMessage = 'El formato del email no es válido.';
            break;
          case 'weak-password':
            _errorMessage = 'La contraseña es demasiado débil.';
            break;
          default:
            _errorMessage = 'Error: ${e.message}';
        }
      });
    } catch (_) {
      setState(() => _errorMessage = 'Error al registrar usuario.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

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
              // ---------- Logo + campos ----------
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

                          /// ----------- FORM -----------
                          FormBuilder(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: Column(
                              children: [
                                // Nombre
                                Focus(
                                  focusNode: _nameFocus,
                                  child: FormBuilderAppTextField(
                                    name: 'name',
                                    labelText: 'Nombre',
                                    hintText: 'Ej: Juan',
                                    keyboardType: TextInputType.name,
                                    validator: (v) =>
                                        _nonEmptyValidator(v, _nameFocus, 'nombre'),
                                    onChanged: (_) => _updateCanRegister(),
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Apellido
                                Focus(
                                  focusNode: _surnameFocus,
                                  child: FormBuilderAppTextField(
                                    name: 'surname',
                                    labelText: 'Apellido',
                                    hintText: 'Ej: Bárcena',
                                    keyboardType: TextInputType.name,
                                    validator: (v) => _nonEmptyValidator(
                                        v, _surnameFocus, 'apellido'),
                                    onChanged: (_) => _updateCanRegister(),
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Email
                                Focus(
                                  focusNode: _emailFocus,
                                  child: FormBuilderAppTextField(
                                    name: 'email',
                                    labelText: 'Email',
                                    hintText: 'Ej: juan@mail.com',
                                    keyboardType: TextInputType.emailAddress,
                                    validator: _emailValidator,
                                    onChanged: (_) => _updateCanRegister(),
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Contraseña
                                FormBuilderPasswordField(
                                  name: 'password',
                                  labelText: 'Contraseña',
                                  hintText: 'Mínimo 6 caracteres',
                                  validator: _passwordValidator,
                                  onChanged: (_) => _updateCanRegister(),
                                ),
                              ],
                            ),
                          ),

                          // Mensaje de error global
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
                valueListenable: _canRegister,
                builder: (_, canRegister, __) => Column(
                  children: [
                    AppButton(
                      label: _isLoading ? 'Registrando...' : 'Registrarse',
                      onPressed: (_isLoading || !canRegister) ? null : _handleRegister,
                      type: AppButtonType.filled,
                    ),
                    AppButton(
                      label: 'Ya tengo cuenta',
                      onPressed: _isLoading ? null : () => context.go('/login'),
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
