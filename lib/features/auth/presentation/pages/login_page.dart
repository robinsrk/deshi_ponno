import 'package:deshi_ponno/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_events.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_states.dart';
import 'package:deshi_ponno/features/auth/presentation/widgets/email_input_field.dart';
import 'package:deshi_ponno/features/auth/presentation/widgets/login_button.dart';
import 'package:deshi_ponno/features/auth/presentation/widgets/password_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  BannerAd bannerAd = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/2247696110',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            setState(() {
              _isLoading = false; // Reset the loading state on error
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                SvgPicture.asset(
                  "assets/images/login.svg",
                  height: 300,
                  width: 200,
                ),
                const SizedBox(height: 16),
                EmailInputField(controller: _emailController),
                const SizedBox(height: 16),
                PasswordInputField(controller: _passwordController),
                const SizedBox(height: 16),
                LoginButton(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  formKey: _formKey,
                  isLoading: _isLoading,
                  onPressed: _onLoginButtonPressed,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                  child: const Text('Don\'t have an account? Sign up'),
                ),
                SizedBox(
                  width: bannerAd.size.width.toDouble(),
                  height: bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: bannerAd),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    bannerAd.load();
  }

  void _onLoginButtonPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      context.read<AuthBloc>().add(
            LoginEvent(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );
    }
  }
}
