import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/features/navigation/domain/cubit/nav_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _getIndexFromState(context.watch<NavBarCubit>().state),
      showSelectedLabels: true,
      showUnselectedLabels: false,
      enableFeedback: true,
      onTap: (index) {
        switch (index) {
          case 0:
            context.read<NavBarCubit>().showHome();
            break;
          case 1:
            context.read<NavBarCubit>().showAllProducts();
            break;
          case 2:
            context.read<NavBarCubit>().showFavourites();
            break;
          case 3:
            context.read<NavBarCubit>().showSettings();
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: AppLocalizations.of(context).translate("home"),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.shopping_cart),
          label: AppLocalizations.of(context).translate("all_products"),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite),
          label: AppLocalizations.of(context).translate("favourites"),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: AppLocalizations.of(context).translate("settings"),
        ),
      ],
    );
  }

  int _getIndexFromState(NavBarState state) {
    if (state is HomeState) return 0;
    if (state is AllProductsState) return 1;
    if (state is FavouritesState) return 2;
    if (state is SettingsState) return 3;
    return 0;
  }
}
