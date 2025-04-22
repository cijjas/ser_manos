import 'package:flutter/cupertino.dart';

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
      'assets/icons/symbol_text.png',
      width: width,
      height: height,
    );
  }
}