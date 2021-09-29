import 'package:flutter/material.dart';

class MyMainColors {
  static const MaterialColor myBlue = Colors.blue;
  static const Color myGrey = Colors.grey;
  static const Color myWhite = Colors.white;
  static const Color myBlack = Colors.black;
  static const Color myRed = Colors.red;
  static const Color myOuterSpace = Color(0xff333739);
}

class MyTextTheme {
  static TextTheme textTheme() {
/* Dafult 2018
--- NAME         SIZE  WEIGHT  SPACING
--- headline1    96.0  light   -1.5
--- headline2    60.0  light   -0.5
--- headline3    48.0  regular  0.0
--- headline4    34.0  regular  0.25
--- headline5    24.0  regular  0.0
--- headline6    20.0  medium   0.15
--- subtitle1    16.0  regular  0.15
--- subtitle2    14.0  medium   0.1
--- body1        16.0  regular  0.5   (bodyText1)
--- body2        14.0  regular  0.25  (bodyText2)
--- button       14.0  medium   1.25
--- caption      12.0  regular  0.4
--- overline     10.0  regular  1.5
*/
    return TextTheme(
      bodyText1: TextStyle(fontSize: 18),
      subtitle1: TextStyle(height: 1.3, fontSize: 14.0),
    );
  }
}
