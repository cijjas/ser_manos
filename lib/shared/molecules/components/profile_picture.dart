import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../utils/app_strings.dart';
import '../../tokens/colors.dart';
import '../../tokens/shadow.dart';

class ProfilePicture extends StatelessWidget {
  final String? imageUrl;
  final File? localImageFile;
  final double diameter;
  final VoidCallback? onTap;

  const ProfilePicture({
    super.key,
    this.imageUrl,
    this.localImageFile,
    required this.diameter,
    this.onTap,
  });

  factory ProfilePicture.sm({
    Key? key,
    String? imageUrl,
    File? localImageFile,
    VoidCallback? onTap,
  }) {
    return ProfilePicture(
      key: key,
      imageUrl: imageUrl,
      localImageFile: localImageFile,
      diameter: 84,
      onTap: onTap,
    );
  }

  factory ProfilePicture.lg({
    Key? key,
    String? imageUrl,
    File? localImageFile,
    VoidCallback? onTap,
  }) {
    return ProfilePicture(
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
          color: AppColors.neutral100.withValues(alpha: 0.3),
          child: const CircularProgressIndicator(),
        ),
        errorWidget: (_, __, ___) => Container(
          width: diameter,
          height: diameter,
          alignment: Alignment.center,
          color: AppColors.neutral100.withValues(alpha: 0.3),
          child: Icon(Icons.person, size: diameter * 0.5, color: Colors.grey),
        ),
      );
    } else {
      imageContent = Container(
        width: diameter,
        height: diameter,
        alignment: Alignment.center,
        color: AppColors.neutral100.withValues(alpha: 0.3),
        child: Icon(Icons.person, size: diameter * 0.5, color: Colors.grey),
      );
    }

    final avatar = ClipOval(child: imageContent);

    return Semantics(
      label: context.strings.profilePhoto,
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
