import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  final Locale locale;

  late Map<String, String> _localizedStrings;
  late Map<String, String> _brandLocalize;

  AppLocalizations(this.locale);

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings =
        jsonMap.map<String, String>((String key, dynamic value) {
      return MapEntry<String, String>(key, value.toString());
    });

    String brandString = await rootBundle
        .loadString('assets/lang/brand_${locale.languageCode}.json');
    Map<String, dynamic> brandMap = json.decode(brandString);

    _brandLocalize = brandMap.map<String, String>((String key, dynamic value) {
      return MapEntry<String, String>(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  String brand(String key) {
    return _brandLocalize[key] ?? key;
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return <String>['en', 'bn'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
