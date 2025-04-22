import 'package:flutter/material.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/molecules/buttons/floating_button.dart';
import 'package:ser_manos/shared/molecules/buttons/short_button.dart';
import 'package:ser_manos/shared/molecules/status_bar/status_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ButtonDemoPage(),
    );
  }
}

class ButtonDemoPage extends StatelessWidget {
  const ButtonDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StatusBar(style: StatusBarStyle.blue, timeText: '', showPlaceHolders: false,),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("CTA Buttons", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            AppButton(
              label: 'Registrarse',
              onPressed: () => debugPrint('Filled CTA pressed'),
              type: AppButtonType.filled,
            ),
            const SizedBox(height: 8),
            AppButton(
              label: 'Registrarse',
              onPressed: () => debugPrint('Tonal CTA pressed'),
              type: AppButtonType.tonal,
            ),
            const SizedBox(height: 8),
            AppButton(
              label: 'Registrarse',
              onPressed: null, // Disabled
              type: AppButtonType.filled,
            ),
            const SizedBox(height: 24),

            const Text("Short Buttons", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShortButton(
                  label: 'Completar',
                  icon: Icons.add,
                  onPressed: () => debugPrint('Short pressed'),
                  variant: ShortButtonVariant.regular,
                ),
                const ShortButton(
                  label: 'Completar',
                  icon: Icons.add,
                  onPressed: null,
                  variant: ShortButtonVariant.regular,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShortButton(
                  label: 'Completar',
                  icon: Icons.add,
                  onPressed: () => debugPrint('Short pressed'),
                  variant: ShortButtonVariant.compact,
                ),
                const ShortButton(
                  label: 'Completar',
                  icon: Icons.add,
                  onPressed: null,
                  variant: ShortButtonVariant.compact,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: AppFloatingButton(
        icon: Icons.navigation,
        onPressed: () => debugPrint('FAB pressed'),
      ),
    );
  }
}