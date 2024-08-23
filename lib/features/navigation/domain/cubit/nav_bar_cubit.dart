import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductsState extends NavBarState {}

class HomeState extends NavBarState {}

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(HomeState());

  void showAllProducts() => emit(AllProductsState());

  void showHome() => emit(HomeState());

  void showSettings() => emit(SettingsState());
}

abstract class NavBarState {}

class SettingsState extends NavBarState {}
