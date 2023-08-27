

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/features/premium/bloc/premium_bloc.dart';
import 'package:hadith/features/premium/bloc/premium_state.dart';
import 'package:hadith/features/premium/show_premium_dia.dart';
import 'package:hadith/features/settings_/presentation/bloc/settings_bloc.dart';
import 'package:hadith/features/settings_/presentation/bloc/settings_state.dart';
import 'package:hadith/features/settings_/presentation/settings_page.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

extension SettingsPagePremiumExt on SettingsPage{

  CustomSettingsSection getPremiumSection(){
    return CustomSettingsSection(
        child: BlocBuilder<PremiumBloc, PremiumState>(
          builder: (context, state) {
            return SettingsSection(
              title: const Text("Premium Ayarları"),
              tiles: [
                CustomSettingsTile(
                  child: Visibility(
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
                        return Visibility(
                          visible: state.isPremium,
                          child: SettingsTile(
                            title: const Text("Abonelik Yönet"),
                            onPressed: (context) async {
                              final url =
                                  "https://play.google.com/store/account/subscriptions?package=$packageInfo";
                              try {
                                await launchUrl(
                                    Uri.parse(url),
                                    mode: LaunchMode.externalApplication
                                );
                              } catch (e) {
                                ToastUtils.showLongToast(
                                    "Bilinmeyen bir hata oluştu");
                              }
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