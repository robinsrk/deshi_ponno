import 'package:deshi_ponno/features/settings/domain/entities/settings.dart';
import 'package:equatable/equatable.dart';

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);

  @override
  List<Object> get props => [message];
}

class SettingsInitial extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final Settings settings;

  const SettingsLoaded({required this.settings});

  @override
  List<Object> get props => [settings];
}

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}
