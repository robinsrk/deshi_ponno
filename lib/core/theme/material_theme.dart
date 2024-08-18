import 'package:flutter/material.dart';

ThemeData darkMaterialTheme(ColorScheme? darkDynamic) {
  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      primary: Colors.white,
      primaryContainer: Colors.white,
      secondary: Colors.black,
      secondaryContainer: Colors.black,
      surface: Colors.black,
      error: Colors.red,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onError: Colors.black,
      brightness: Brightness.dark,
    ),
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

ThemeData lightMaterialTheme(ColorScheme? lightDynamic) {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      primary: Colors.black,
      primaryContainer: Colors.black,
      secondary: Colors.white,
      secondaryContainer: Colors.white,
      surface: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
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
}
