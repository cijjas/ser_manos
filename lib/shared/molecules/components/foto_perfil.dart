import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../tokens/colors.dart';
import '../../tokens/shadow.dart';

class FotoPerfil extends StatelessWidget {
  const FotoPerfil._({
    super.key,
    required this.imageUrl,
    required this.diameter,
    this.onTap,
  });

  // ────── constructores de conveniencia ──────
  const factory FotoPerfil.sm({
    Key? key,
    required String imageUrl,
    VoidCallback? onTap,
  }) = FotoPerfil._sm;

  const factory FotoPerfil.lg({
    Key? key,
    required String imageUrl,
    VoidCallback? onTap,
  }) = FotoPerfil._lg;

  // implementaciones privadas para mantener const-ness
  const FotoPerfil._sm({
    Key? key,
    required String imageUrl,
    VoidCallback? onTap,
  }) : this._(
    key: key,
    imageUrl: imageUrl,
    diameter: 84,
    onTap: onTap,
  );

  const FotoPerfil._lg({
    Key? key,
    required String imageUrl,
    VoidCallback? onTap,
  }) : this._(
    key: key,
    imageUrl: imageUrl,
    diameter: 110,
    onTap: onTap,
  );

  final String imageUrl;
  final double diameter;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final avatar = ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: diameter,
        height: diameter,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(
          width: diameter,
          height: diameter,
          color: AppColors.neutral100,
        ),
        errorWidget: (_, __, ___) => Container(
          width: diameter,
          height: diameter,
          color: AppColors.neutral100,
          alignment: Alignment.center,
          child: const Icon(Icons.person, size: 32, color: Colors.grey),
        ),
      ),
    );

    return Semantics(
      label: 'Foto de perfil',
      button: onTap != null,
      child: Material(
        shape: const CircleBorder(),
        elevation: 2,
        shadowColor: AppShadows.shadow1.first.color,
        clipBehavior: Clip.antiAlias,
        child: onTap != null ? InkWell(onTap: onTap, child: avatar) : avatar,
      ),
    );
  }
}
