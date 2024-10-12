// import 'package:deshi_ponno/features/all_products/presentation/pages/all_products_page.dart';
// import 'package:deshi_ponno/features/favourites/presentation/pages/favourites_page.dart';
// import 'package:deshi_ponno/features/home_page/presentation/pages/home_page.dart';
// import 'package:deshi_ponno/features/navigation/domain/cubit/nav_bar_cubit.dart';
// import 'package:deshi_ponno/features/navigation/widgets/bottom_nav_bar.dart';
// import 'package:deshi_ponno/features/settings/presentation/pages/settings_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class NavBarPage extends StatelessWidget {
//   const NavBarPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<NavBarCubit, NavBarState>(
//         builder: (context, state) {
//           if (state is HomeState) {
//             return const HomePage();
//           } else if (state is AllProductsState) {
//             return const ProductListPage(
//               categoryName: '',
//               brandName: '',
//             );
//           } else if (state is SettingsState) {
//             return const SettingsPage();
//           } else if (state is FavouritesState) {
//             return const FavouritesPage();
//           }
//           return Container();
//         },
//       ),
//       bottomNavigationBar: const BottomNavBar(),
//     );
//   }
// }
import 'package:deshi_ponno/features/all_products/presentation/pages/all_products_page.dart';
import 'package:deshi_ponno/features/favourites/presentation/pages/favourites_page.dart';
import 'package:deshi_ponno/features/home_page/presentation/pages/home_page.dart';
import 'package:deshi_ponno/features/navigation/domain/cubit/nav_bar_cubit.dart';
import 'package:deshi_ponno/features/navigation/widgets/bottom_nav_bar.dart';
import 'package:deshi_ponno/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  NavBarPageState createState() => NavBarPageState();
}

class NavBarPageState extends State<NavBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          Widget page;
          if (state is HomeState) {
            page = const HomePage();
          } else if (state is AllProductsState) {
            page = const ProductListPage(
              categoryName: '',
              brandName: '',
            );
          } else if (state is SettingsState) {
            page = const SettingsPage();
          } else if (state is FavouritesState) {
            page = const FavouritesPage();
          } else {
            page = Container();
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: page,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
