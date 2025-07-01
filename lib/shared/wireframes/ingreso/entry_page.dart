import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/constants/app_routes.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/tokens/typography.dart';
import 'package:ser_manos/utils/app_strings.dart';

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
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 32,
                  children: [
                    const AppSymbolText(),
                    Text(
                      context.strings.entryPageQuote,
                      style: AppTypography.subtitle01,
                      textAlign: TextAlign.center,
                    )
                  ],
                )),
                SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        AppButton(
                            label: context.strings.loginPageTitle,
                            onPressed: () => context.go(AppRoutes.login),
                            type: AppButtonType.filled),
                        AppButton(
                            label: context.strings.registerPageTitle,
                            onPressed: () => context.go(AppRoutes.register),
                            type: AppButtonType.tonal),
                      ],
                    ))
              ],
            )));
  }
}
