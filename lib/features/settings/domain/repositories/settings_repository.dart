import 'package:deshi_ponno/features/settings/domain/entities/settings.dart';

abstract class SettingsRepository {
  Future<Settings> loadSettings();
  Future<void> updateSettings(Settings settings);
}
