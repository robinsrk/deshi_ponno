import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/localization_cubit.dart';
import 'package:deshi_ponno/features/welcome/presentation/widgets/language_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({super.key});

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 20),
          Column(
            children: [
              Text(
                AppLocalizations.of(context).translate("select_language"),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              Lottie.asset(
                "assets/lottie/language.json",
                reverse: true,
              )
            ],
          ),
          BlocBuilder<LocalizationCubit, Locale>(
            builder: (context, locale) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  languageCardWidget(
                    context,
                    locale,
                    'en',
                    "English",
                    "🇺🇸 ",
                  ),
                  const SizedBox(width: 20),
                  languageCardWidget(
                    context,
                    locale,
                    'bn',
                    "বাংলা",
                    "🇧🇩 ",
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
