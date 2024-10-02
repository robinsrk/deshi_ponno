import 'package:deshi_ponno/features/settings/presentation/bloc/localization_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget languageCardWidget(BuildContext context, Locale locale, String langCode,
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
            : Theme.of(context).colorScheme.secondary.withOpacity(0.0),
        borderRadius: BorderRadius.circular(10),
        border: !isSelected
            ? Border.all(color: Theme.of(context).colorScheme.primary)
            : null,
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
