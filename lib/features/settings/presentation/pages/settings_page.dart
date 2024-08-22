import 'package:deshi_ponno/core/theme/theme_cubit.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:deshi_ponno/features/settings/presentation/bloc/settings_state.dart';
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
        title: const Text('Settings'),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoaded) {
            return SwitchListTile(
              title: const Text('Dark Mode'),
              value: state.settings.isDarkMode,
              onChanged: (value) {
                context.read<SettingsCubit>().toggleDarkMode(value);
                context.read<ThemeCubit>().toggleTheme(value);
              },
            );
          } else if (state is SettingsError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  initState() {
    super.initState();
    context.read<SettingsCubit>().loadSettings();
  }
}
