import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:ser_manos/models/novedad.dart';
import 'package:ser_manos/providers/novedad_provider.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/tokens/colors.dart';
import 'package:ser_manos/shared/tokens/typography.dart';
import '../../cells/header/header_seccion.dart';

class NovedadDetail extends ConsumerStatefulWidget {
  final String id;
  const NovedadDetail({super.key, required this.id});

  @override
  ConsumerState<NovedadDetail> createState() => _NovedadDetailState();
}

class _NovedadDetailState extends ConsumerState<NovedadDetail> {
  bool isSharing = false;

  Future<void> _handleShare(Novedad novedad) async {
    if (isSharing || !mounted) return;

    setState(() => isSharing = true);

    await FirebaseAnalytics.instance.logEvent(
      name: 'share_news',
      parameters: {
        'news_id': novedad.id,
        'news_title': novedad.titulo,
      },
    );

    final url = 'http://sermanos.app/novedad/${novedad.id}';
    final text = '${novedad.resumen}\n\nDescubre más aquí:\n$url';

    try {
      final response = await http.get(Uri.parse(novedad.imagenUrl));
      if (response.statusCode != 200) {
        throw Exception('No se pudo descargar la imagen.');
      }

      final dir = await getTemporaryDirectory();
      final fileName = 'shared_novedad_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = '${dir.path}/$fileName';
      final file = File(path);
      await file.writeAsBytes(response.bodyBytes);

      await Share.shareXFiles([XFile(path)], text: text);
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Failed to download news image for sharing',
        information: ['Novedad ID: ${novedad.id}', 'Image URL: ${novedad.imagenUrl}'],
        fatal: false,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ocurrió un error inesperado, intentalo en un rato.')),
        );
      }
    } finally {
      if (mounted) setState(() => isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final novedadAsync = ref.watch(novedadByIdProvider(widget.id));

    return Scaffold(
      backgroundColor: AppColors.neutral0,
      body: novedadAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, stack) {
          FirebaseCrashlytics.instance.recordError(e, stack);
          return const Center(child: Text('Ocurrió un error al cargar la novedad.'));
        },
        data: (novedad) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeaderSection(title: 'Novedades'),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(novedad.emisor.toUpperCase(), style: AppTypography.overline),
                    const SizedBox(height: 4),
                    Text(novedad.titulo, style: AppTypography.headline02),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        novedad.imagenUrl,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 160,
                            color: AppColors.neutral10,
                            child: const Center(child: CircularProgressIndicator()),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          FirebaseCrashlytics.instance.recordError(
                            error,
                            stackTrace,
                            reason: 'Failed to load news image for display',
                            information: ['Novedad ID: ${novedad.id}', 'Image URL: ${novedad.imagenUrl}'],
                            fatal: false,
                          );
                          return Container(
                            width: double.infinity,
                            height: 160,
                            color: AppColors.neutral10,
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 64, color: AppColors.neutral50),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      novedad.resumen,
                      style: AppTypography.subtitle01.copyWith(
                        color: AppColors.secondary200,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(novedad.descripcion, style: AppTypography.body01),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Column(
                    children: [
                      const Text('Comparte esta nota', style: AppTypography.headline02),
                      const SizedBox(height: 12),
                      AppButton(
                        label: 'Compartir',
                        onPressed: isSharing ? null : () => _handleShare(novedad),
                        type: AppButtonType.filled,
                        isLoading: isSharing,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}