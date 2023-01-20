import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_enum.dart';
import 'package:hadith/dialogs/show_select_font_size_bottom_dia.dart';
import 'package:hadith/features/backup/show_backup_dia.dart';
import 'package:hadith/features/search/show_select_search_criteria.dart';
import 'package:hadith/features/settings/audio_setting/audio_settings.dart';
import 'package:hadith/features/settings/auth_bloc/auth_bloc.dart';
import 'package:hadith/features/settings/auth_bloc/auth_event.dart';
import 'package:hadith/features/settings/auth_bloc/auth_state.dart';
import 'package:hadith/features/settings/bloc/setting_bloc.dart';
import 'package:hadith/features/settings/bloc/setting_event.dart';
import 'package:hadith/features/settings/bloc/setting_state.dart';
import 'package:hadith/features/settings/components/user_icon.dart';
import 'package:hadith/features/verse/common_dialogs/show_select_verse_ui.dart';
import 'package:hadith/themes/bloc/theme_state.dart';
import 'package:hadith/utils/share_utils.dart';
import 'package:hadith/utils/toast_utils.dart';
import 'package:hadith/widgets/custom_button_positive.dart';
import 'package:hadith/constants/enums/search_criteria_enum.dart';
import 'package:hadith/constants/enums/theme_enum.dart';
import 'package:hadith/dialogs/show_custom_alert_bottom_dia.dart';
import 'package:hadith/themes/custom/get_setting_theme.dart';
import 'package:hadith/utils/theme_util.dart';
import 'package:hadith/dialogs/show_select_radio_enums.dart';
import 'package:hadith/models/item_label_model.dart';
import 'package:hadith/themes/bloc/theme_bloc.dart';
import 'package:hadith/themes/bloc/theme_event.dart';
import 'package:hadith/widgets/custom_sliver_appbar.dart';
import 'package:hadith/widgets/custom_sliver_nested_scrollview.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/enums/font_size_enum.dart';
import '../premium/bloc/premium_bloc.dart';
import '../premium/bloc/premium_state.dart';
import '../premium/show_premium_dia.dart';
import 'components/auth_setting_blocs_connect.dart';

class SettingScreen extends StatelessWidget {
  static const String id = "SettingScreen";

  final ScrollController scrollController = ScrollController();

  SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final settingBloc = context.read<SettingBloc>();

