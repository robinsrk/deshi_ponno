// import 'package:bloc/bloc.dart';
// import 'package:deshi_ponno/core/theme/material_theme.dart';
// import 'package:flutter/material.dart';
//
// class ThemeCubit extends Cubit<ThemeData> {
//   ThemeCubit() : super(AppTheme.lightTheme);
//
//   void toggleTheme(bool isDarkMode) {
//     emit(isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme);
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:deshi_ponno/core/theme/material_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeData> {
  static const _themeKey = 'themeKey';

  ThemeCubit() : super(AppTheme.lightTheme) {
    _loadTheme();
  }

  Future<void> toggleTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDarkMode);
    emit(isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_themeKey) ?? false;
    emit(isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme);
  }
}
