import 'package:flutter/cupertino.dart';

import '../../../constants/app_assets.dart';

class AppWordmark extends StatelessWidget {
  final double width;
  final double height;

  const AppWordmark({
    super.key,
    this.width = 147,
    this.height = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.wordmark,
      width: width,
      height: height,
    );
  }
}
