import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/preferences/model/pref_key_enum.dart';
import 'package:hadith/dialogs/show_select_radio_enums.dart';
import 'package:hadith/models/item_label_model.dart';

void showSelectVerseUi2X(BuildContext context, {
  void Function(ArabicVerseUI2X)? callback,
  PrefKeyEnum<ArabicVerseUI2X>? pref
})
{

  final currentKPref = pref ?? KPref.verseAppearanceEnum;
  final appPref = context.read<AppPreferences>();

  final criteria = appPref.getEnumItem(currentKPref);

  showSelectRadioEnums<ArabicVerseUI2X>(context,
      currentValue: ItemLabelModel(item: criteria, label: criteria.description),
      radioItems: ArabicVerseUI2X.values.map((e) => ItemLabelModel(item: e, label: e.description)).toList(),
      closeListener: (selected)async{
        await appPref.setEnumItem(currentKPref, selected.item);
        callback?.call(selected.item);
      }
  );
}