import 'package:deshi_ponno/features/settings/domain/entities/settings.dart';
import 'package:equatable/equatable.dart';

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);

  @override
  List<Object> get props => [message];
}

class SettingsInitial extends SettingsState {
  final Settings _settings;

  const SettingsInitial({required Settings settings}) : _settings = settings;

  @override
  List<Object> get props => [_settings];

  @override
  Settings get settings => _settings;
}

class SettingsLoaded extends SettingsState {
  final Settings _settings;

  const SettingsLoaded({required Settings settings}) : _settings = settings;

  @override
  List<Object> get props => [_settings];

  @override
  Settings get settings => _settings;
}

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];

  Settings get settings => throw UnimplementedError();
}
