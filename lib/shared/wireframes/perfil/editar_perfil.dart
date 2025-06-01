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
  String? _fotoUrl; // URL de la imagen ya guardada en Firebase
  File? _imagenLocalParaSubir; //Archivo de imagen local seleccionado para subir
  bool _subiendoAlGuardar = false; //  Estado de carga para el proceso de guardado completo
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

    // Usamos try-catch por si el usuario no existe o hay error de red
    try {
      final user = await ref.read(userByIdProvider(fbUser.uid).future);
      if (!mounted) return;

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
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar datos del usuario: ${e.toString()}')),
        );
      }
    }
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
    if (_subiendoAlGuardar) return; // No permitir cambiar si ya se está guardando

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

    if (source != null) _seleccionarImagenLocal(source);
  }


  Future<void> _seleccionarImagenLocal(ImageSource source) async {
    final picked =
    await _picker.pickImage(source: source, imageQuality: 75, maxWidth: 800);
    if (picked == null) return; // cancelado

    final file = File(picked.path);
    if (!file.existsSync()) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('La imagen no existe en disco.')),
        );
      }
      return;
    }

    setState(() {
      _imagenLocalParaSubir = file;
      //  Si queres que la imagen anterior desaparezca de la vista previa inmediatamente:
      // _fotoUrl = null;
      // CardFotoPerfil ya deberia encargares igual
    });
  }

  /* ───────────────────────────  GUARDAR PERFIL ─────────────────────────── */

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final fbUser = ref.read(authStateProvider).maybeWhen(
      data: (u) => u,
      orElse: () => null,
    );
    if (fbUser == null) {
      if (mounted) context.go('/login'); // O la ruta que corresponda
      return;
    }
    if (_original == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudieron cargar los datos originales del usuario.')),
      );
      return;
    }

    setState(() => _subiendoAlGuardar = true);

    String? urlImagenFinalParaGuardar = _fotoUrl; // Inicia con la URL existente

    try {
      // Si hay una imagen local nueva seleccionada, subirla ahora
      if (_imagenLocalParaSubir != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images/${fbUser.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg');

        // Metadata para la imagen (opcional)
        final metadata = SettableMetadata(contentType: 'image/jpeg');

        final snapshot = await storageRef.putFile(_imagenLocalParaSubir!, metadata);

        if (snapshot.state != TaskState.success) {
          throw FirebaseException(plugin: 'firebase_storage', message: 'Error al subir la imagen.');
        }
        urlImagenFinalParaGuardar = await storageRef.getDownloadURL();
      }
      // Aquí podrías añadir lógica para eliminar la foto si el usuario lo indicó
      // (ej. si urlImagenFinalParaGuardar fue explícitamente seteado a null por una acción del usuario).

      final updated = _original!.copyWith(
        email: _emailCtrl.text.trim(),
        telefono: _telefonoCtrl.text.trim(),
        fechaNacimiento: _fechaCtrl.text.isNotEmpty
            ? DateFormat('dd/MM/yyyy').parse(_fechaCtrl.text)
            : null,
        genero: (_sexoIndex != null)
            ? ['Hombre', 'Mujer', 'No binario'][_sexoIndex!]
            : null,
        imagenUrl: urlImagenFinalParaGuardar, // Usar la URL final
      );

      await ref.read(updateUserProvider(updated).future);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos guardados exitosamente')),
      );

      // Actualizar estado local después de un guardado exitoso
      setState(() {
        _imagenLocalParaSubir = null; // Limpiar la imagen local
        _fotoUrl = urlImagenFinalParaGuardar; // Actualizar la URL de la foto mostrada
      });

      if (mounted) context.go('/home/perfil'); // O la ruta que corresponda

    } on FirebaseException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar: ${e.message ?? e.code}')),
      );
    } catch (e) { // Captura general para otros errores (ej. DateFormat)
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ocurrió un error inesperado: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => _subiendoAlGuardar = false);
    }
  }

  /* ───────────────────────────  UI ─────────────────────────── */

  @override
  Widget build(BuildContext context) {
    // Si _original es null, podrías mostrar un loader o un mensaje.
    // Por simplicidad, aquí se asume que _loadUser lo poblará o manejará el error.
    // if (_original == null && !_subiendoAlGuardar) { // Evitar rebuild innecesario si ya está cargando datos
    //   return Scaffold(body: Center(child: CircularProgressIndicator()));
    // }

    return Scaffold(
      backgroundColor: AppColors.neutral0,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, size: 24),
          onPressed: _subiendoAlGuardar
              ? null
              : () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home/perfil');
            }
          },

        ),
        elevation: 0,
        backgroundColor: AppColors.neutral0,
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
                  // enabled: !_subiendoAlGuardar,
                ),
                const SizedBox(height: 24),
                CardInput(
                  title: 'Información de perfil',
                  options: const ['Hombre', 'Mujer', 'No binario'],
                  selectedIndex: _sexoIndex,
                  onSelected: _subiendoAlGuardar ? null : (i) => setState(() => _sexoIndex = i),
                ),
                const SizedBox(height: 24),
                CardFotoPerfil(
                  // Pasar tanto la URL remota como el archivo local
                  imagenUrlRemota: _fotoUrl,
                  imagenLocal: _imagenLocalParaSubir,
                  isLoading: _subiendoAlGuardar, // Usar el estado de carga general
                  onChange: _showImageSourceSelector, // Se deshabilita internamente si isLoading es true
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
                  enabled: !_subiendoAlGuardar,
                ),
                const SizedBox(height: 24),
                AppTextField(
                  labelText: 'Mail',
                  hintText: 'Ej: mimail@mail.com',
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  enabled: !_subiendoAlGuardar,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Requerido';
                    // No validar si el email no cambió, solo si es diferente al original
                    if (_original != null && v.trim() == _original!.email) {
                      return null;
                    }
                    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    return regex.hasMatch(v.trim()) ? null : 'Email inválido';
                  },
                ),
                const SizedBox(height: 32),
                AppButton(
                  label: _subiendoAlGuardar ? 'Guardando...' : 'Guardar datos',
                  onPressed: _subiendoAlGuardar ? null : _save,
                  type: AppButtonType.filled,
                  // Opcional: si AppButton soporta un child para mostrar un loader
                  // child: _subiendoAlGuardar ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2) : null,
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