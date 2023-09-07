

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/backup/backup/show_backup_dia.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_visibility.dart';
import 'package:hadith/features/backup/show_backup_dia.dart';
import 'package:hadith/features/settings/auth_bloc/auth_bloc.dart';
import 'package:hadith/features/settings/auth_bloc/auth_state.dart';
import 'package:hadith/features/settings_/presentation/settings_page.dart';
import 'package:settings_ui/settings_ui.dart';

extension SettingsPageBackupExt on SettingsPage{

  CustomSettingsSection getBackupSection(){
    return CustomSettingsSection(
        child: BlocSelector<AuthBlocOld, AuthStateOld, User?>(
          selector: (state) => state.user,
          builder: (context, user) {
            return CustomAnimatedVisibility(
              visible: user != null,
              child: SettingsSection(
                title: const Text("Yedekleme"),
                tiles: [
                  SettingsTile(
                    title: const Text("Bulut Yedekleme"),
                    leading: const Icon(Icons.cloud),
                    onPressed: (context) {
                      if (user != null) {
                        showBackupDia(context);
                      }
                    },
                  ),
                ],
              ),
            );
          })
    );
  }
}