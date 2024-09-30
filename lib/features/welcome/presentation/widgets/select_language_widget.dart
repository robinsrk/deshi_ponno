import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

Widget _buildLanguageCard(BuildContext context, Locale locale, String langCode,
    String label, String logo) {
  bool isSelected = locale.languageCode == langCode;
  return GestureDetector(
    onTap: () {
      context.read<LocalizationCubit>().updateLocale(Locale(langCode, ''));
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isSelected ? 140 : 120,
      height: isSelected ? 140 : 120,
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
            : Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        boxShadow: isSelected
            ? [
                const BoxShadow(
                    color: Colors.black26, blurRadius: 10, spreadRadius: 1)
              ]
            : [],
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            logo,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            textAlign: TextAlign.center,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

class SelectLanguageWidget extends StatefulWidget {
  const SelectLanguageWidget({super.key});

  @override
  State<SelectLanguageWidget> createState() => _SelectLanguageWidgetState();
}

class _SelectLanguageWidgetState extends State<SelectLanguageWidget> {
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
              SvgPicture.asset(
                "assets/images/language.svg",
                height: 300,
                width: 200,
              ),
            ],
          ),
          BlocBuilder<LocalizationCubit, Locale>(
            builder: (context, locale) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLanguageCard(
                    context,
                    locale,
                    'en',
                    "English",
                    "🇺🇸 ",
                  ),
                  const SizedBox(width: 20),
                  _buildLanguageCard(
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
