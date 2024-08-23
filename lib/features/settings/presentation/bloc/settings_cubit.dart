// import 'package:bloc/bloc.dart';
// import 'package:deshi_ponno/features/settings/domain/entities/settings.dart';
// import 'package:deshi_ponno/features/settings/domain/repositories/settings_repository.dart';
//
// import 'settings_state.dart';
//
// class SettingsCubit extends Cubit<SettingsState> {
//   final SettingsRepository settingsRepository;
//
//   SettingsCubit(this.settingsRepository) : super(SettingsInitial());
//
//   Future<void> loadSettings() async {
//     try {
//       final settings = await settingsRepository.loadSettings();
//       emit(SettingsLoaded(settings: settings));
//     } catch (_) {
//       emit(const SettingsError('Failed to load settings.'));
//     }
//   }
//
//   void toggleDarkMode(bool isDarkMode) {
//     final newSettings = Settings(isDarkMode: isDarkMode);
//     settingsRepository.updateSettings(newSettings);
//     emit(SettingsLoaded(settings: newSettings));
//   }
// }
// import 'package:bloc/bloc.dart';
// import 'package:deshi_ponno/features/settings/domain/entities/settings.dart';
// import 'package:deshi_ponno/features/settings/domain/repositories/settings_repository.dart';
// import 'package:deshi_ponno/features/settings/presentation/bloc/settings_state.dart';
//
// class SettingsCubit extends Cubit<SettingsState> {
//   final SettingsRepository settingsRepository;
//
//   SettingsCubit(this.settingsRepository, bool isDarkMode)
//       : super(SettingsInitial(settings: Settings(isDarkMode: isDarkMode)));
//
//   void toggleDarkMode() {
//     final newSettings = state.settings.copyWith(
//       isDarkMode: !state.settings.isDarkMode,
//     );
//     settingsRepository.updateSettings(newSettings);
//     emit(SettingsLoaded(settings: newSettings));
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:deshi_ponno/features/settings/domain/entities/settings.dart';
import 'package:deshi_ponno/features/settings/domain/repositories/settings_repository.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository;

  SettingsCubit(this.settingsRepository, bool isDarkMode)
      : super(SettingsInitial(settings: Settings(isDarkMode: isDarkMode)));

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
}
