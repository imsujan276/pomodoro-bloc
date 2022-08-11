import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static bool isLandscape = false;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    isLandscape = _mediaQueryData.orientation == Orientation.landscape;
  }
}

/// Get the proportionate height as per screen size
double height(double inputHeight) {
  // 812 is the layout height that designer use
  return (inputHeight / 812) * SizeConfig.screenHeight;
}

/// Get the proportionate width as per screen size
double width(double inputWidth) {
  // 375 is the layout width that designer use
  return (inputWidth / 375) * SizeConfig.screenWidth;
}

/// Get the proportionate radius as per screen height
double radius(double radius) {
  // 375 is the layout width that designer use
  return (radius / 812) * SizeConfig.screenHeight;
}
