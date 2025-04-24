
import 'package:flutter/material.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/tokens/typography.dart';

import '../../atoms/symbols/app_symbol_text.dart';
import '../../molecules/status_bar/status_bar.dart';

class IngresoPage extends StatelessWidget {

  const IngresoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StatusBar(style: StatusBarStyle.blue, timeText: '', showPlaceHolders: false),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 32,
                children: [
                  AppSymbolText(),
                  Text("\"El esfuerzo desinteresado para llevar alegría a los demás será el comienzo de una vida más feliz para nosotros\"",
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
                  AppButton(label: "Iniciar Sesión", onPressed: ()=> debugPrint("Iniciar Sesión"), type: AppButtonType.filled, fillWidth: true),
                  AppButton(label: "Resgistrarse", onPressed: ()=> debugPrint("Registrarse"), type: AppButtonType.tonal, fillWidth: true),
                ],
              )
            )
          ],
        )
      )
    );
  }
}