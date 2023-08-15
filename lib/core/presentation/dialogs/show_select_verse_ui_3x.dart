import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/preferences/model/pref_key_enum.dart';
import 'package:hadith/dialogs/show_select_check_enums.dart';
import 'package:hadith/models/item_label_model.dart';


void showSelectVerseUi3X(BuildContext context, {
  void Function(ArabicVerseUI3X)? callback,
  required PrefKeyEnum<ArabicVerseUI3X> currentKPref
}) {


  final appPref = context.read<AppPreferences>();

  final criteria = appPref.getEnumItem(currentKPref);

  final currentSelectedItems = ArabicVerseUI3XOption.fromVerseUiEnum(criteria);

  final options = ArabicVerseUI3XOption.values.map((e){
    return ItemLabelModel(item: e, label: e.description);
  }).toList();

  final selectedItemsParam = currentSelectedItems.map((e){
    return ItemLabelModel(item: e, label: e.description);
  }).toList();

  showSelectCheckEnums<ArabicVerseUI3XOption>(context,
      optionItems: options,
      selectedItemsParam: selectedItemsParam,
      closeListener: (lastItems)async{
        final selectedCriteria = ArabicVerseUI3XOption.toVerseUiEnum(
            lastItems.map((e) => e.item).toList()
        );
        await appPref.setEnumItem(currentKPref, selectedCriteria);
        callback?.call(selectedCriteria);
      }
  );
}
