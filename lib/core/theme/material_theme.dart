import 'package:flutter/material.dart';

ThemeData darkMaterialTheme(ColorScheme? darkDynamic) {
  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: darkDynamic,
  );
}

ThemeData lightMaterialTheme(ColorScheme? lightDynamic) {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: lightDynamic,
  );
}

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      primary: Colors.black,
      primaryContainer: Colors.black,
      secondary: Colors.white,
      secondaryContainer: Colors.grey,
      surface: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    fontFamily: "shreyam",
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      primary: Colors.white,
      primaryContainer: Colors.white,
      secondary: Colors.white,
      secondaryContainer: Colors.grey,
      surface: Colors.black,
      error: Colors.red,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onError: Colors.black,
      brightness: Brightness.dark,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF191919),
    ),
    fontFamily: "shreyam",
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
    ),
  );
}
