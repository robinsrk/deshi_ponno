import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final VoidCallback onPressed;

  const SignupButton({
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.0,
              ),
            )
          : const Text('Sign up'),
    );
  }
}
