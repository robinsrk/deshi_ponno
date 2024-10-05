import 'package:deshi_ponno/features/settings/domain/entities/settings.dart';
import 'package:deshi_ponno/features/settings/domain/repositories/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  static const String _darkModeKey = 'isDarkMode';
  static const String _materialModeKey = "isMaterialMode";

  @override
  Future<Settings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_darkModeKey) ?? false;
    final isMaterialMode = prefs.getBool(_materialModeKey) ?? false;
    return Settings(isDarkMode: isDarkMode, isMaterialU: isMaterialMode);
  }

  @override
  Future<void> updateSettings(Settings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, settings.isDarkMode);
    await prefs.setBool(_materialModeKey, settings.isMaterialU);
  }
}
