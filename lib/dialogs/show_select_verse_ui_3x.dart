import 'package:flutter/material.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/dialogs/show_select_check_enums.dart';
import 'package:hadith/dialogs/show_select_radio_enums.dart';
import 'package:hadith/models/item_label_model.dart';
import 'package:hadith/models/key_type_model.dart';
import 'package:hadith/utils/localstorage.dart';

void showSelectVerseUi3X(BuildContext context,
    {ArabicVerseUI3X? currentValue,
    void Function(ArabicVerseUI3X)? callback,
      KeyTypeModel<dynamic>? prefKeyType
    }) {

  final keyType = prefKeyType??PrefConstants.arabicVerseAppearanceEnum;

  final sharedPreferences = LocalStorage.sharedPreferences;

  final criteria = currentValue ??
      ArabicVerseUI3X.values[sharedPreferences.getInt(keyType.key) ?? keyType.defaultValue];

  final currentSelectedItems = ArabicVerseOptionExt.fromVerseUiEnum(criteria);

  final options = ArabicVerseOption3XEnum.values.map((e){
    return ItemLabelModel(item: e, label: e.description);
  }).toList();

  final selectedItemsParam = currentSelectedItems.map((e){
    return ItemLabelModel(item: e, label: e.description);
  }).toList();

  showSelectCheckEnums<ArabicVerseOption3XEnum>(context,
      optionItems: options,
      selectedItemsParam: selectedItemsParam,
      closeListener: (lastItems)async{

        final selectedCriteria = ArabicVerseOptionExt.toVerseUiEnum(
            lastItems.map((e) => e.item).toList()
        );
        await sharedPreferences.setInt(keyType.key, selectedCriteria.index);
        callback?.call(selectedCriteria);
      }
  );
}
