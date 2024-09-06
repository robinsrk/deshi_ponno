import 'package:deshi_ponno/core/theme/material_theme.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeData> {
  static const _darkKey = 'darkKey';
  static const String _materialKey = "materialKey";

  ThemeCubit() : super(AppTheme.lightTheme) {
    _loadTheme();
  }

  // Future<void> toggleTheme(bool isDarkMode, bool isMaterialTheme) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool(_darkKey, isDarkMode);
  //   await prefs.setBool(_materialKey, isMaterialTheme);
  //   emit(isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme);
  // }
  //
  // Future<void> _loadTheme() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final isDarkMode = prefs.getBool(_darkKey) ?? false;
  //   final isMaterialTheme = prefs.getBool(_materialKey) ?? false;
  //   emit(isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme);
  // }
  Future<void> toggleTheme(bool isDarkMode, bool isMaterialTheme,
      {ColorScheme? lightDynamic, ColorScheme? darkDynamic}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkKey, isDarkMode);
    await prefs.setBool(_materialKey, isMaterialTheme);
    emit(_getTheme(isDarkMode, isMaterialTheme,
        lightDynamic: lightDynamic, darkDynamic: darkDynamic));
  }

  ThemeData _getTheme(bool isDarkMode, bool isMaterialTheme,
      {ColorScheme? lightDynamic, ColorScheme? darkDynamic}) {
    if (isMaterialTheme) {
      return isDarkMode
          ? AppTheme.darkMaterialTheme(darkDynamic)
          : AppTheme.lightMaterialTheme(lightDynamic);
    }
    return isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_darkKey) ?? false;
    final isMaterialTheme = prefs.getBool(_materialKey) ?? false;

    ColorScheme? lightDynamic;
    ColorScheme? darkDynamic;

    if (isMaterialTheme) {
      lightDynamic =
          await DynamicColorPlugin.getCorePalette().then((corePalette) {
        return corePalette?.toColorScheme();
      });
      darkDynamic =
          await DynamicColorPlugin.getCorePalette().then((corePalette) {
        return corePalette?.toColorScheme(brightness: Brightness.dark);
      });
    }

    emit(_getTheme(isDarkMode, isMaterialTheme,
        lightDynamic: lightDynamic, darkDynamic: darkDynamic));
  }
}
