// lib/shared/wireframes/perfil/editar_perfil.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../models/user.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/user_provider.dart';
import '../../cells/cards/card_input.dart';
import '../../cells/cards/card_foto.dart';
import '../../molecules/input/date_field.dart';
import '../../molecules/input/app_text_field.dart';
import '../../molecules/buttons/app_button.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

class EditarPerfilPage extends ConsumerStatefulWidget {
  const EditarPerfilPage({Key? key}) : super(key: key);

  @override
  ConsumerState<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends ConsumerState<EditarPerfilPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fechaCtrl;
  late TextEditingController _telefonoCtrl;
  late TextEditingController _emailCtrl;
  int? _sexoIndex;
  String? _fotoUrl;
  User? _original;

  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fechaCtrl = TextEditingController();
    _telefonoCtrl = TextEditingController();
    _emailCtrl = TextEditingController();

    // Cargo datos actuales del usuario
    final fbUser = ref.read(authStateProvider).maybeWhen(
      data: (u) => u,
      orElse: () => null,
    );
    if (fbUser != null) {
      ref.read(userByIdProvider(fbUser.uid).future).then((u) {
        if (u != null) {
          _original = u;
          _emailCtrl.text = u.email;
          _telefonoCtrl.text = u.telefono ?? '';
          if (u.fechaNacimiento != null) {
            _fechaCtrl.text =
                DateFormat('dd/MM/yyyy').format(u.fechaNacimiento!);
          }
          _sexoIndex = u.genero != null
              ? ['Hombre', 'Mujer', 'No binario'].indexOf(u.genero!)
              : null;
          _fotoUrl = u.imagenUrl;
          setState(() {});
        }
      });
    }
  }

  @override
  void dispose() {
    _fechaCtrl.dispose();
    _telefonoCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  /// Abre picker, sube la foto a Firebase Storage y actualiza [_fotoUrl].
  Future<void> _pickImage() async {
    final fbUser = ref.read(authStateProvider).maybeWhen(
      data: (u) => u,
      orElse: () => null,
    );
    if (fbUser == null) return;

    try {
      final picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 75,
      );
      if (picked == null) return;

      final file = File(picked.path);
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/${fbUser.uid}.jpg');
      final uploadTask = storageRef.putFile(file);
      final snapshot = await uploadTask;
      final url = await snapshot.ref.getDownloadURL();

      setState(() => _fotoUrl = url);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foto actualizada correctamente')),
      );
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al subir foto: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error inesperado: $e')),
      );
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final fbUser = ref.read(authStateProvider).maybeWhen(
      data: (u) => u,
      orElse: () => null,
    );
    if (fbUser == null) return context.go('/login');
    if (_original == null) return;

    // Creo la copia actualizada
    final updated = _original!.copyWith(
      email: _emailCtrl.text.trim(),
      telefono: _telefonoCtrl.text.trim(),
      fechaNacimiento: _fechaCtrl.text.isNotEmpty
          ? DateFormat('dd/MM/yyyy').parse(_fechaCtrl.text)
          : null,
      genero: (_sexoIndex != null)
          ? ['Hombre', 'Mujer', 'No binario'][_sexoIndex!]
          : null,
      imagenUrl: _fotoUrl,
    );

    // Llamo al provider para guardar
    await ref.read(updateUserProvider(updated).future);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Datos guardados exitosamente')),
    );
    // Vuelvo al perfil
    context.go('/home/perfil');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral0,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, size: 24),
          onPressed: () => context.pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.neutral100,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- Título ---
                  Text(
                    'Datos de perfil',
                    style: AppTypography.headline01
                        .copyWith(color: AppColors.neutral100),
                  ),
                  const SizedBox(height: 24),

                  // --- Fecha de nacimiento ---
                  DateField(
                    label: 'Fecha de nacimiento',
                    controller: _fechaCtrl,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  ),
                  const SizedBox(height: 24),

                  // --- Sexo ---
                  CardInput(
                    title: 'Información de perfil',
                    options: const ['Hombre', 'Mujer', 'No binario'],
                    selectedIndex: _sexoIndex,       // ← aquí
                    onSelected: (i) => setState(() => _sexoIndex = i),
                  ),
                  const SizedBox(height: 24),

                  // --- Foto ---
                  CardFotoPerfil(
                    imageUrl: _fotoUrl,
                    onChange: _pickImage,
                  ),
                  const SizedBox(height: 32),

                  // --- Datos de contacto ---
                  Text(
                    'Datos de contacto',
                    style: AppTypography.headline01
                        .copyWith(color: AppColors.neutral100),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Estos datos serán compartidos con la organización para ponerse en contacto contigo',
                    style: AppTypography.subtitle01
                        .copyWith(color: AppColors.neutral100),
                  ),
                  const SizedBox(height: 16),

                  // Teléfono
                  AppTextField(
                    labelText: 'Teléfono',
                    hintText: 'Ej: +5491178445459',
                    controller: _telefonoCtrl,
                    keyboardType: TextInputType.phone,
                    validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 24),

                  // Mail
                  AppTextField(
                    labelText: 'Mail',
                    hintText: 'Ej: mimail@mail.com',
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Requerido';
                      if (_original != null && v.trim() == _original!.email)
                        return null;
                      final regex =
                      RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                      return regex.hasMatch(v) ? null : 'Email inválido';
                    },
                  ),
                  const SizedBox(height: 32),

                  // Botón guardar
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      label: 'Guardar datos',
                      onPressed: _save,
                      type: AppButtonType.filled,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
