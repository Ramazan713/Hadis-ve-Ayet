

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/auth/auth_listen_connect.dart';
import 'package:hadith/core/presentation/components/app_bar/custom_nested_view_app_bar.dart';
import 'package:hadith/features/settings/bloc/setting_bloc.dart';
import 'package:hadith/features/settings/components/auth_setting_blocs_connect.dart';
import 'package:hadith/features/settings_/presentation/bloc/settings_bloc.dart';
import 'package:hadith/features/settings_/presentation/bloc/settings_event.dart';

import 'package:hadith/features/settings_/presentation/sections/advanced_settings_section.dart';
import 'package:hadith/features/settings_/presentation/sections/app_settings_section.dart';
import 'package:hadith/features/settings_/presentation/sections/auth_settings_section.dart';
import 'package:hadith/features/settings_/presentation/sections/backup_settings_section.dart';
import 'package:hadith/features/settings_/presentation/sections/general_settings_section.dart';
import 'package:hadith/features/settings_/presentation/sections/premium_section.dart';
import 'package:hadith/themes/custom/get_setting_theme.dart';
import 'package:settings_ui/settings_ui.dart';



class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<SettingsBloc>();
    bloc.add(SettingsEventLoadData());

    return AuthAndBackupListenConnect(
      child: Scaffold(
        body: SafeArea(
          child: CustomNestedViewAppBar(
            snap: true,
            floating: true,
            title: const Text("Ayarlar"),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  getUserProfile(),
                  SettingsList(
                    shrinkWrap: true,
                    sections: [
                      getGeneralSection(),
                      getPremiumSection(),
                      getBackupSection(),
                      getAdvancedSection(context),
                      getAppSection(),
                      getSignOutSection()
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








