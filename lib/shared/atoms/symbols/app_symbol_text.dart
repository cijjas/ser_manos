import 'package:flutter/cupertino.dart';

import '../../../constants/app_assets.dart';

class AppSymbolText extends StatelessWidget {
  final double width;
  final double height;

  const AppSymbolText({
    super.key,
    this.width = 150,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.symbolText,
      width: width,
      height: height,
    );
  }
}