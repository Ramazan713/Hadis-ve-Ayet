

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/presentation/bloc/share_event.dart';
import 'package:hadith/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:hadith/features/settings/presentation/bloc/settings_state.dart';
import 'package:hadith/features/settings/presentation/settings_page.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

extension SettingsPageAppExt on SettingsPage{

  SettingsSection getAppSection(BuildContext context){
    final shareBloc = context.read<ShareBloc>();

    return SettingsSection(
      title: const Text('Uygulama'),
      tiles: [
        CustomSettingsTile(
          child: BlocSelector<SettingsBloc,SettingsState,String>(
            selector: (state)=>state.packageInfo,
            builder: (context,packageInfo){
              return  SettingsTile(
                title: const Text('Uygulamayı Paylaş'),
                leading: const Icon(Icons.share),
                onPressed: (context) {
                  final url = "${K.urls.playStoreDetailUrl}?id=$packageInfo";
                  shareBloc.add(ShareEventShareText(text: url));
                },
              );
            }
          ),
        ),
        CustomSettingsTile(
          child: BlocSelector<SettingsBloc,SettingsState,String>(
            selector: (state)=>state.packageInfo,
            builder: (context,packageInfo){
              return SettingsTile(
                title: const Text('Uygulamayı Derecelendir'),
                leading: const Icon(Icons.star_rate),
                onPressed: (context) async {
                  final url = "${K.urls.playStoreDetailUrl}?id=$packageInfo";
                  shareBloc.add(ShareEventLaunchUrl(url: url,launchMode: LaunchMode.externalApplication));
                },
              );
            }
          ),
        )
      ],
    );
  }
}