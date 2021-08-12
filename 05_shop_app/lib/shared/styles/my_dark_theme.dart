import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'my_main_styles.dart';

ThemeData myDarkTheme(context) {
  return ThemeData(
    primarySwatch: MyMainColors.myBlue,
    scaffoldBackgroundColor: MyMainColors.myOuterSpace,
    fontFamily: 'jannah',
    focusColor: MyMainColors.myWhite,
    textTheme: MyTextTheme.textTheme(),
    appBarTheme: _appBarTheme(context),
    bottomNavigationBarTheme: _bottomNavigationBarThemeData(),
  );
}

AppBarTheme _appBarTheme(context) {
  return AppBarTheme(
    // backwardsCompatibility: false, to edit status bar
    backwardsCompatibility: false,
    systemOverlayStyle: statusbar(),
    titleSpacing: 20,
    backgroundColor: MyMainColors.myOuterSpace,
    elevation: 0,
    titleTextStyle: Theme.of(context).textTheme.headline6,
    iconTheme: IconThemeData(color: MyMainColors.myWhite),
  );
}

SystemUiOverlayStyle statusbar() {
  return SystemUiOverlayStyle(
    statusBarColor: MyMainColors.myOuterSpace,
    statusBarIconBrightness: Brightness.light,
  );
}

BottomNavigationBarThemeData _bottomNavigationBarThemeData() {
  return BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: MyMainColors.myBlue,
    unselectedItemColor: MyMainColors.myGrey,
    elevation: 20,
    backgroundColor: MyMainColors.myOuterSpace,
  );
}
