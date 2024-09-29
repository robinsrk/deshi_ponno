import 'dart:developer' as dev;

import 'package:deshi_ponno/core/theme/theme_cubit.dart';
import 'package:deshi_ponno/core/usecases/usecase.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/check_user_logged_in.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/localization_cubit.dart';
import 'package:deshi_ponno/features/welcome/presentation/blocs/welcome_cubit.dart';
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
    return BlocBuilder<ThemeCubit, ThemeData>(
        builder: (BuildContext context, ThemeData theme) {
      dev.log("${theme.brightness}", name: "theme data");
      final String lottieImage = theme.brightness == Brightness.dark
          ? "assets/lottie/scan-light.json"
          : "assets/lottie/scan-dark.json";
      return BlocListener<WelcomeCubit, bool>(
          listener: (context, welcomeCompleted) {
            if (welcomeCompleted) {
              _checkAuthentication(context);
            } else {
              Navigator.pushReplacementNamed(context, '/welcome');
            }
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Center(
              child: Lottie.asset(lottieImage),
            ),
          ));
    });
  }

  @override
  void initState() {
    context.read<LocalizationCubit>().loadLocale();
    _checkWelcome(context);
    super.initState();
  }

  void _checkAuthentication(BuildContext context) async {
    final CheckUserLoggedIn checkUserLoggedIn =
        context.read<CheckUserLoggedIn>();

    final result = await Future.delayed(const Duration(seconds: 0), () {
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

  void _checkWelcome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3), () {
      context.read<WelcomeCubit>().checkWelcomeStatus();
    });
  }
}
