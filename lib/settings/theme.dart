import 'package:flutter/material.dart';

enum AppTheme { light, dark }

final appThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
    // primarySwatch: const MaterialColor(
    //   0xFF1751AF,
    //   <int, Color>{
    //     50: Color(0x1a15499e), // 10%
    //     100: Color(0xa112418c), // 20%
    //     200: Color(0xaa10397a), // 30%
    //     300: Color(0xaf0e3169), // 40%
    //     400: Color(0x1a0c2958), // 50%
    //     500: Color(0xa1092046), // 60%
    //     600: Color(0xaa071834), // 70%
    //     700: Color(0xff051023), // 80%
    //     800: Color(0xaf020811), // 90%
    //     900: Color(0xff000000) // 100%
    //   },
    // ),
    primaryColor: const Color(0xff1751af),
    primaryColorLight: const Color(0xff5b7de2),
    primaryColorDark: const Color(0xff002a7f),
    scaffoldBackgroundColor: const Color(0xffffffff),
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: Color(0xFF1751AF),
      // primaryVariant: Color(0xFF12418c),
      secondary: Color(0xFF0c2958),
      // secondaryVariant: Color(0xFF051023),
    ),
    // primaryIconTheme: const IconThemeData(color: Color(0xff1751AF)),
    textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.white, fontSize: 25),
      headline2: TextStyle(color: Colors.white, fontSize: 18),
      headline3: TextStyle(color: Colors.white, fontSize: 14),
      bodyText1: TextStyle(color: Colors.black),
    ),
  ),
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
    // primarySwatch: const MaterialColor(
    //   0xFF1751AF,
    //   <int, Color>{
    //     50: Color(0x1a1a1a1a), // 10%
    //     100: Color(0xa1333333), // 20%
    //     200: Color(0xaa4d4d4d), // 30%
    //     300: Color(0xaf666666), // 40%
    //     400: Color(0x1a808080), // 50%
    //     500: Color(0xa1999999), // 60%
    //     600: Color(0xaab3b3b3), // 70%
    //     700: Color(0xffcccccc), // 80%
    //     800: Color(0xafe6e6e6), // 90%
    //     900: Color(0xffffffff) // 100%
    //   },
    // ),
    primaryColor: const Color(0xff000000),
    primaryColorLight: const Color(0xff2c2c2c),
    primaryColorDark: const Color(0xff000000),
    scaffoldBackgroundColor: const Color(0xff2c2c2c),
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Color(0xff000000),
      // primaryVariant: Color(0xa1333333),
      secondary: Color(0x1a808080),
      // secondaryVariant: Color(0xffcccccc),
    ),
    // primaryIconTheme: const IconThemeData(color: Color(0xffffffff)),
    textTheme: const TextTheme(
      headline1: TextStyle(color: Colors.white, fontSize: 25),
      headline2: TextStyle(color: Colors.white, fontSize: 18),
      headline3: TextStyle(color: Colors.white, fontSize: 14),
      bodyText1: TextStyle(color: Colors.white),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: Colors.white),
      selectedLabelStyle: TextStyle(color: Colors.red),
    )
  ),
};
