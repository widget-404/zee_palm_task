import 'package:flutter/material.dart';

class AppSizes {
  late  Size _screenSize;

  late  bool isPhone;
  late  double width;
  late  double height;

  late  double topPadding;

  //For dynamic Sizing
  late double widthRatio;
  late  double heightRatio;
  late  double fontRatio;

  //Dynamic Font Sizes
  late  double extraSmallFontSize;
  late double smallFontSize;
  late double mediumFontSize;
  late double regularFontSize;
  late  double largeFontSize;
  late  double extraLargeFontSize;
  late  double jumboFontSize;


  void initializeSize(context) {
    _screenSize = MediaQuery.of(context).size;
    topPadding = MediaQuery.of(context).padding.top;
    width = _screenSize.shortestSide;
    height = _screenSize.longestSide;
    isPhone = _screenSize.shortestSide < 600;
    fontRatio =
    (isPhone && _screenSize.width <= 360) ? _screenSize.width / 360 : 1.0;
    widthRatio = isPhone ? _screenSize.width / 360 : _screenSize.width / 900;
    heightRatio =
    isPhone ? _screenSize.height / 720 : _screenSize.height / 1200;
    extraSmallFontSize = 11.0 * fontRatio;
    smallFontSize = 12.0 * fontRatio;
    regularFontSize = 14.0 * fontRatio;
    mediumFontSize = 16.0 * fontRatio;
    largeFontSize = 18.0 * fontRatio;
    extraLargeFontSize = 24.0 * fontRatio;
    jumboFontSize = 32.0 * fontRatio;

  }

  void refreshSize(context) {
    _screenSize = MediaQuery.of(context).size;
    width = _screenSize.width;
    height = _screenSize.height;
  }
}
