// ================================================================
// lib/shared/molecules/components/foto_perfil.dart
// ================================================================

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../tokens/colors.dart';
import '../../tokens/shadow.dart';

class FotoPerfil extends StatelessWidget {
  final String? imageUrl;
  final File? localImageFile;
  final double diameter;
  final VoidCallback? onTap;

  const FotoPerfil({
    super.key,
    this.imageUrl,
    this.localImageFile,
    required this.diameter,
    this.onTap,
  });

  factory FotoPerfil.sm({
    Key? key,
    String? imageUrl,
    File? localImageFile,
    VoidCallback? onTap,
  }) {
    return FotoPerfil(
      key: key,
      imageUrl: imageUrl,
      localImageFile: localImageFile,
      diameter: 84,
      onTap: onTap,
    );
  }

  factory FotoPerfil.lg({
    Key? key,
    String? imageUrl,
    File? localImageFile,
    VoidCallback? onTap,
  }) {
    return FotoPerfil(
      key: key,
      imageUrl: imageUrl,
      localImageFile: localImageFile,
      diameter: 110,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget imageContent;

    // Priorizar imagen local sobre la remota
    if (localImageFile != null) {
      imageContent = Image.file(
        localImageFile!,
        width: diameter,
        height: diameter,
        fit: BoxFit.cover,
      );
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      imageContent = CachedNetworkImage(
        imageUrl: imageUrl!,
        width: diameter,
        height: diameter,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(
          width: diameter,
          height: diameter,
          color: AppColors.neutral100.withOpacity(0.3),
          child: const CircularProgressIndicator(),
        ),
        errorWidget: (_, __, ___) => Container(
          width: diameter,
          height: diameter,
          alignment: Alignment.center,
          color: AppColors.neutral100.withOpacity(0.3),
          child: Icon(Icons.person, size: diameter * 0.5, color: Colors.grey),
        ),
      );
    } else {
      // Placeholder cuando no hay imagen
      imageContent = Container(
        width: diameter,
        height: diameter,
        alignment: Alignment.center,
        color: AppColors.neutral100.withOpacity(0.3),
        child: Icon(Icons.person, size: diameter * 0.5, color: Colors.grey),
      );
    }

    final avatar = ClipOval(child: imageContent);

    return Semantics(
      label: 'Foto de perfil',
      button: onTap != null,
      child: Material(
        shape: const CircleBorder(),
        elevation: 2,
        shadowColor: AppShadows.shadow1.first.color,
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: avatar,
        ),
      ),
    );
  }
}