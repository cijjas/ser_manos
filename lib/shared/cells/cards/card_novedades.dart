import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/models/novedad.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../../../constants/app_routes.dart';
import '../../tokens/colors.dart';
import '../../tokens/shadow.dart';
import '../../tokens/typography.dart';
import '../../tokens/border_radius.dart';

class CardNovedades extends StatelessWidget {
  final Novedad novedad;

  const CardNovedades({super.key, required this.novedad});

  Future<void> _logViewNewsEvent() async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'view_news_detail',
      parameters: {
        'news_id': novedad.id,
        'news_title': novedad.titulo,
        'news_source': novedad.emisor,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _logViewNewsEvent();

        context.pushNamed(
          RouteNames.newsDetail,
          pathParameters: {'id': novedad.id},
        );
      },
      child: Container(
        height: 156,
        decoration: const BoxDecoration(
          color: AppColors.neutral0,
          borderRadius: AppBorderRadius.border2,
          boxShadow: AppShadows.shadow2,
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            SizedBox(
              width: 118,
              height: 156,
              child: _NovedadImage(url: novedad.imagenUrl),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      novedad.emisor.toUpperCase(),
                      style: AppTypography.overline.copyWith(
                        color: AppColors.neutral75,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      novedad.titulo,
                      style: AppTypography.subtitle01,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      novedad.resumen,
                      style: AppTypography.body02.copyWith(
                        color: AppColors.neutral75,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Leer Más',
                        style: AppTypography.button.copyWith(
                          color: AppColors.primary100,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NovedadImage extends StatelessWidget {
  final String url;

  const _NovedadImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: AppColors.neutral10),
        Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            FirebaseCrashlytics.instance.recordError(
              error,
              stackTrace,
              reason: 'Failed to load news card image',
              information: ['Image URL: $url'],
              fatal: false,
            );
            return Container(
              color: AppColors.neutral10,
              child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 300),
                child: child,
              );
            }
            return const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          },
        ),
      ],
    );
  }
}