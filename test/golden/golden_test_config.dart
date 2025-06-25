import 'dart:async';

import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadAppFonts();
  return GoldenToolkit.runWithConfiguration(
        () async => await testMain(),
    config: GoldenToolkitConfiguration(
      // skipGoldenAssertion se omite: usa el default (none)
      fileNameFactory: (name) => 'goldens/$name.png',
    ),
  );
}
