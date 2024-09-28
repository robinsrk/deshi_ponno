import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSelectionWidet extends StatelessWidget {
  const LanguageSelectionWidet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Locale>(
      builder: (context, locale) {
        return ListTile(
          title: Text(AppLocalizations.of(context).translate("language")),
          trailing: Wrap(
            spacing: 8.0,
            children: [
              ChoiceChip(
                label: const Text("🇺🇸 English"),
                selected: locale.languageCode == 'en',
                onSelected: (bool selected) {
                  if (selected) {
                    context
                        .read<LocalizationCubit>()
                        .updateLocale(const Locale('en', ''));
                  }
                },
              ),
              ChoiceChip(
                label: const Text("🇧🇩 বাংলা"),
                selected: locale.languageCode == 'bn',
                onSelected: (bool selected) {
                  if (selected) {
                    context
                        .read<LocalizationCubit>()
                        .updateLocale(const Locale('bn', ''));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
