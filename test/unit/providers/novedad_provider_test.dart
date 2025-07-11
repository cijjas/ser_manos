import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ser_manos/providers/news_provider.dart';
import 'package:ser_manos/models/news.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/mocks.mocks.dart';

void main() {
  group('Novedad providers', () {
    late MockNewsService mockService;
    late News nov1;

    setUp(() {
      mockService = MockNewsService();
      nov1 = News(
        id: 'n1',
        title: 'Título',
        summary: 'Resumen',
        sender: 'ONG',
        imageUrl: 'img',
        description: 'Desc',
        createdAt: DateTime(2025),
      );
    });

    ProviderContainer makeContainer() {
      return ProviderContainer(overrides: [
        newsServiceProvider.overrideWithValue(mockService),
      ]);
    }

    test('newsProvider emite lista', () async {
      when(mockService.watchAll()).thenAnswer((_) => Stream.value([nov1]));

      final container = makeContainer();
      addTearDown(container.dispose);

      final list = await container.read(newsProvider.future);
      expect(list, [nov1]);
    });

    test('newsByIdProvider emite una news', () async {
      when(mockService.watchOne('n1')).thenAnswer((_) => Stream.value(nov1));

      final container = makeContainer();
      addTearDown(container.dispose);

      final n = await container.read(newsByIdProvider('n1').future);
      expect(n, nov1);
    });
  });
}
