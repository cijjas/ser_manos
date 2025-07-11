import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:ser_manos/models/news.dart';
import 'package:ser_manos/providers/news_provider.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/tokens/colors.dart';
import 'package:ser_manos/shared/tokens/typography.dart';
import '../../../utils/app_strings.dart';
import '../../cells/header/header_seccion.dart';

class NewsDetail extends ConsumerStatefulWidget {
  final String id;
  const NewsDetail({super.key, required this.id});

  @override
  ConsumerState<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends ConsumerState<NewsDetail> {
  bool isSharing = false;

  Future<void> _handleShare(News news) async {
    if (isSharing || !mounted) return;

    setState(() => isSharing = true);

    await FirebaseAnalytics.instance.logEvent(
      name: 'share_news',
      parameters: {
        'news_id': news.id,
        'news_title': news.title,
      },
    );

    final url = 'http://sermanos.app/news/${news.id}';
    final discoverMoreText =
        mounted ? context.strings.discoverMore : 'Descubre más aquí:';
    final text = '${news.summary}\n\n$discoverMoreText\n$url';

    try {
      final response = await http.get(Uri.parse(news.imageUrl));
      if (response.statusCode != 200) {
        throw Exception('No se pudo descargar la imagen.');
      }

      final dir = await getTemporaryDirectory();
      final fileName =
          'shared_news_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = '${dir.path}/$fileName';
      final file = File(path);
      await file.writeAsBytes(response.bodyBytes);

      await Share.shareXFiles([XFile(path)], text: text);
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Failed to download news image for sharing',
        information: [
          'News ID: ${news.id}',
          'Image URL: ${news.imageUrl}'
        ],
        fatal: false,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.strings.shareErrorMessage)),
        );
      }
    } finally {
      if (mounted) setState(() => isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final newsAsync = ref.watch(newsByIdProvider(widget.id));

    return Scaffold(
      backgroundColor: AppColors.neutral0,
      body: newsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, stack) {
          FirebaseCrashlytics.instance.recordError(e, stack);
          return Center(child: Text(context.strings.loadNewsError));
        },
        data: (news) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeaderSection(title: 'Novedades'), // TODO i18n
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(news.sender.toUpperCase(),
                        style: AppTypography.overline),
                    const SizedBox(height: 4),
                    Text(news.title, style: AppTypography.headline02),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        news.imageUrl,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 160,
                            color: AppColors.neutral10,
                            child: const Center(
                                child: CircularProgressIndicator()),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          FirebaseCrashlytics.instance.recordError(
                            error,
                            stackTrace,
                            reason: 'Failed to load news image for display',
                            information: [
                              'News ID: ${news.id}',
                              'Image URL: ${news.imageUrl}'
                            ],
                            fatal: false,
                          );
                          return Container(
                            width: double.infinity,
                            height: 160,
                            color: AppColors.neutral10,
                            child: const Center(
                              child: Icon(Icons.broken_image,
                                  size: 64, color: AppColors.neutral50),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      news.summary,
                      style: AppTypography.subtitle01.copyWith(
                        color: AppColors.secondary200,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(news.description, style: AppTypography.body01),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Column(
                    children: [
                      Text(context.strings.shareThisNote,
                          style: AppTypography.headline02),
                      const SizedBox(height: 12),
                      AppButton(
                        label: context.strings.share,
                        onPressed:
                            isSharing ? null : () => _handleShare(news),
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
