import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/core/theme/theme_cubit.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/localization_cubit.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/settings_state.dart';
import 'package:deshi_ponno/features/settings/presentation/widgets/made_with_love_widget.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("settings"),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  if (state is SettingsLoaded) {
                    return Column(
                      children: [
                        SwitchListTile(
                          title: Text(AppLocalizations.of(context)
                              .translate("dark_mode")),
                          value: state.settings.isDarkMode,
                          onChanged: (value) async {
                            context.read<SettingsCubit>().toggleDarkMode();
                            context.read<ThemeCubit>().toggleTheme(
                                  value,
                                  state.settings.isMaterialU,
                                  lightDynamic:
                                      await _getDynamicLightColorScheme(),
                                  darkDynamic:
                                      await _getDynamicDarkColorScheme(),
                                );
                          },
                        ),
                        SwitchListTile(
                          title: Text(AppLocalizations.of(context)
                              .translate("material_theme")),
                          value: state.settings.isMaterialU,
                          onChanged: (value) async {
                            context.read<SettingsCubit>().toggleMaterialU();
                            context.read<ThemeCubit>().toggleTheme(
                                  state.settings.isDarkMode,
                                  value,
                                  lightDynamic:
                                      await _getDynamicLightColorScheme(),
                                  darkDynamic:
                                      await _getDynamicDarkColorScheme(),
                                );
                          },
                        ),
                      ],
                    );
                  } else if (state is SettingsError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              BlocBuilder<LocalizationCubit, Locale>(
                builder: (context, locale) {
                  return ListTile(
                    title: Text(
                        AppLocalizations.of(context).translate("language")),
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
              ),
            ],
          ),
          const MadeWithLoveWidget(),
        ],
      ),
    );
  }

  @override
  initState() {
    super.initState();
    context.read<SettingsCubit>().loadSettings();
  }

  Future<ColorScheme?> _getDynamicDarkColorScheme() async {
    return await DynamicColorPlugin.getCorePalette().then((corePalette) {
      return corePalette?.toColorScheme(brightness: Brightness.dark);
    });
  }

  Future<ColorScheme?> _getDynamicLightColorScheme() async {
    return await DynamicColorPlugin.getCorePalette().then((corePalette) {
      return corePalette?.toColorScheme();
    });
  }
}
