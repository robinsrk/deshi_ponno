import 'package:deshi_ponno/core/localization/app_localization.dart';
import 'package:deshi_ponno/core/theme/theme_cubit.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/settings_state.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SelectThemePage extends StatefulWidget {
  const SelectThemePage({super.key});

  @override
  State<SelectThemePage> createState() => _SelectThemePageState();
}

class _SelectThemePageState extends State<SelectThemePage> {
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
                AppLocalizations.of(context).translate("select_theme"),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              SvgPicture.asset(
                "assets/images/theme.svg",
                height: 300,
                width: 200,
              ),
            ],
          ),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              if (state is SettingsLoaded) {
                return Column(
                  children: [
                    SwitchListTile(
                      title: Text(
                          AppLocalizations.of(context).translate("dark_mode")),
                      value: state.settings.isDarkMode,
                      onChanged: (value) async {
                        context.read<SettingsCubit>().toggleDarkMode();
                        context.read<ThemeCubit>().toggleTheme(
                              value,
                              state.settings.isMaterialU,
                              lightDynamic: await _getDynamicLightColorScheme(),
                              darkDynamic: await _getDynamicDarkColorScheme(),
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
                              lightDynamic: await _getDynamicLightColorScheme(),
                              darkDynamic: await _getDynamicDarkColorScheme(),
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
        ],
      ),
    );
  }

  @override
  void initState() {
    context.read<SettingsCubit>().loadSettings();
    super.initState();
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
