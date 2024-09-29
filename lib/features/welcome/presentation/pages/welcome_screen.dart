// lib/features/welcome/presentation/pages/welcome_page.dart
import 'package:deshi_ponno/core/usecases/usecase.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/check_user_logged_in.dart';
import 'package:deshi_ponno/features/welcome/presentation/blocs/welcome_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<WelcomeCubit>().finishWelcome().then((_) {
              _navigateToNextScreen(context);
            });
          },
          child: const Text("Finish Welcome"),
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) async {
    final CheckUserLoggedIn checkUserLoggedIn =
        context.read<CheckUserLoggedIn>();

    final result = await Future.delayed(const Duration(seconds: 0), () {
      return checkUserLoggedIn(NoParams());
    });

    result.fold(
      (failure) {
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
