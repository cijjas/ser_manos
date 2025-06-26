// lib/shared/wireframes/perfil/editar_perfil.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ser_manos/constants/app_routes.dart';
import '../../../models/user.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/user_provider.dart';
import '../../cells/cards/card_input.dart';
import '../../cells/cards/card_foto.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';
import '../../molecules/buttons/app_button.dart';
import '../../molecules/input/form_builder_app_text_field.dart';
import '../../molecules/input/form_builder_date_field.dart';
import 'package:path/path.dart' as path;


class EditarPerfilPage extends ConsumerStatefulWidget {
  const EditarPerfilPage({super.key});

  @override
  ConsumerState<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends ConsumerState<EditarPerfilPage> {

  final _formKey = GlobalKey<FormBuilderState>();
  int? _sexoIndex;
  String? _fotoUrl;
  File? _imagenLocalParaSubir;
  bool _subiendoAlGuardar = false;
  User? _original;
  final _picker = ImagePicker();

  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  void dispose() {
    _phoneFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }



  Future<void> _loadUser() async {
    final fbUser = ref.read(authStateProvider).maybeWhen(
      data: (u) => u,
      orElse: () => null,
    );
    if (fbUser == null) return;

    try {
      final user = await ref.read(currentUserProvider.future);
      if (!mounted) return;

      setState(() {
        _original  = user;
        _sexoIndex = user.genero != null
            ? ['Hombre', 'Mujer', 'No binario'].indexOf(user.genero!)
            : null;
        _fotoUrl   = user.imagenUrl;
      });

      // ──> defer the patch until the current frame is finished
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _formKey.currentState?.patchValue({
          'email'          : user.email,
          'telefono'       : user.telefono,
          'fechaNacimiento': user.fechaNacimiento,
        });
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar datos del usuario: ${e.toString()}')),
        );
      }
    }
  }


  Future<void> _showImageSourceSelector() async {
    if (_subiendoAlGuardar) return;

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
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

    final picked = await _picker.pickImage(
      source: source,
      imageQuality: 75,
      maxWidth: 800,
    );

    if (picked == null) return;

    final tmpFile = File(picked.path);

    if (!tmpFile.existsSync()) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('La imagen no existe en disco.')),
        );
      }
      return;
    }

    // Copiar la imagen a un directorio seguro (Documents)
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(picked.path);
    final savedImage = await tmpFile.copy('${appDir.path}/$fileName');

    setState(() => _imagenLocalParaSubir = savedImage);

  }

  Future<void> _save() async {
    if (!_formKey.currentState!.saveAndValidate()) {
      return;
    }

    final values = _formKey.currentState!.value;
    final fbUser = ref.read(authStateProvider).maybeWhen(
      data: (u) => u,
      orElse: () => null,
    );

    if (fbUser == null || _original == null) {
      return;
    }

    setState(() => _subiendoAlGuardar = true);

    String? urlImagenFinalParaGuardar = _fotoUrl;


    try {
      if (_imagenLocalParaSubir != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images/${fbUser.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg');
        final metadata = SettableMetadata(contentType: 'image/jpeg');
        final bytes = await _imagenLocalParaSubir!.readAsBytes();
        final snapshot = await storageRef.putData(bytes, metadata);

        if (snapshot.state != TaskState.success) {
          throw FirebaseException(
            plugin: 'firebase_storage',
            message: 'Error al subir la imagen.',
          );
        }
        urlImagenFinalParaGuardar = await storageRef.getDownloadURL();
      }

      final updated = _original!.copyWith(
        email: values['email'].trim(),
        telefono: values['telefono'].trim(),
        fechaNacimiento: values['fechaNacimiento'],
        genero: (_sexoIndex != null)
            ? ['Hombre', 'Mujer', 'No binario'][_sexoIndex!]
            : null,
        imagenUrl: urlImagenFinalParaGuardar,
      );

      await ref.read(updateUserProvider(updated).future);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos guardados exitosamente')),
      );

      setState(() {
        _imagenLocalParaSubir = null;
        _fotoUrl = urlImagenFinalParaGuardar;
      });

      // --- CHANGE START ---
      // Instead of navigating with context.go, pop the page with a `true`
      // result to signal success to the previous screen.
      if (context.canPop()) {
        context.pop(true);
      } else {
        // Fallback for cases where the page can't be popped (e.g., deep link).
        context.go(AppRoutes.homeProfile);
      }

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _subiendoAlGuardar = false);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral0,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, size: 24),
          onPressed: _subiendoAlGuardar
              ? null
              : () => context.canPop()
              ? context.pop()
              : context.go(AppRoutes.homeProfile),
        ),
        elevation: 0,
        backgroundColor: AppColors.neutral0,
        foregroundColor: AppColors.neutral100,
      ),
      body: SafeArea(
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Datos de perfil',
                  style: AppTypography.headline01.copyWith(
                    color: AppColors.neutral100,
                  ),
                ),
                const SizedBox(height: 24),
                // ───────────────── Fecha de nacimiento ─────────────────
                FormBuilderDateField(
                  name: 'fechaNacimiento',
                  label: 'Fecha de nacimiento',
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  validator: FormBuilderValidators.required(),
                ),
                const SizedBox(height: 24),
                // ───────────────── Información de perfil (género) ─────────────────
                CardInput(
                  title: 'Información de perfil',
                  options: const ['Hombre', 'Mujer', 'No binario'],
                  selectedIndex: _sexoIndex,
                  onSelected: _subiendoAlGuardar
                      ? null
                      : (i) => setState(() => _sexoIndex = i),
                ),
                const SizedBox(height: 24),
                // ───────────────── Foto de perfil ─────────────────
                FormBuilderField<bool>(
                  name: 'imagenValida',
                  initialValue: _fotoUrl != null || _imagenLocalParaSubir != null,
                  validator: FormBuilderValidators.equal(true, errorText: 'Selecciona una foto de perfil'),
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardFotoPerfil(
                          imagenUrlRemota: _fotoUrl,
                          imagenLocal: _imagenLocalParaSubir,
                          isLoading: _subiendoAlGuardar,
                          onChange: () async {
                            await _showImageSourceSelector();
                            // After selecting imag notify FormBuilder
                            field.didChange(_fotoUrl != null || _imagenLocalParaSubir != null);
                          },
                        ),
                        if (field.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              field.errorText ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 32),
                Text(
                  'Datos de contacto',
                  style: AppTypography.headline01.copyWith(
                    color: AppColors.neutral100,
                  ),
                ),
                const SizedBox(height: 16),
                // ───────────────── Teléfono ─────────────────
                FormBuilderAppTextField(
                  focusNode: _phoneFocus,
                  name: 'telefono',
                  labelText: 'Teléfono',
                  hintText: 'Ej: +5491178445459',
                  keyboardType: TextInputType.phone,
                  validator: FormBuilderValidators.required(),
                  onFieldSubmitted: (_) => _emailFocus.requestFocus(),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 24),
                // ───────────────── Email ─────────────────
                FormBuilderAppTextField(
                  focusNode: _emailFocus,
                  name: 'email',
                  labelText: 'Mail',
                  hintText: 'Ej: mimail@mail.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 32),
                // ───────────────── Botón Guardar ─────────────────
                AppButton(
                  label: 'Guardar datos',
                  isLoading: _subiendoAlGuardar,
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