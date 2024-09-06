import 'package:deshi_ponno/features/settings/domain/entities/settings.dart';
import 'package:deshi_ponno/features/settings/domain/repositories/settings_repository.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository;

  SettingsCubit(this.settingsRepository, bool isDarkMode, bool isMaterialU)
      : super(SettingsInitial(
            settings:
                Settings(isDarkMode: isDarkMode, isMaterialU: isMaterialU)));

  void loadSettings() async {
    try {
      final settings = await settingsRepository.loadSettings();
      emit(SettingsLoaded(settings: settings));
    } catch (e) {
      emit(const SettingsError("Failed to load settings"));
    }
  }

  void toggleDarkMode() {
    final newSettings = state.settings.copyWith(
      isDarkMode: !state.settings.isDarkMode,
    );
    settingsRepository.updateSettings(newSettings);
    emit(SettingsLoaded(settings: newSettings));
  }

  void toggleMaterialU() {
    final newSettings = state.settings.copyWith(
      isMaterialU: !state.settings.isMaterialU,
    );
    settingsRepository.updateSettings(newSettings);
    emit(SettingsLoaded(settings: newSettings));
  }
}
