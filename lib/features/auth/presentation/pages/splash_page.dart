import 'package:deshi_ponno/core/usecases/usecase.dart';
import 'package:deshi_ponno/features/auth/domain/usecases/check_user_logged_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    _checkAuthentication(context);
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _checkAuthentication(BuildContext context) async {
    final checkUserLoggedIn = context.read<CheckUserLoggedIn>();

    final result = await Future.delayed(const Duration(seconds: 3), () {
      return checkUserLoggedIn(NoParams());
    });
    // final result = await checkUserLoggedIn(NoParams());

    result.fold(
      (failure) {
        // Handle failure (e.g., navigate to an error page or display a message)
        print("Error: $failure");
        Navigator.pushReplacementNamed(context, '/login');
      },
      (isLoggedIn) {
        if (isLoggedIn) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
    );
  }
}
