import 'package:deshi_ponno/features/all_products/presentation/pages/all_products_page.dart';
import 'package:deshi_ponno/features/favourites/presentation/pages/favourites_page.dart';
import 'package:deshi_ponno/features/home_page/presentation/pages/home_page.dart';
import 'package:deshi_ponno/features/navigation/domain/cubit/nav_bar_cubit.dart';
import 'package:deshi_ponno/features/navigation/widgets/bottom_nav_bar.dart';
import 'package:deshi_ponno/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavBarPage extends StatelessWidget {
  const NavBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          if (state is HomeState) {
            return const HomePage();
          } else if (state is AllProductsState) {
            return const ProductListPage();
          } else if (state is SettingsState) {
            return const SettingsPage();
          } else if (state is FavouritesState) {
            return const FavouritesPage();
          }
          return Container();
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
