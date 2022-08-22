import 'package:accounting/common/common.dart';
import 'package:accounting/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: AppLocalizations.of(context)!.settings,
      ),
      drawer: const DrawerWidget(),
      body: SettingsList(
        platform: DevicePlatform.device,
        contentPadding: const EdgeInsets.all(50),
        sections: [
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.language),
            tiles: [
              CustomSettingsTile(
                child: FormBuilderDropdown<Locale>(
                  initialValue:
                      context.select((SettingsBloc bloc) => bloc.state.locale),
                  onChanged: (local) {
                    context
                        .read<SettingsBloc>()
                        .add(SettingsLanguageChanged(local!));
                  },
                  name: AppLocalizations.of(context)!.language,
                  items: const [
                    DropdownMenuItem(
                      value: Locale('en'),
                      child: Text('english'),
                    ),
                    DropdownMenuItem(
                      value: Locale('ar'),
                      child: Text('العربية'),
                    ),
                  ],
                ),
              )
            ],
          ),
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.appearance),
            tiles: [
              SettingsTile.switchTile(
                trailing: Icon(
                  context.select((SettingsBloc bloc) => bloc.state.themeMode) ==
                          ThemeMode.light
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                ),
                description: Text(AppLocalizations.of(context)!.appearance),
                initialValue: context
                        .select((SettingsBloc bloc) => bloc.state.themeMode) ==
                    ThemeMode.light,
                onToggle: (isLight) {
                  context.read<SettingsBloc>().add(
                        SettingsThemeChanged(
                          isLight ? ThemeMode.light : ThemeMode.dark,
                        ),
                      );
                },
                title: const Text(''),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
