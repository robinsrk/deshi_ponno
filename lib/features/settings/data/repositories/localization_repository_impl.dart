import 'package:deshi_ponno/features/settings/domain/repositories/localization_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationRepositoryImpl implements LocalizationRepository {
  @override
  Future<Locale> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final localeString = prefs.getString("lang");

    if (localeString == null || localeString.isEmpty) {
      return const Locale('en'); // Default locale
    }

    final localeParts = localeString.split('_');
    final languageCode = localeParts[0];
    final countryCode = localeParts.length > 1 ? localeParts[1] : null;

    return Locale(languageCode, countryCode);
  }

  @override
  Future<void> updateLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("lang", locale.toString());
  }
}
