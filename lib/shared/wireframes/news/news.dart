import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ser_manos/shared/cells/cards/news_card.dart';
import '../../../providers/news_provider.dart';
import '../../../utils/app_strings.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';
import '../../tokens/border_radius.dart';

class NewsPage extends ConsumerWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(newsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(context.strings.news, style: AppTypography.headline01),
          const SizedBox(height: 16),
          newsAsync.when(
            data: (news) => news.isNotEmpty
                ? Column(
                    children: news
                        .map((news) => Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: NewsCard(news: news),
                            ))
                        .toList(),
                  )
                : Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: AppColors.neutral0,
                      borderRadius: AppBorderRadius.border4,
                    ),
                    child: Center(
                      child: Text(
                        context.strings.noNewsYet,
                        style: AppTypography.subtitle01,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
        ],
      ),
    );
  }
}
