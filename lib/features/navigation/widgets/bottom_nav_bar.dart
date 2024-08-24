import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/features/navigation/domain/cubit/nav_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _getIndexFromState(context.watch<NavBarCubit>().state),
      onTap: (index) {
        switch (index) {
          case 0:
            context.read<NavBarCubit>().showHome();
            break;
          case 1:
            context.read<NavBarCubit>().showAllProducts();
            break;
          case 2:
            context.read<NavBarCubit>().showSettings();
            break;
        }
      },
      // selectedItemColor: Colors.red,

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
          icon: const Icon(Icons.settings),
          label: AppLocalizations.of(context).translate("settings"),
        ),
      ],
    );
  }

  int _getIndexFromState(NavBarState state) {
    if (state is HomeState) return 0;
    if (state is AllProductsState) return 1;
    if (state is SettingsState) return 2;
    return 0;
  }
}
