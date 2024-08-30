import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_events.dart';
import 'package:deshi_ponno/features/auth/presentation/bloc/auth_states.dart';
import 'package:deshi_ponno/features/auth/presentation/widgets/email_input_field.dart';
import 'package:deshi_ponno/features/auth/presentation/widgets/password_input_field.dart';
import 'package:deshi_ponno/features/auth/presentation/widgets/signup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isAdLoaded = false; // Track ad load status

  late BannerAd bannerAd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("sign_up")),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, '/main');
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
                  "assets/images/form.svg",
                  height: 200,
                  width: 100,
                ),
                const SizedBox(height: 16),
                EmailInputField(controller: _emailController),
                const SizedBox(height: 16),
                PasswordInputField(controller: _passwordController),
                const SizedBox(height: 16),
                SignupButton(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  formKey: _formKey,
                  isLoading: _isLoading,
                  onPressed: _onSignupButtonPressed,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                      '${AppLocalizations.of(context).translate("already_account")} ${AppLocalizations.of(context).translate("login")}'),
                ),
                if (_isAdLoaded)
                  SizedBox(
                    height: bannerAd.size.height.toDouble(),
                    width: bannerAd.size.width.toDouble(),
                    child: AdWidget(ad: bannerAd),
                  ),
                // SizedBox(
                //   height: bannerAd.size.height.toDouble(),
                //   width: bannerAd.size.width.toDouble(),
                //   child: AdWidget(ad: bannerAd),
                // )
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
    bannerAd.dispose();
    super.dispose();
  }

  // bannerAd = BannerAd(
  //   adUnitId: 'ca-app-pub-3978946832189310/9374110609',
  //   size: AdSize.banner,
  //   request: const AdRequest(),
  //   listener: const BannerAdListener(),
  // );
  @override
  void initState() {
    super.initState();

    bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3978946832189310/9374110609',
      // adUnitId: 'ca-app-pub-3940256099942544/9214589741',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true; // Update the state when the ad is loaded
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose(); // Dispose of the ad if it fails to load
        },
      ),
    );

    bannerAd.load(); // Load the ad
  }

  void _onSignupButtonPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      context.read<AuthBloc>().add(SignupEvent(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ));
    }
  }
}
