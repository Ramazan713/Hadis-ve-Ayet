

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/features/settings_/presentation/bloc/settings_bloc.dart';
import 'package:hadith/features/settings_/presentation/bloc/settings_state.dart';
import 'package:hadith/features/settings_/presentation/settings_page.dart';
import 'package:hadith/utils/share_utils.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

extension SettingsPageAppExt on SettingsPage{

  SettingsSection getAppSection(){
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
                  final url = "https://play.google.com/store/apps/details?id=$packageInfo";
                  ShareUtils.shareContent(url);
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
                  final url =
                      "https://play.google.com/store/apps/details?id=$packageInfo";
                  try {
                    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                  } catch (e) {
                    ToastUtils.showLongToast(
                        "Bilinmeyen bir hata oluştu");
                  }
                },
              );
            }
          ),
        )
      ],
    );
  }
}