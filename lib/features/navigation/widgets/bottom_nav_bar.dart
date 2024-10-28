import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:deshi_ponno/core/errors/failures.dart';
import 'package:deshi_ponno/core/usecases/usecase.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/check_admin.dart';
import 'package:deshi_ponno/features/navigation/domain/cubit/nav_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  bool _isAdmin = false;
  late Future<void> _adminCheckFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _adminCheckFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final int currentIndex =
            _getIndexFromState(context.watch<NavBarCubit>().state);

        final items = <Widget>[
          const Icon(Icons.home, size: 30),
          const Icon(Icons.shopping_cart, size: 30),
          const Icon(Icons.favorite, size: 30),
          const Icon(Icons.settings, size: 30),
          if (_isAdmin) const Icon(Icons.person, size: 30),
        ];

        return CurvedNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          color: Theme.of(context).colorScheme.surface,
          index: currentIndex,
          height: 50,
          items: items,
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
              case 4:
                if (_isAdmin) context.read<NavBarCubit>().showAdmin();
                break;
            }
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _adminCheckFuture = _checkAdminStatus();
  }

  Future<void> _checkAdminStatus() async {
    final dartz.Either<Failure, bool> result =
        await context.read<CheckAdmin>()(NoParams());
    result.fold(
      (failure) {
        // Optionally handle failure (e.g., log or show a message)
        setState(() {
          _isAdmin = false;
        });
      },
      (isAdmin) {
        setState(() {
          _isAdmin = isAdmin;
        });
      },
    );
  }

  int _getIndexFromState(NavBarState state) {
    if (state is HomeState) return 0;
    if (state is AllProductsState) return 1;
    if (state is FavouritesState) return 2;
    if (state is SettingsState) return 3;
    if (_isAdmin && state is AdminState) return 4;
    return 0;
  }
}
