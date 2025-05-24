import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/tokens/typography.dart';

import '../../../providers/user_provider.dart';
import '../../atoms/symbols/app_symbol_text.dart';
import '../../molecules/status_bar/status_bar.dart';
import '../../tokens/colors.dart';

class WelcomePage extends ConsumerStatefulWidget {

  const WelcomePage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _WelcomePageState();
  }
}

class _WelcomePageState extends ConsumerState<WelcomePage> {

  Future<void> onBeginPress(BuildContext context) async {
    //await ref.read(markOnboardingCompleteProvider);

    context.go('/home/postularse');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.neutral0,
      appBar: const StatusBar(style: StatusBarStyle.light, timeText: '', showPlaceHolders: false),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 92),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppSymbolText(),
                  SizedBox(height: 30),
                  Text("¡Bienvenido!",
                    style: AppTypography.headline01,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 48),
                  Text("Nunca subestimes tu habilidad para mejorar la vida de alguien.",
                    style: AppTypography.subtitle01,
                    textAlign: TextAlign.center,
                  )
                ],
              )
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  AppButton(
                    label: "Comenzar",
                    onPressed: () => onBeginPress(context),
                    type: AppButtonType.filled,
                  ),
                ],
              )
            )
          ],
        )
      )
    );
  }


}