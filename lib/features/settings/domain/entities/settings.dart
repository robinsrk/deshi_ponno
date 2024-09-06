import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  final bool isDarkMode;
  final bool isMaterialU;

  const Settings({required this.isDarkMode, required this.isMaterialU});

  @override
  List<Object?> get props => [isDarkMode, isMaterialU];

  Settings copyWith({bool? isDarkMode, bool? isMaterialU}) {
    return Settings(
      isMaterialU: isMaterialU ?? this.isMaterialU,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
