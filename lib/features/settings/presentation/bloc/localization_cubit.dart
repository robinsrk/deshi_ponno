import 'package:deshi_ponno/features/settings/domain/repositories/localization_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationCubit extends Cubit<Locale> {
  final LocalizationRepository localizationRepository;

  LocalizationCubit(this.localizationRepository)
      : super(const Locale('en', ''));

  Future<void> loadLocale() async {
    final locale = await localizationRepository.loadLanguage();
    emit(locale);
  }

  void updateLocale(Locale locale) {
    localizationRepository.updateLanguage(locale);
    emit(locale);
  }
}
