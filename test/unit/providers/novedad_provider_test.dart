import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ser_manos/providers/novedad_provider.dart';
import 'package:ser_manos/models/novedad.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/mocks.mocks.dart';

void main() {
  group('Novedad providers', () {
    late MockNovedadService mockService;
    late Novedad nov1;

    setUp(() {
      mockService = MockNovedadService();
      nov1 = Novedad(
        id: 'n1',
        titulo: 'Título',
        resumen: 'Resumen',
        emisor: 'ONG',
        imagenUrl: 'img',
        descripcion: 'Desc',
        createdAt: DateTime(2025),
      );
    });

    ProviderContainer makeContainer() {
      return ProviderContainer(overrides: [
        novedadServiceProvider.overrideWithValue(mockService),
      ]);
    }

    test('novedadesProvider emite lista', () async {
      when(mockService.watchAll()).thenAnswer((_) => Stream.value([nov1]));

      final container = makeContainer();
      addTearDown(container.dispose);

      final list = await container.read(novedadesProvider.future);
      expect(list, [nov1]);
    });

    test('novedadByIdProvider emite una novedad', () async {
      when(mockService.watchOne('n1')).thenAnswer((_) => Stream.value(nov1));

      final container = makeContainer();
      addTearDown(container.dispose);

      final n = await container.read(novedadByIdProvider('n1').future);
      expect(n, nov1);
    });
  });
}
