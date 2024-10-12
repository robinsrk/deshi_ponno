import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:deshi_ponno/features/navigation/domain/cubit/nav_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final int currentIndex =
        _getIndexFromState(context.watch<NavBarCubit>().state);
    return CurvedNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      color: Theme.of(context).colorScheme.surface,
      index: currentIndex,
      items: const <Widget>[
        Icon(Icons.home, size: 30),
        Icon(Icons.shopping_cart, size: 30),
        Icon(Icons.favorite, size: 30),
        Icon(Icons.settings, size: 30),
      ],
      animationDuration: const Duration(milliseconds: 500),
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
