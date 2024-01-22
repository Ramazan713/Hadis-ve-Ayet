
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/core/domain/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/features/theme/domain/enums/theme_type_enum.dart';
import 'package:hadith/core/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:hadith/core/features/theme/presentation/bloc/theme_event.dart';
import 'package:hadith/core/features/theme/presentation/bloc/theme_state.dart';
import 'package:hadith/core/presentation/bottom_sheets/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/components/animated/custom_animated_visibility.dart';
import 'package:hadith/core/presentation/dialogs/show_select_search_criteria.dart';
import 'package:hadith/core/presentation/dialogs/show_select_verse_ui_2x.dart';
import 'package:hadith/core/presentation/selections/show_select_radio_dia.dart';
import 'package:hadith/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:hadith/features/settings/presentation/bloc/settings_state.dart';
import 'package:hadith/features/settings/presentation/settings_page.dart';
import 'package:settings_ui/settings_ui.dart';

extension SettingsPageGeneralExt on SettingsPage{

  SettingsSection getGeneralSection(BuildContext context){
    return SettingsSection(
      title: const Text('Genel Ayarlar'),
      tiles: [
        CustomSettingsTile(
          child: _getSelectTheme(context),
        ),
        CustomSettingsTile(
          child: _getUseDynamicColor(context),
        ),
        CustomSettingsTile(
            child: _getSearchCriteria()
        ),
        CustomSettingsTile(
            child: _getFontSize()
        ),
        CustomSettingsTile(
            child: _getSelectVerseUi()
        ),
      ],
    );
  }

  Widget _getUseDynamicColor(BuildContext context){
    final themeBloc = context.read<ThemeBloc>();
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return CustomAnimatedVisibility(
          visible: state.dynamicColorSupported,
          child: SettingsTile.switchTile(
            initialValue: state.useDynamicColors,
            onToggle: (newValue){
              themeBloc.add(ThemeEventSetUseDynamicColor(useDynamicColors: newValue));
            },
            title: const Text("Dinamik renkler kullan"),
            onPressed: (context) async {
              showSelectSearchCriteria(context,pref: KPref.searchCriteriaEnum);
            },
            leading: const Icon(Icons.palette),
          ),
        );
      }
    );
  }


  Widget _getSearchCriteria(){
    return BlocSelector<SettingsBloc, SettingsState, SearchCriteriaEnum>(
      selector: (state) => state.searchCriteria,
      builder: (context, searchCriteria) {
        return SettingsTile(
          title: const Text("Arama Kriteri"),
          onPressed: (context) async {
            showSelectSearchCriteria(context,pref: KPref.searchCriteriaEnum);
          },
          value: Text(searchCriteria.description),
          leading: const Icon(Icons.search),
        );
      });
  }

  Widget _getFontSize(){
    return BlocSelector<SettingsBloc, SettingsState, FontModel>(
      selector: (state) => state.fontModel,
      builder: (context, fontModel) {
        return SettingsTile(
          leading: const Icon(Icons.font_download),
          title: const Text("Yazı Boyutu"),
          value: Text(fontModel.contentFontSizeEnum.description),
          onPressed: (context) {
            showSelectFontSizeDia(context);
          }
        );
      }
    );
  }

  Widget _getSelectVerseUi(){
    return BlocSelector<SettingsBloc, SettingsState, ArabicVerseUI2X>(
      selector: (state) => state.verseUI,
      builder: (context, verseArabicUI) {
        return SettingsTile(
          title: const Text("Ayetler Görünüm"),
          onPressed: (context) {
            showSelectVerseUi2X(context,pref: KPref.verseAppearanceEnum);
          },
          leading: const Icon(FontAwesomeIcons.bookQuran),
          value: Text(verseArabicUI.description),
        );
      }
    );
  }

  Widget _getSelectTheme(BuildContext context){
    final themeBloc = context.read<ThemeBloc>();
    return BlocSelector<ThemeBloc, ThemeState, ThemeTypeEnum>(
      selector: (state) => state.themeType,
      builder: (context, currentThemeType) {
        return SettingsTile(
          title: const Text("Tema Modu"),
          onPressed: (context) async {
            showSelectRadioDia(
              context,
              title: "Tema Seç",
              iconData: Icons.palette,
              items: ThemeTypeEnum.values,
              currentItem: currentThemeType,
              onSelected: (selected){
                themeBloc.add(ThemeEventSetThemeType(themeTypeEnum: selected));
              }
            );
          },
          value: Text(currentThemeType.description),
          leading: const Icon(Icons.palette),
        );
      }
    );
  }

}