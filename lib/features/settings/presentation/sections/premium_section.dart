

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/constants/app_k.dart';
import 'package:hadith/core/features/premium/bloc/premium_bloc.dart';
import 'package:hadith/core/features/premium/bloc/premium_state.dart';
import 'package:hadith/core/features/premium/show_premium_dia.dart';
import 'package:hadith/core/features/share/bloc/share_bloc.dart';
import 'package:hadith/core/features/share/bloc/share_event.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_visibility.dart';
import 'package:hadith/features/settings/presentation/bloc/settings_state.dart';
import 'package:hadith/features/settings/presentation/settings_page.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/settings_bloc.dart';

extension SettingsPagePremiumExt on SettingsPage{

  CustomSettingsSection getPremiumSection(BuildContext context){
    final shareBloc = context.read<ShareBloc>();

    return CustomSettingsSection(
        child: BlocBuilder<PremiumBloc, PremiumState>(
          builder: (context, state) {
            return SettingsSection(
              title: const Text("Premium Ayarları"),
              tiles: [
                CustomSettingsTile(
                  child: CustomAnimatedVisibility(
                    visible: !state.isPremium,
                    child: SettingsTile.navigation(
                      title: const Text("Premium"),
                      onPressed: (context) {
                        showPremiumDia(context);
                      },
                      leading: const Icon(FontAwesomeIcons.solidChessKing),
                    ),
                  ),
                ),

                CustomSettingsTile(
                  child: BlocSelector<SettingsBloc,SettingsState,String>(
                      selector: (state)=>state.packageInfo,
                      builder: (context,packageInfo){
                        return CustomAnimatedVisibility(
                          visible: state.isPremium,
                          child: SettingsTile(
                            title: const Text("Abonelik Yönet"),
                            onPressed: (context) async {
                              final url = "${K.urls.playStoreSubsUrl}?package=$packageInfo";
                              shareBloc.add(ShareEventLaunchUrl(url: url,launchMode: LaunchMode.externalApplication));
                            },
                            leading: const Icon(Icons.manage_accounts),
                          ),
                        );
                      }
                  ),
                ),
              ],
            );
          },
        )
    );
  }
}