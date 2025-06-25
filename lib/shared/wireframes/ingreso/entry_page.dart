
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/constants/app_routes.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/tokens/typography.dart';

import '../../atoms/symbols/app_symbol_text.dart';
import '../../molecules/status_bar/status_bar.dart';
import '../../tokens/colors.dart';

class EntryPage extends StatelessWidget {

  const EntryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.neutral0,
        appBar: const StatusBar(style: StatusBarStyle.light),
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
                  AppButton(label: "Iniciar Sesión", onPressed: ()=> context.go(AppRoutes.login), type: AppButtonType.filled),
                  AppButton(label: "Resgistrarse", onPressed: ()=> context.go(AppRoutes.register), type: AppButtonType.tonal),
                ],
              )
            )
          ],
        )
      )
    );
  }
}