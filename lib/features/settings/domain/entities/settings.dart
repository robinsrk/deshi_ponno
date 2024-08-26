import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  final bool isDarkMode;

  const Settings({required this.isDarkMode});

  @override
  List<Object?> get props => [isDarkMode];

  Settings copyWith({bool? isDarkMode}) {
    return Settings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
