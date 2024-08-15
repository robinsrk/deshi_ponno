import 'package:flutter/material.dart';

ThemeData darkMaterialTheme(ColorScheme? darkDynamic) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: darkDynamic,
    brightness: Brightness.dark,
  );
}

ThemeData lightMaterialTheme(ColorScheme? lightDynamic) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: lightDynamic,
    brightness: Brightness.light,
  );
}
