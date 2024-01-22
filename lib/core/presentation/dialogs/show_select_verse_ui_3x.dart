import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/preferences/model/pref_key_enum.dart';
import 'package:hadith/core/presentation/selections/show_select_check_box_dia.dart';


void showSelectVerseUi3X(BuildContext context, {
  void Function(ArabicVerseUI3X)? callback,
  required PrefKeyEnum<ArabicVerseUI3X> currentKPref
}) {


  final appPref = context.read<AppPreferences>();

  final criteria = appPref.getEnumItem(currentKPref);

  final currentSelectedItems = ArabicVerseUI3XOption.fromVerseUiEnum(criteria);

  showSelectCheckBoxDia(
    context,
    items: ArabicVerseUI3XOption.values,
    selectedItems: currentSelectedItems,
    title: "Görünüm Seçin",
    onApprove: (selectedItems)async{
      final selectedCriteria = ArabicVerseUI3XOption.toVerseUiEnum(selectedItems);
      await appPref.setEnumItem(currentKPref, selectedCriteria);
      callback?.call(selectedCriteria);
    }
  );
}
