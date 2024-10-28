import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final VoidCallback onPressed;

  const LoginButton({
    required this.formKey,
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
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
          : Text(AppLocalizations.of(context).translate("login")),
    );
  }
}
