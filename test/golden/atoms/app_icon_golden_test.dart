import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:ser_manos/shared/atoms/icons/app_icons.dart';
import 'package:ser_manos/shared/tokens/colors.dart';

void main() {
  Widget _buildIcon(AppIcons icon, AppIconsColor color) {
    return Center(
      child: AppIcon(
        icon: icon,
        color: color,
        size: 48,
      ),
    );
  }

  testGoldens('AppIcon colour variants', (tester) async {
    // Make sure custom fonts render exactly like in the app
    await loadAppFonts();

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [Device.phone])
      ..addScenario(
        name: 'default-neutral',
        widget: _buildIcon(AppIcons.FAVORITO_OUTLINE, AppIconsColor.DEFAULT),
      )
      ..addScenario(
        name: 'primary',
        widget: _buildIcon(AppIcons.FAVORITO, AppIconsColor.PRIMARY),
      )
      ..addScenario(
        name: 'disabled',
        widget: _buildIcon(AppIcons.FAVORITO_OUTLINE, AppIconsColor.DISABLED),
      );

    await tester.pumpDeviceBuilder(builder);
    await tester.pump(const Duration(milliseconds: 300));

    await screenMatchesGolden(tester, 'app_icon_variants');
  });
}
