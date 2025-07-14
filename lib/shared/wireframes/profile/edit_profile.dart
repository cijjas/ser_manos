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
import '../../cells/cards/profile_picture_card.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';
import '../../molecules/buttons/app_button.dart';
import '../../molecules/input/form_builder_app_text_field.dart';
import '../../molecules/input/form_builder_date_field.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _picker = ImagePicker();

  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();

  String? _fotoUrl;
  File? _localImageToUpload;
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

  List<String> get _genderOptions => [
        context.strings.genderMale,
        context.strings.genderFemale,
        context.strings.genderNonBinary,
      ];

  int? _getGenderIndex(String? storedGender) {
    if (storedGender == null) return null;

    switch (storedGender.toLowerCase()) {
      case 'hombre':
      case 'male':
        return 0;
      case 'mujer':
      case 'female':
        return 1;
      case 'no binario':
      case 'non-binary':
        return 2;
      default:
        return null;
    }
  }

  String? _getStoredGender(int? index) {
    if (index == null) return null;

    switch (index) {
      case 0:
        return 'Hombre';
      case 1:
        return 'Mujer';
      case 2:
        return 'No binario';
      default:
        return null;
    }
  }

  bool _hasChanges() {
    if (_originalUser == null) return true;
    final values = _formKey.currentState?.value ?? {};
    if ((values['email'] as String?)?.trim() != _originalUser!.email.trim()) {
      return true;
    }
    if ((values['telefono'] as String?)?.trim() !=
        _originalUser!.phoneNumber?.trim()) {
      return true;
    }
    if (values['fechaNacimiento'] != _originalUser!.birthDate) {
      return true;
    }
    final generoIndex = values['genero'] as int?;
    final currentGenero = _getStoredGender(generoIndex);
    if (currentGenero != _originalUser!.gender) return true;
    if (_localImageToUpload != null) return true;
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
        _fotoUrl = user.imageUrl;
      });

      final initialGenderIndex = _getGenderIndex(user.gender);

      _formKey.currentState?.patchValue({
        'email': user.email,
        'telefono': user.phoneNumber,
        'fechaNacimiento': user.birthDate,
        'genero': initialGenderIndex,
        'imagenValida': user.imageUrl != null,
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
              title: Text(context.strings.takePhoto),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(context.strings.chooseFromGallery),
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
        SnackBar(content: Text(context.strings.imageNotOnDisk)),
      );
      return;
    }

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(picked.path);
    final savedImage = await tmpFile.copy('${appDir.path}/$fileName');

    setState(() {
      _localImageToUpload = savedImage;
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
      if (_localImageToUpload != null) {
        final storageRef = FirebaseStorage.instance.ref().child(
            'profile_images/${fbUser.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg');
        final metadata = SettableMetadata(contentType: 'image/jpeg');
        final bytes = await _localImageToUpload!.readAsBytes();
        await storageRef.putData(bytes, metadata);
        urlImagenFinalParaGuardar = await storageRef.getDownloadURL();
      }

      final genderIndex = values['genero'] as int?;
      final updated = _originalUser!.copyWith(
        email: (values['email'] as String).trim(),
        phoneNumber: (values['telefono'] as String).trim(),
        birthDate: values['fechaNacimiento'] as DateTime,
        gender: _getStoredGender(genderIndex),
        imageUrl: urlImagenFinalParaGuardar,
      );

      await ref.read(updateUserProvider(updated).future);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.strings.dataSavedSuccessfully)),
      );

      setState(() {
        _localImageToUpload = null;
        _fotoUrl = urlImagenFinalParaGuardar;
      });

      if (context.canPop()) {
        context.pop(true);
      } else {
        context.go(AppRoutes.homeProfile);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.strings.saveErrorMessage)));
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
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 64,
                  padding: const EdgeInsets.fromLTRB(0, 20, 16, 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                        icon: const Icon(Icons.close, size: 24),
                        onPressed: _isSaving
                            ? null
                            : () => context.canPop()
                                ? context.pop()
                                : context.go(AppRoutes.homeProfile),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                        Text(
                          context.strings.profileDataTitle,
                          style: AppTypography.headline01.copyWith(
                            color: AppColors.neutral100,
                          ),
                        ),
                        const SizedBox(height: 24),
                        FormBuilderDateField(
                            name: 'fechaNacimiento',
                            label: context.strings.birthDateLabel,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            validator: (v) => AppValidators.required(v, context,
                                label: context.strings.birthDateValidationLabel)),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 152,
                          child: FormBuilderField<int?>(
                            name: 'genero',
                            validator: (value) =>
                                value == null ? context.strings.selectGenderError : null,
                            builder: (field) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CardInput(
                                    title: context.strings.profileInformation,
                                    options: _genderOptions,
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
                        ),
                        const SizedBox(height: 24),
                        FormBuilderField<bool>(
                          name: 'imagenValida',
                          initialValue:
                              _fotoUrl != null || _localImageToUpload != null,
                          validator: FormBuilderValidators.equal(true,
                              errorText: context.strings.selectProfilePhoto),
                          builder: (field) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfilePictureCard(
                                  remoteImageUrl: _fotoUrl,
                                  localImage: _localImageToUpload,
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
                      ],
                    ),
                  const SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                        Text(
                          context.strings.contactData,
                          style: AppTypography.headline01.copyWith(
                            color: AppColors.neutral100,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          context.strings.contactDataDescription,
                          style: AppTypography.body01.copyWith(
                            color: AppColors.neutral75,
                          ),
                        ),
                        const SizedBox(height: 24),
                        FormBuilderAppTextField(
                          focusNode: _phoneFocus,
                          name: 'telefono',
                          labelText: context.strings.phone,
                          hintText: context.strings.phoneHint,
                          keyboardType: TextInputType.phone,
                          validator: (v) => AppValidators.phone(v, context),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                          ],
                          onFieldSubmitted: (_) => _emailFocus.requestFocus(),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 24),
                        FormBuilderAppTextField(
                          focusNode: _emailFocus,
                          name: 'email',
                          labelText: context.strings.email,
                          hintText: context.strings.emailEditHint,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) => AppValidators.email(v, context),
                          onFieldSubmitted: (_) =>
                              _formKey.currentState?.fields['email']?.validate(),
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: AppButton(
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
