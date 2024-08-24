import 'dart:developer' as dev;

import 'package:deshi_ponno/core/theme/theme_cubit.dart';
import 'package:deshi_ponno/core/usecases/usecase.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/check_user_logged_in.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(builder: (context, theme) {
      dev.log("${theme.brightness}", name: "theme data");
      final lottieImage = theme.brightness == Brightness.dark
          ? "assets/lottie/scan-light.json"
          : "assets/lottie/scan-dark.json";
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: Lottie.asset(lottieImage),
        ),
      );
    });
  }

  @override
  initState() {
    _checkAuthentication(context);
    context.read<LocalizationCubit>().loadLocale();
    super.initState();
  }

  void _checkAuthentication(BuildContext context) async {
    final checkUserLoggedIn = context.read<CheckUserLoggedIn>();

    final result = await Future.delayed(const Duration(seconds: 3), () {
      return checkUserLoggedIn(NoParams());
    });

    result.fold(
      (failure) {
        dev.log("Error: $failure");
        Navigator.pushReplacementNamed(context, '/login');
      },
      (isLoggedIn) {
        if (isLoggedIn) {
          Navigator.pushReplacementNamed(context, '/main');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
    );
  }
}
