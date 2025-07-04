import 'package:flutter_bloc/flutter_bloc.dart';

class AdminState extends NavBarState {}

class AllProductsState extends NavBarState {}

class HomeState extends NavBarState {}

class SettingsState extends NavBarState {}

class FavouritesState extends NavBarState {}

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(HomeState());

  void showAdmin() => emit(AdminState());

  void showAllProducts() => emit(AllProductsState());

  void showHome() => emit(HomeState());

  void showSettings() => emit(SettingsState());

  void showFavourites() => emit(FavouritesState());
}

abstract class NavBarState {}
