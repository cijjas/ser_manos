import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:ser_manos/providers/home_providers.dart';

void main() {
  test('isMapViewProvider toggle', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // valor por defecto
    expect(container.read(isMapViewProvider), isFalse);

    // cambiamos a true
    container.read(isMapViewProvider.notifier).state = true;
    expect(container.read(isMapViewProvider), isTrue);
  });
}
