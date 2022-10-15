import 'package:flutter/material.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_enum.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/dialogs/show_select_radio_enums.dart';
import 'package:hadith/models/item_label_model.dart';
import 'package:hadith/utils/localstorage.dart';

void showSelectVerseUi(BuildContext context,
    {ArabicVerseUIEnum? currentValue,
    void Function(ArabicVerseUIEnum)? callback}) {
  final sharedPreferences = LocalStorage.sharedPreferences;
  final criteria = currentValue ??
      ArabicVerseUIEnum.values[sharedPreferences
              .getInt(PrefConstants.arabicVerseAppearanceEnum.key) ??
          PrefConstants.arabicVerseAppearanceEnum.defaultValue];
  final currentItem =
      ItemLabelModel(item: criteria, label: criteria.description);
  final radioItems = ArabicVerseUIEnum.values
      .map((e) => ItemLabelModel(item: e, label: e.description))
      .toList();

  showSelectRadioEnums<ArabicVerseUIEnum>(context,
      currentValue: currentItem,
      radioItems: radioItems, closeListener: (lastSelected) async {
    if (lastSelected.item != criteria) {
      await sharedPreferences.setInt(
          PrefConstants.arabicVerseAppearanceEnum.key, lastSelected.item.index);
      callback?.call(lastSelected.item);
    }
  });
}
