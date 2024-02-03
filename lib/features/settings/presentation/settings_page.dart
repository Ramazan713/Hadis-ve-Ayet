

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/auth/auth_listen_connect.dart';
import 'package:hadith/core/presentation/components/app_bar/default_nested_scrollable_app_bar.dart';
import 'package:hadith/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:hadith/features/settings/presentation/bloc/settings_event.dart';
import 'package:settings_ui/settings_ui.dart';
import './sections/advanced_settings_section.dart';
import './sections/app_settings_section.dart';
import './sections/auth_settings_section.dart';
import './sections/backup_settings_section.dart';
import './sections/general_settings_section.dart';
import './sections/premium_section.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final bloc = context.read<SettingsBloc>();
    bloc.add(SettingsEventLoadData());

    return AuthAndBackupListenConnect(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: DefaultNestedScrollableAppBar(
            snap: true,
            floating: true,
            title: const Text("Ayarlar"),
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  getUserProfile(context),
                  SettingsList(
                    shrinkWrap: true,
                    lightTheme: SettingsThemeData(
                      settingsListBackground: Theme.of(context).colorScheme.surface,
                    ),
                    sections: [
                      getGeneralSection(context),
                      getPremiumSection(context),
                      getBackupSection(),
                      getAdvancedSection(context),
                      getAppSection(context),
                      getSignOutSection(context)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}








