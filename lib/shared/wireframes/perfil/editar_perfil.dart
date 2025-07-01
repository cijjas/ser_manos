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
import 'package:ser_manos/utils/app_strings.dart';
import '../../../models/user.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/validators/validators.dart';
import '../../cells/cards/card_input.dart';
import '../../cells/cards/card_foto.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';
import '../../molecules/buttons/app_button.dart';
import '../../molecules/input/form_builder_app_text_field.dart';
import '../../molecules/input/form_builder_date_field.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';

class EditarPerfilPage extends ConsumerStatefulWidget {
  const EditarPerfilPage({super.key});

  @override
  ConsumerState<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends ConsumerState<EditarPerfilPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _picker = ImagePicker();

  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();

  String? _fotoUrl;
  File? _imagenLocalParaSubir;
  bool _isSaving = false;
  User? _originalUser;
  bool _areAllFieldsFilled = false;

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

  bool _hasChanges() {
    if (_originalUser == null) return true;
    final values = _formKey.currentState?.value ?? {};
    if ((values['email'] as String?)?.trim() != _originalUser!.email.trim())
      return true;
    if ((values['telefono'] as String?)?.trim() !=
        _originalUser!.telefono?.trim()) return true;
    if (values['fechaNacimiento'] != _originalUser!.fechaNacimiento)
      return true;
    final generoIndex = values['genero'] as int?;
    final currentGenero = (generoIndex != null)
        ? ['Hombre', 'Mujer', 'No binario'][generoIndex]
        : null;
    if (currentGenero != _originalUser!.genero) return true;
    if (_imagenLocalParaSubir != null) return true;
    return false;
  }

  Future<void> _loadUser() async {
    final fbUser = ref.read(authStateProvider).value;
    if (fbUser == null) return;

    try {
      final user = await ref.read(currentUserProvider.future);
      if (!mounted) return;

      setState(() {
        _originalUser = user;
        _fotoUrl = user.imagenUrl;
      });

      final initialGenderIndex = user.genero != null
          ? ['Hombre', 'Mujer', 'No binario'].indexOf(user.genero!)
          : null;

      _formKey.currentState?.patchValue({
        'email': user.email,
        'telefono': user.telefono,
        'fechaNacimiento': user.fechaNacimiento,
        'genero': initialGenderIndex,
        'imagenValida': user.imagenUrl != null,
      });

      _updateButtonState();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.strings.loadDataErrorMessage)),
        );
      }
    }
  }

  void _updateButtonState() {
    final values = _formKey.currentState?.value ?? {};

    final allFilled = (values['fechaNacimiento'] != null) &&
        (values['genero'] != null) &&
        (values['imagenValida'] == true) &&
        (values['telefono'] as String?)?.isNotEmpty == true &&
        (values['email'] as String?)?.isNotEmpty == true;

    if (mounted && _areAllFieldsFilled != allFilled) {
      setState(() {
        _areAllFieldsFilled = allFilled;
      });
    }
  }

  Future<void> _showImageSourceSelector() async {
    if (_isSaving) return;

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

    if (source != null) await _seleccionarImagenLocal(source);
  }

  Future<void> _seleccionarImagenLocal(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      imageQuality: 75,
      maxWidth: 800,
    );

    if (picked == null) return;

    final tmpFile = File(picked.path);
    if (!mounted) return;

    if (!tmpFile.existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La imagen no existe en disco.')),
      );
      return;
    }

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(picked.path);
    final savedImage = await tmpFile.copy('${appDir.path}/$fileName');

    setState(() {
      _imagenLocalParaSubir = savedImage;
    });

    _formKey.currentState?.fields['imagenValida']?.didChange(true);
    _updateButtonState();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.saveAndValidate()) {
      return;
    }

    final values = _formKey.currentState!.value;
    final fbUser = ref.read(authStateProvider).value;

    if (fbUser == null || _originalUser == null) {
      return;
    }

    setState(() => _isSaving = true);

    String? urlImagenFinalParaGuardar = _fotoUrl;

    try {
      if (_imagenLocalParaSubir != null) {
        final storageRef = FirebaseStorage.instance.ref().child(
            'profile_images/${fbUser.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg');
        final metadata = SettableMetadata(contentType: 'image/jpeg');
        final bytes = await _imagenLocalParaSubir!.readAsBytes();
        await storageRef.putData(bytes, metadata);
        urlImagenFinalParaGuardar = await storageRef.getDownloadURL();
      }

      final genderIndex = values['genero'] as int?;
      final updated = _originalUser!.copyWith(
        email: (values['email'] as String).trim(),
        telefono: (values['telefono'] as String).trim(),
        fechaNacimiento: values['fechaNacimiento'] as DateTime,
        genero: (genderIndex != null)
            ? ['Hombre', 'Mujer', 'No binario'][genderIndex]
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

      if (context.canPop()) {
        context.pop(true);
      } else {
        context.go(AppRoutes.homeProfile);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Hubo un error al guardar. Intentalo en un rato.')));
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
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
          onPressed: _isSaving
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
          autovalidateMode: AutovalidateMode.onUnfocus,
          onChanged: () {
            _formKey.currentState?.save();
            setState(() {
              _updateButtonState();
            });
          },
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
                    validator: (v) => AppValidators.required(v,
                        label: 'fecha de nacimiento')),
                const SizedBox(height: 24),
                // ───────────────── Información de perfil (género) ─────────────────
                FormBuilderField<int?>(
                  name: 'genero',
                  validator: (value) =>
                      value == null ? 'Seleccioná tu género.' : null,
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardInput(
                          title: 'Información de perfil',
                          options: const ['Hombre', 'Mujer', 'No binario'],
                          selectedIndex: field.value,
                          onSelected:
                              _isSaving ? null : (i) => field.didChange(i),
                        ),
                        if (field.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 8),
                            child: Text(
                              field.errorText!,
                              style: AppTypography.caption
                                  .copyWith(color: AppColors.error100),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                // ───────────────── Foto de perfil ─────────────────
                FormBuilderField<bool>(
                  name: 'imagenValida',
                  initialValue:
                      _fotoUrl != null || _imagenLocalParaSubir != null,
                  validator: FormBuilderValidators.equal(true,
                      errorText: 'Selecciona una foto de perfil'),
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardFotoPerfil(
                          imagenUrlRemota: _fotoUrl,
                          imagenLocal: _imagenLocalParaSubir,
                          isLoading: _isSaving,
                          onChange: _showImageSourceSelector,
                        ),
                        if (field.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 12, top: 8),
                            child: Text(
                              field.errorText ?? '',
                              style: AppTypography.caption
                                  .copyWith(color: AppColors.error100),
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
                  labelText: context.strings.phone,
                  hintText: context.strings.phoneHint,
                  keyboardType: TextInputType.phone,
                  validator: (v) => AppValidators.phone(v),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                  ],
                  onFieldSubmitted: (_) => _emailFocus.requestFocus(),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 24),
                // ───────────────── Email ─────────────────
                FormBuilderAppTextField(
                  focusNode: _emailFocus,
                  name: 'email',
                  labelText: context.strings.email,
                  hintText: context.strings.emailEditHint,
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.email,
                  onFieldSubmitted: (_) =>
                      _formKey.currentState?.fields['email']?.validate(),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 32),
                // ───────────────── Botón Guardar ─────────────────
                AppButton(
                  label: context.strings.saveData,
                  isLoading: _isSaving,
                  onPressed: _areAllFieldsFilled &&
                          (_formKey.currentState?.isDirty ?? false) &&
                          !_isSaving &&
                          _hasChanges()
                      ? _save
                      : null,
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
