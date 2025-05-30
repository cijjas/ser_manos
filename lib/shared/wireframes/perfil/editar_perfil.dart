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
  const EditarPerfilPage({super.key});

  @override
  ConsumerState<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends ConsumerState<EditarPerfilPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fechaCtrl;
  late final TextEditingController _telefonoCtrl;
  late final TextEditingController _emailCtrl;

  int? _sexoIndex;
  String? _fotoUrl;
  bool _subiendo = false;
  User? _original;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fechaCtrl = TextEditingController();
    _telefonoCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final fbUser = ref.read(authStateProvider).maybeWhen(
      data: (u) => u,
      orElse: () => null,
    );
    if (fbUser == null) return;

    final user = await ref.read(userByIdProvider(fbUser.uid).future);

    setState(() {
      _original = user;
      _emailCtrl.text = user.email;
      _telefonoCtrl.text = user.telefono ?? '';
      if (user.fechaNacimiento != null) {
        _fechaCtrl.text =
            DateFormat('dd/MM/yyyy').format(user.fechaNacimiento!);
      }
      _sexoIndex = user.genero != null
          ? ['Hombre', 'Mujer', 'No binario'].indexOf(user.genero!)
          : null;
      _fotoUrl = user.imagenUrl;
    });
  }

  @override
  void dispose() {
    _fechaCtrl.dispose();
    _telefonoCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  /* ───────────────────────────  IMAGEN (cámara / galería) ─────────────────────────── */

  Future<void> _showImageSourceSelector() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Tomar una foto'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Elegir de galería'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source != null) _pickAndUpload(source);
  }

  Future<void> _pickAndUpload(ImageSource source) async {

    final fbUser = ref.read(authStateProvider).maybeWhen(
      data: (u) => u,
      orElse: () => null,
    );
    if (fbUser == null) return;

    final picked =
    await _picker.pickImage(source: source, imageQuality: 75);
    if (picked == null) return; // cancelado

    final file = File(picked.path);
    if (!file.existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La imagen no existe en disco (simulador).')),
      );
      return;
    }

    setState(() => _subiendo = true);

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/${fbUser.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg');

      final snapshot = await storageRef.putFile(file);
      if (snapshot.state != TaskState.success) {
        throw FirebaseException(plugin: 'firebase_storage', message: 'Upload failed');
      }

      final url = await storageRef.getDownloadURL();
      setState(() => _fotoUrl = url);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foto actualizada correctamente')),
      );
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al subir: ${e.message}')),
      );
    } finally {
      if (mounted) setState(() => _subiendo = false);
    }

  }

  /* ───────────────────────────  GUARDAR PERFIL ─────────────────────────── */

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final fbUser = ref.read(authStateProvider).maybeWhen(
      data: (u) => u,
      orElse: () => null,
    );
    if (fbUser == null) return context.go('/login');
    if (_original == null) return;

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

    await ref.read(updateUserProvider(updated).future);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Datos guardados exitosamente')),
    );
    context.go('/home/perfil');
  }

  /* ───────────────────────────  UI ─────────────────────────── */

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
            padding:
            const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Datos de perfil',
                    style: AppTypography.headline01
                        .copyWith(color: AppColors.neutral100)),
                const SizedBox(height: 24),
                DateField(
                  label: 'Fecha de nacimiento',
                  controller: _fechaCtrl,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                ),
                const SizedBox(height: 24),
                CardInput(
                  title: 'Información de perfil',
                  options: const ['Hombre', 'Mujer', 'No binario'],
                  selectedIndex: _sexoIndex,
                  onSelected: (i) => setState(() => _sexoIndex = i),
                ),
                const SizedBox(height: 24),
                CardFotoPerfil(
                  imageUrl: _fotoUrl,
                  isLoading: _subiendo,
                  onChange: _showImageSourceSelector,
                ),
                const SizedBox(height: 32),
                Text('Datos de contacto',
                    style: AppTypography.headline01
                        .copyWith(color: AppColors.neutral100)),
                const SizedBox(height: 16),
                AppTextField(
                  labelText: 'Teléfono',
                  hintText: 'Ej: +5491178445459',
                  controller: _telefonoCtrl,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 24),
                AppTextField(
                  labelText: 'Mail',
                  hintText: 'Ej: mimail@mail.com',
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Requerido';
                    if (_original != null &&
                        v.trim() == _original!.email) {
                      return null;
                    }
                    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                    return regex.hasMatch(v) ? null : 'Email inválido';
                  },
                ),
                const SizedBox(height: 32),
                AppButton(
                  label: 'Guardar datos',
                  onPressed: _save,
                  type: AppButtonType.filled,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
