
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/auth/domain/models/auth_user/auth_user.dart';
import 'package:hadith/core/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hadith/core/features/auth/presentation/bloc/auth_state.dart';
import 'package:hadith/core/features/backup/presentation/backup/show_backup_dia.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_visibility.dart';
import '../settings_page.dart';
import 'package:settings_ui/settings_ui.dart';

extension SettingsPageBackupExt on SettingsPage{

  CustomSettingsSection getBackupSection(){
    return CustomSettingsSection(
        child: BlocSelector<AuthBloc, AuthState, AuthUser?>(
          selector: (state) => state.currentUser,
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