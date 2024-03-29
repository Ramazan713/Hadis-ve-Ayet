

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/features/backup/presentation/backup/bloc/backup_bloc.dart';
import 'package:hadith/core/features/backup/presentation/backup/bloc/backup_event.dart';
import 'package:hadith/core/presentation/dialogs/show_custom_alert_dia.dart';
import 'package:hadith/features/app/routes/app_routers.dart';
import 'package:hadith/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:hadith/features/settings/presentation/bloc/settings_event.dart';
import 'package:hadith/features/settings/presentation/bloc/settings_state.dart';
import '../settings_page.dart';
import 'package:settings_ui/settings_ui.dart';

extension SettingsPageAdvancedExt on SettingsPage{

  SettingsSection getAdvancedSection(BuildContext context){

    final bloc = context.read<SettingsBloc>();
    final backupBloc = context.read<BackupBloc>();

    return SettingsSection(
      title: const Text("Gelişmiş Ayarlar"),
      tiles: [
        CustomSettingsTile(
          child: BlocSelector<SettingsBloc, SettingsState, bool>(
            selector: (state) => state.useArchiveAsSelectList,
            builder: (context, useArchiveAsSelectList) {
              return SettingsTile.switchTile(
                initialValue: useArchiveAsSelectList,
                onToggle: (newValue) async {
                  bloc.add(SettingsEventSetArchiveAsList(archiveAsList: newValue));
                },
                title: const Text(
                    "Arşivdeki listeleri, liste seçmede ve eklemede kullan"),
              );
            }),
        ),
        CustomSettingsTile(
          child: BlocSelector<SettingsBloc, SettingsState, bool>(
            selector: (state) => state.showSelectedListVerseIcons,
            builder: (context, showSelectedListVerseIcons) {
              return SettingsTile.switchTile(
                initialValue: showSelectedListVerseIcons,
                onToggle: (newValue) async {
                  bloc.add(SettingsEventSetShowListIcons(showListIcons: newValue));
                },
                title: const Text(
                    "Ayetlerde eklenen liste simgelerini göster"),
              );
            }),
        ),
        SettingsTile(
          title: const Text("Ses ayarları"),
          leading: const Icon(Icons.audiotrack),
          onPressed: (context){
            SettingsAudioRoute().push(context);
          },
        ),
        SettingsTile(
          title: const Text("Varsayılan ayarlara dön"),
          onPressed: (context) {
            showCustomAlertDia(context,
              title: "Varsayılan ayarlara dönmek istediğinize emin misiniz?",
              btnApproved: () async {
                bloc.add(SettingsEventResetSettings());
              }
            );
          },
          leading: const Icon(Icons.settings_backup_restore),
        ),
        SettingsTile(
          title: const Text("Tüm verileri Sil"),
          onPressed: (context) {
            showCustomAlertDia(context,
              title: "Devam etmek istiyor musunuz?",
              content: "Tüm verileriniz silinecektir. Bu işlem geri alınamaz",
              btnApproved: () async {
                backupBloc.add(BackupEventDeleteAllUserData());
              }
            );
          },
          leading: const Icon(Icons.delete_forever),
        )
      ],
    );
  }
}