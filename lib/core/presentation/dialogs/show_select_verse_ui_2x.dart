import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/preferences/model/pref_key_enum.dart';
import 'package:hadith/core/presentation/dialogs/show_select_radio_dia.dart';

void showSelectVerseUi2X(BuildContext context, {
  void Function(ArabicVerseUI2X)? callback,
  PrefKeyEnum<ArabicVerseUI2X>? pref
}){

  final currentKPref = pref ?? KPref.verseAppearanceEnum;
  final appPref = context.read<AppPreferences>();

  final criteria = appPref.getEnumItem(currentKPref);

  showSelectRadioDia(
    context,
    items: ArabicVerseUI2X.values,
    currentItem: criteria,
    title: "Görünüm Seçin",
    iconData: Icons.view_agenda,
    onSelected: (selected)async{
      await appPref.setEnumItem(currentKPref, selected);
      callback?.call(selected);
    }
  );
}