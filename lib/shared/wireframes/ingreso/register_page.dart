import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/providers/auth_provider.dart';
import 'package:ser_manos/providers/user_provider.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/molecules/input/app_text_field.dart';
import 'package:ser_manos/models/user.dart' as model;

import '../../atoms/symbols/app_symbol_text.dart';
import '../../molecules/status_bar/status_bar.dart';
import '../../tokens/colors.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _canRegister = ValueNotifier(false);
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleRegister() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final name = _nameController.text.trim();
    final surname = _surnameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      // Register user with Firebase Auth
      final UserCredential credential = await ref.read(authServiceProvider).register(email, password);

      // Get the user ID from Firebase Auth
      final String userId = credential.user!.uid;

      // Create user document in Firestore
      final user = model.User(
        id: userId,
        nombre: name,
        apellido: surname,
        email: email,
        // Add other required fields based on your User model
      );

      // Use UserService to store the user data
      await ref.read(createUserProvider(user).future);

      if (context.mounted) {
        context.go('/welcome');
      }
    } on FirebaseAuthException catch (e) {
      // If Firestore write fails but Auth user was created, delete that user to rollback
      // TODO preguntar usar Cloud Function para crear el usuario de un en el onCreate
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await currentUser.delete();
      }

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
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al registrar usuario.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateCanRegister() {
    _canRegister.value = _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _surnameController.text.isNotEmpty;
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
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: _canRegister,
                    builder: (context, canRegister, child) {
                      return AppButton(
                        label: _isLoading ? "Registrando..." : "Registrarse",
                        onPressed: (_isLoading || !canRegister) ? null : _handleRegister,
                        type: AppButtonType.filled,
                      );
                    },
                  ),
                  AppButton(
                    label: "Ya tengo cuenta",
                    onPressed: _isLoading ? null : () => context.go('/login'),
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