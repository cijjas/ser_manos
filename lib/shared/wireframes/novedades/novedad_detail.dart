import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

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

  /// Comparte la imagen + subtítulo de la novedad
  Future<void> _handleShare(Novedad novedad) async {
    if (!mounted) return;

    setState(() => isSharing = true);

    final url = 'https://sermanos.app/novedad/${novedad.id}';
    final text = '${novedad.resumen}\n\n$url';

    try {
      // 1. Descargar la imagen
      final response = await http.get(Uri.parse(novedad.imagenUrl));
      if (response.statusCode != 200) {
        throw Exception('No se pudo descargar la imagen');
      }

      // 2. Guardarla en un directorio temporal
      final dir = await getTemporaryDirectory();
      final path = '${dir.path}/shared_novedad.jpg';
      final file = File(path);
      await file.writeAsBytes(response.bodyBytes);

      // 3. Compartir imagen + subtítulo (resumen)
      await Share.shareXFiles([XFile(file.path)], text: text);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al compartir la novedad: $e')),
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
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (novedad) => SingleChildScrollView(
          child: Column(
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
                    Center(
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
