import 'package:flutter/material.dart';

import '../export.dart';

class Styles {
  //Montserrat font styles
  final TextStyle headingExtraLarge = TextStyle(
    color: colors.primaryDark,
    fontWeight: FontWeight.w800,
    fontFamily: constant.fontManrope,
    fontSize: sizes.fontRatio * 28,
    letterSpacing: 1,
  );

  final TextStyle headingLarge = TextStyle(
    color: colors.primaryDark,
    fontWeight: FontWeight.w700,
    fontFamily: constant.fontManrope,
    fontSize: sizes.fontRatio * 24,
    letterSpacing: 1,
  );

  final TextStyle headingRegular = TextStyle(
    color: colors.primaryDark,
    fontWeight: FontWeight.w700,
    fontFamily: constant.fontManrope,
    fontSize: sizes.fontRatio * 18,
    letterSpacing: 1,
  );

  //Manrope font styles
  final TextStyle bodyLarge = TextStyle(
    color: colors.primaryDark,
    fontWeight: FontWeight.w500,
    fontFamily: constant.fontManrope,
    fontSize: sizes.fontRatio * 17,
    letterSpacing: 1,
  );

  final TextStyle bodyRegular = TextStyle(
    color: colors.primaryDark,
    fontWeight: FontWeight.w500,
    fontFamily: constant.fontManrope,
    fontSize: sizes.fontRatio * 16,
    letterSpacing: 1,
  );

  final TextStyle bodySmall = TextStyle(
    color: colors.primaryDark,
    fontWeight: FontWeight.w500,
    fontFamily: constant.fontManrope,
    fontSize: sizes.fontRatio * 14,
    letterSpacing: 1,
  );

  final TextStyle bodyExtraSmall = TextStyle(
    color: colors.primaryDark,
    fontWeight: FontWeight.w400,
    fontFamily: constant.fontManrope,
    fontSize: sizes.fontRatio * 12,
    letterSpacing: 1,
  );
}
