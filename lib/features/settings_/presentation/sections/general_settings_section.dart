
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadith/constants/enums/theme_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/models/font_model.dart';
import 'package:hadith/core/features/select_font_size/show_select_font_size_dia.dart';
import 'package:hadith/core/presentation/dialogs/show_select_search_criteria.dart';
import 'package:hadith/core/presentation/dialogs/show_select_verse_ui_2x.dart';
import 'package:hadith/dialogs/show_select_radio_enums.dart';
import 'package:hadith/features/settings_/presentation/bloc/settings_bloc.dart';
import 'package:hadith/features/settings_/presentation/bloc/settings_state.dart';
import 'package:hadith/features/settings_/presentation/settings_page.dart';
import 'package:hadith/models/item_label_model.dart';
import 'package:hadith/themes/bloc/theme_bloc.dart';
import 'package:hadith/themes/bloc/theme_event.dart';
import 'package:hadith/themes/bloc/theme_state.dart';
import 'package:settings_ui/settings_ui.dart';

extension SettingsPageGeneralExt on SettingsPage{


  SettingsSection getGeneralSection(){
    return SettingsSection(
      title: const Text('Genel Ayarlar'),
      tiles: [
        const CustomSettingsTile(
          child: _SelectTheme(),
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
          value: Text(fontModel.contentFontSize.toString()),
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
        });
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
                      context.read<ThemeBloc>().add(ThemeEventChangeTheme(themeEnum: lastSelected.item));
                    }
                  });
            },
            value: Text(themeType.getDescription()),
            leading: const Icon(Icons.palette),
          );
        });
  }
}