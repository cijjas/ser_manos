import 'package:flutter/material.dart';

class AppTypography {
  static const _fontFamily = 'Roboto';

  static const headline01 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
    height: 32 / 24,
  );

  static const headline02 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
    height: 24 / 20,
  );

  static const subtitle01 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
    height: 24 / 16,
  );

  static const body01 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
    height: 20 / 14,
  );

  static const body02 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
    height: 16 / 12,
  );

  static const button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
    height: 20 / 14,
  );

  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
    height: 16 / 12,
  );

  static const overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
    letterSpacing: 1.5,
    textBaseline: TextBaseline.alphabetic,
    height: 16 / 10,
  );
}