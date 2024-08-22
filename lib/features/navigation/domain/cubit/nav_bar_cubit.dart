import 'package:flutter_bloc/flutter_bloc.dart';

class HomeState extends NavBarState {}

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(HomeState());

  void showHome() => emit(HomeState());

  void showProfile() => emit(ProfileState());

  void showSettings() => emit(SettingsState());
}

abstract class NavBarState {}

class ProfileState extends NavBarState {}

class SettingsState extends NavBarState {}