    return Scaffold(
      body: CustomSliverNestedView(context, scrollController: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          const CustomSliverAppBar(
            title: Text("Ayarlar"),
          )
        ];
      },
          child: AuthSettingBlocsConnect(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Column(
                    children: const [
                      SizedBox(
                        height: 19,
                      ),
                      CurrentUserIcon(),
                      SizedBox(
                        height: 7,
                      ),
                      _SignIn(),
                      _UserInfo()
                    ],
                  ),
                  SettingsList(
                    shrinkWrap: true,
                    lightTheme: getSettingThemeData(context),
                    sections: [
                      const SettingsSection(
                        title: Text('Genel Ayarlar'),
                        tiles: [
                          CustomSettingsTile(
                            child: _SelectTheme(),
                          ),
                          CustomSettingsTile(child: _SelectSearchType()),
                          CustomSettingsTile(child: _SelectFontText()),
                          CustomSettingsTile(child: _SelectVerseUI()),
                        ],
                      ),
                      CustomSettingsSection(
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
                                    leading: const Icon(
                                        FontAwesomeIcons.solidChessKing),
                                  ),
                                ),
                              ),

                              CustomSettingsTile(
                                child: BlocSelector<SettingBloc,SettingState,String>(
                                    selector: (state)=>state.packageInfo,
                                    builder: (context,packageInfo){
                                      return   Visibility(
                                        visible: state.isPremium,
                                        child: SettingsTile(
                                          title: const Text("Abonelik Yönet"),
                                          onPressed: (context) async {
                                            final url =
                                                "https://play.google.com/store/account/subscriptions?package=$packageInfo";
                                            try {
                                              await launchUrl(Uri.parse(url),
                                                  mode:
                                                  LaunchMode.externalApplication);
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
                      )),
                      CustomSettingsSection(
                          child: BlocSelector<AuthBloc, AuthState, User?>(
                              selector: (state) => state.user,
                              builder: (context, user) {
                                return Visibility(
                                  visible: user != null,
                                  child: SettingsSection(
                                    title: const Text("Yedekleme"),
                                    tiles: [
                                      SettingsTile(
                                        title: const Text("Bulut Yedekleme"),
                                        leading: const Icon(Icons.cloud),
                                        onPressed: (context) {
                                          if (user != null) {
                                            showBackup(context);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              })),
                      SettingsSection(
                        title: const Text("Gelişmiş Ayarlar"),
                        tiles: [
                          CustomSettingsTile(
                            child:
                                BlocSelector<SettingBloc, SettingState, bool>(
                                    selector: (state) =>
                                        state.useArchiveAsSelectList,
                                    builder: (context, useArchiveAsSelectList) {
                                      return SettingsTile.switchTile(
                                        initialValue: useArchiveAsSelectList,
                                        onToggle: (newValue) async {
                                          settingBloc.add(
                                              SettingEventSetArchiveAsList(
                                                  archiveAsList: newValue));
                                        },
                                        title: const Text(
                                            "Arşivdeki listeleri, liste seçmede ve eklemede kullan"),
                                      );
                                    }),
                          ),
                          CustomSettingsTile(
                            child: BlocSelector<SettingBloc, SettingState,
                                    bool>(
                                selector: (state) =>
                                    state.showSelectedListVerseIcons,
                                builder: (context, showSelectedListVerseIcons) {
                                  return SettingsTile.switchTile(
                                    initialValue: showSelectedListVerseIcons,
                                    onToggle: (newValue) async {
                                      settingBloc.add(
                                          SettingEventSetShowListIcons(
                                              showListIcons: newValue));
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
                              Navigator.pushNamed(context, AudioSettings.id);
                            },
                          ),
                          SettingsTile(
                            title: const Text("Varsayılan ayarlara dön"),
                            onPressed: (context) {
                              showCustomAlertBottomDia(context,
                                  title:
                                      "Varsayılan ayarlara dönmek istediğinize emin misiniz?",
                                  btnApproved: () async {
                                settingBloc.add(SettingEventResetSettings());
                                context.read<ThemeBloc>().add(
                                    ThemeEventChangeTheme(
                                        themeEnum:
                                            ThemeUtil.getDefaultTheme()));
                              });
                            },
                            leading: const Icon(Icons.settings_backup_restore),
                          ),
                          SettingsTile(
                            title: const Text("Tüm verileri Sil"),
                            onPressed: (context) {
                              showCustomAlertBottomDia(context,
                                  title: "Devam etmek istiyor musunuz?",
                                  content:
                                      "Tüm verileriniz silinecektir. Bu işlem geri alınamaz",
                                  btnApproved: () async {
                                authBloc.add(AuthEventDeleteAllLocalData());
                              });
                            },
                            leading: const Icon(Icons.delete_forever),
                          )
                        ],
                      ),
                      SettingsSection(
                        title: const Text('Uygulama'),
                        tiles: [
                          CustomSettingsTile(
                            child: BlocSelector<SettingBloc,SettingState,String>(
                                selector: (state)=>state.packageInfo,
                                builder: (context,packageInfo){
                                  return  SettingsTile(
                                    title: const Text('Uygulamayı Paylaş'),
                                    leading: const Icon(Icons.share),
                                    onPressed: (context) {
                                      final url =
                                          "https://play.google.com/store/apps/details?id=$packageInfo";
                                      ShareUtils.shareContent(url);
                                    },
                                  );
                                }
                            ),
                          ),
                          CustomSettingsTile(
                            child: BlocSelector<SettingBloc,SettingState,String>(
                                selector: (state)=>state.packageInfo,
                                builder: (context,packageInfo){
                                    return SettingsTile(
                                      title: const Text('Uygulamayı Derecelendir'),
                                      leading: const Icon(Icons.star_rate),
                                      onPressed: (context) async {
                                        final url =
                                            "https://play.google.com/store/apps/details?id=$packageInfo";
                                        try {
                                          await launchUrl(Uri.parse(url),
                                              mode: LaunchMode.externalApplication);
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
                      ),
                      const CustomSettingsSection(
                        child: CustomSettingsTile(
                          child: _SignOut(),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthBloc, AuthState, User?>(
        selector: (state) => state.user,
        builder: (context, user) {
          return Visibility(
            visible: user != null,
            child: Column(
              children: [
                Text(user?.displayName ?? "Boş"),
                const SizedBox(
                  height: 7,
                ),
                Text(user?.email ?? "Boş"),
                const SizedBox(
                  height: 13,
                )
              ],
            ),
          );
        });
  }
}

class _SignIn extends StatelessWidget {
  const _SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return BlocSelector<AuthBloc, AuthState, User?>(
      selector: (state) => state.user,
      builder: (context, user) {
        return Visibility(
            visible: (user == null),
            child: CustomButtonPositive(
              onTap: () async {
                authBloc.add(AuthEventSignIn());
              },
              label: "Giriş Yap",
            ));
      },
    );
  }
}

class _SelectTheme extends StatelessWidget {
  const _SelectTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeBloc, ThemeState, ThemeTypesEnum>(
        selector: (state) => state.themeEnum,
        builder: (context, themeType) {
          return SettingsTile(
            title: const Text("Tema Modu"),
            onPressed: (context) async {
              final currentValue = ItemLabelModel(
                  item: themeType, label: themeType.getDescription());
              final List<ItemLabelModel<ThemeTypesEnum>> radioItems =
                  ThemeTypesEnum
                      .values
                      .map((e) =>
                          ItemLabelModel(item: e, label: e.getDescription()))
                      .toList();
              showSelectRadioEnums<ThemeTypesEnum>(context,
                  currentValue: currentValue,
                  radioItems: radioItems, closeListener: (lastSelected) async {
                if (lastSelected.item != themeType) {
                  context
                      .read<ThemeBloc>()
                      .add(ThemeEventChangeTheme(themeEnum: lastSelected.item));
                }
              });
            },
            value: Text(themeType.getDescription()),
            leading: const Icon(Icons.palette),
          );
        });
  }
}

class _SelectSearchType extends StatelessWidget {
  const _SelectSearchType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingBloc = context.read<SettingBloc>();

    return BlocSelector<SettingBloc, SettingState, SearchCriteriaEnum>(
        selector: (state) => state.searchCriteria,
        builder: (context, searchCriteria) {
          return SettingsTile(
            title: const Text("Arama Kriteri"),
            onPressed: (context) async {
              showSelectSearchCriteria(context, currentValue: searchCriteria,
                  callback: (lastSelected) {
                settingBloc.add(SettingEventSetSearchCriteria(
                    searchCriteria: lastSelected));
              });
            },
            value: Text(searchCriteria.getDescription()),
            leading: const Icon(Icons.search),
          );
        });
  }
}

class _SelectFontText extends StatelessWidget {
  const _SelectFontText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingBloc = context.read<SettingBloc>();

    return BlocSelector<SettingBloc, SettingState, String>(
        selector: (state) => state.fontText,
        builder: (context, fontText) {
          return SettingsTile(
            leading: const Icon(Icons.font_download),
            title: const Text("Yazı Boyutu"),
            onPressed: (context) {
              showSelectFontSizeBottomDia(context, listener: (selected) {
                settingBloc
                    .add(SettingEventSetFontText(fontText: selected.shortName));
              });
            },
            value: Text(fontText),
          );
        });
  }
}

class _SelectVerseUI extends StatelessWidget {
  const _SelectVerseUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingBloc = context.read<SettingBloc>();
    return BlocSelector<SettingBloc, SettingState, ArabicVerseUIEnum>(
        selector: (state) => state.arabicVerseUI,
        builder: (context, verseArabicUI) {
          return SettingsTile(
            title: const Text("Ayetler Görünüm"),
            onPressed: (context) {
              showSelectVerseUi(context, currentValue: verseArabicUI,
                  callback: (selected) {
                settingBloc
                    .add(SettingEventSetArabicUI(arabicVerseUI: selected));
              });
            },
            leading: const Icon(FontAwesomeIcons.bookQuran),
            value: Text(verseArabicUI.description),
          );
        });
  }
}

class _SignOut extends StatelessWidget {
  const _SignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return BlocSelector<AuthBloc, AuthState, User?>(
        selector: (state) => state.user,
        builder: (context, user) {
          return Visibility(
            visible: user != null,
            child: SettingsTile(
              title: const Center(
                  child: Text(
                "Çıkış Yap",
                style: TextStyle(color: Colors.redAccent),
              )),
              onPressed: (context) {
                showCustomAlertBottomDia(context,
                    title: "Çıkış yapmak istediğinize emin misiniz?",
                    btnApproved: () async {
                  showCustomAlertBottomDia(context,
                      negativeLabel: "Devam Et",
                      positiveLabel: "Oluştur",
                      title: "Yedekleme yapmak ister misiniz?",
                      content: "Kaydedilmeyen verileriniz kaybolabilir",
                      btnApproved: () async {
                    authBloc.add(AuthEventUploadAutoBackup());
                  }, btnCancelled: () async {
                    authBloc.add(AuthEventSignOut());
                  });
                });
              },
            ),
          );
        });
  }
}
