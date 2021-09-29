import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'my_main_styles.dart';

ThemeData myLightTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: MyMainColors.myBlue,
    scaffoldBackgroundColor: MyMainColors.myWhite,
    fontFamily: 'jannah',
    focusColor: MyMainColors.myBlack,
    textTheme: MyTextTheme.textTheme(),
    appBarTheme: _appBarTheme(context),
    bottomNavigationBarTheme: _bottomNavigationBarThemeData(),
  );
}

AppBarTheme _appBarTheme(context) {
  return AppBarTheme(
    systemOverlayStyle: statusbar(),
    titleSpacing: 20,
    backgroundColor: MyMainColors.myWhite,
    elevation: 0,
    titleTextStyle: Theme.of(context).textTheme.headline6!.copyWith(
          fontFamily: 'jannah',
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: MyMainColors.myBlack,
        ),
    iconTheme: IconThemeData(color: MyMainColors.myBlack),
  );
}

SystemUiOverlayStyle statusbar() {
  return SystemUiOverlayStyle(
    statusBarColor: MyMainColors.myWhite,
    statusBarIconBrightness: Brightness.dark,
  );
}

BottomNavigationBarThemeData _bottomNavigationBarThemeData() {
  return BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: MyMainColors.myBlue,
    unselectedItemColor: MyMainColors.myGrey,
    elevation: 20,
    backgroundColor: MyMainColors.myWhite,
  );
}
