import 'package:bloc/bloc.dart';
import 'package:deshi_ponno/core/theme/material_theme.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(AppTheme.lightTheme);

  void toggleTheme(bool isDarkMode) {
    emit(isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme);
  }
}
