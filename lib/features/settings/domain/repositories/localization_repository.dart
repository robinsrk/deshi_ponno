import 'package:flutter/material.dart';

abstract class LocalizationRepository {
  Future<Locale> loadLanguage();
  Future<void> updateLanguage(Locale locale);
}
