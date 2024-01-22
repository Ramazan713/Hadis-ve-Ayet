


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/verse_ui_4x_enum.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/preferences/model/pref_key_enum.dart';
import 'package:hadith/core/presentation/selections/show_select_check_box_dia.dart';

void showSelectVerseUi4X(BuildContext context, {
  void Function(VerseUi4XEnum)? callback,
  required PrefKeyEnum<VerseUi4XEnum> currentKPref
}) {


  final appPref = context.read<AppPreferences>();

  final criteria = appPref.getEnumItem(currentKPref);

  final currentSelectedItems = VerseUi4XEnumOption.fromVerseUi(criteria);

  showSelectCheckBoxDia(
      context,
      items: VerseUi4XEnumOption.values,
      selectedItems: currentSelectedItems,
      title: "Görünüm Seçin",
      onApprove: (selectedItems)async{
        final selectedCriteria = VerseUi4XEnumOption.toVerseUi(selectedItems);
        await appPref.setEnumItem(currentKPref, selectedCriteria);
        callback?.call(selectedCriteria);
      }
  );
}