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
import 'package:ser_manos/utils/app_strings.dart';
import 'package:ser_manos/models/user.dart' as model;

import '../../../utils/validators/validators.dart';

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
  final _passwordFocus = FocusNode();

  final ValueNotifier<bool> _canRegister = ValueNotifier(false);
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _surnameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _updateCanRegister() {
    final form = _formKey.currentState;
    if (form == null) return;
    final name = (form.fields['name']?.value ?? '') as String;
    final surname = (form.fields['surname']?.value ?? '') as String;
    final email = (form.fields['email']?.value ?? '') as String;
    final password = (form.fields['password']?.value ?? '') as String;

    _canRegister.value = name.isNotEmpty &&
        surname.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty;
  }

  Future<void> _handleRegister() async {
    setState(() {
      _errorMessage = null;
    });

    final valid = _formKey.currentState?.saveAndValidate() ?? false;
    if (!valid) return;

    setState(() => _isLoading = true);

    final name = _formKey.currentState!.value['name'] as String;
    final surname = _formKey.currentState!.value['surname'] as String;
    final email = _formKey.currentState!.value['email'] as String;
    final password = _formKey.currentState!.value['password'] as String;

    try {
      final cred =
          await ref.read(authServiceProvider).register(email, password);
      final uid = cred.user!.uid;

      final newUser = model.User(
          id: uid,
          name: name,
          surname: surname,
          email: email,
          hasSeenOnboarding: false);

      await ref.read(createUserProvider(newUser).future);
      await saveFcmTokenToFirestore(uid);

      await ref.read(authServiceProvider).signIn(email, password);

      await FirebaseAuth.instance.authStateChanges().first;
    } on FirebaseAuthException catch (e) {
      // Si fallo el registro y el usuario quedó creado, lo borramos
      final current = FirebaseAuth.instance.currentUser;
      if (current != null) await current.delete();

      setState(() {
        switch (e.code) {
          case 'email-already-in-use':
            _errorMessage = context.strings.emailAlreadyRegistered;
            break;
          case 'invalid-email':
            _errorMessage = context.strings.invalidEmailFormat;
            break;
          case 'weak-password':
            _errorMessage = context.strings.weakPassword;
            break;
          default:
            _errorMessage = context.strings.genericError;
        }
      });
    } catch (_) {
      if (mounted) {
        setState(() => _errorMessage = context.strings.userRegistrationError);
      }
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
                          FormBuilder(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            child: Column(
                              children: [
                                FormBuilderAppTextField(
                                  focusNode: _nameFocus,
                                  name: 'name',
                                  labelText: context.strings.name,
                                  hintText: context.strings.nameHint,
                                  keyboardType: TextInputType.name,
                                  validator: (v) => AppValidators.required(
                                      v, context,
                                      label:
                                          context.strings.name.toLowerCase()),
                                  onChanged: (_) => _updateCanRegister(),
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) => {
                                    _formKey.currentState?.fields["name"]
                                        ?.validate(),
                                    _surnameFocus.requestFocus()
                                  },
                                ),
                                const SizedBox(height: 24),
                                FormBuilderAppTextField(
                                    focusNode: _surnameFocus,
                                    name: 'surname',
                                    labelText: context.strings.surname,
                                    hintText: context.strings.surnameHint,
                                    keyboardType: TextInputType.name,
                                    validator: (v) => AppValidators.required(
                                        v, context,
                                        label: context.strings.surname
                                            .toLowerCase()),
                                    onChanged: (_) => _updateCanRegister(),
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) => {
                                          _formKey
                                              .currentState?.fields["surname"]
                                              ?.validate(),
                                          _emailFocus.requestFocus(),
                                        }),
                                const SizedBox(height: 24),
                                FormBuilderAppTextField(
                                    focusNode: _emailFocus,
                                    name: 'email',
                                    labelText: context.strings.email,
                                    hintText: context.strings.emailHint,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) =>
                                        AppValidators.email(value, context),
                                    onChanged: (_) => _updateCanRegister(),
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (_) => {
                                          _formKey.currentState?.fields["email"]
                                              ?.validate(),
                                          _passwordFocus.requestFocus(),
                                        }),
                                const SizedBox(height: 24),
                                FormBuilderPasswordField(
                                  focusNode: _passwordFocus,
                                  name: 'password',
                                  labelText: context.strings.password,
                                  hintText: context.strings.passwordHint,
                                  validator: (value) =>
                                      AppValidators.registerPassword(
                                          value, context),
                                  onChanged: (_) => _updateCanRegister(),
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) {
                                    if (_canRegister.value && !_isLoading) {
                                      _handleRegister();
                                    }
                                  },
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
                valueListenable: _canRegister,
                builder: (_, canRegister, __) => Column(
                  children: [
                    AppButton(
                      label: _isLoading
                          ? context.strings.registering
                          : context.strings.registerPageTitle,
                      onPressed:
                          (_isLoading || !canRegister) ? null : _handleRegister,
                      type: AppButtonType.filled,
                    ),
                    AppButton(
                      label: context.strings.alreadyHaveAccount,
                      onPressed:
                          _isLoading ? null : () => context.go(AppRoutes.login),
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
