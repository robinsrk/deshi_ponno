import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_events.dart';

class SignupButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const SignupButton({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          context.read<AuthBloc>().add(SignupEvent(
                email: emailController.text,
                password: passwordController.text,
              ));
        }
      },
      child: Text('Sign Up'),
    );
  }
}
