import 'package:flutter/material.dart';

enum AppTheme { light, dark }

final appThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
    primaryColor: const Color(0xff1751af),
    primaryColorLight: const Color(0xff5b7de2),
    primaryColorDark: const Color(0xff002a7f),
    scaffoldBackgroundColor: const Color(0xffffffff),
    backgroundColor: const Color(0xfff5f5f5),
    primaryIconTheme: const IconThemeData(color: Color(0xff1751AF)),
    textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.white, fontSize: 25),
      headline2: TextStyle(color: Colors.white, fontSize: 18),
      headline3: TextStyle(color: Colors.white, fontSize: 14),
      bodyText1: TextStyle(color: Colors.black),
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Color(0xff000000), fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color(0xff002a7f),
      unselectedItemColor: Color(0xff616161),
    ),
  ),
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
    primaryColor: const Color(0xff000000),
    primaryColorLight: const Color(0xff121212),
    primaryColorDark: const Color(0xff000000),
    scaffoldBackgroundColor: const Color(0xff212121),
    backgroundColor: const Color(0xff424242),
    primaryIconTheme: const IconThemeData(color: Color(0xffffffff)),
    textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.white, fontSize: 25),
      headline2: TextStyle(color: Colors.white, fontSize: 18),
      headline3: TextStyle(color: Colors.white, fontSize: 14),
      bodyText1: TextStyle(color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Color(0xffffffff), fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color(0xffFAFAFA),
      unselectedItemColor: Color(0xff616161),
    ),
  ),
};
