

// I want to include a svg in a rectangle:

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

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
      'assets/icons/wordmark.png',
      width: width,
      height: height,
    );
  }
}