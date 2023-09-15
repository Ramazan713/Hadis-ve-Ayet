import 'package:flutter/material.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/dialogs/show_select_check_enums.dart';
import 'package:hadith/dialogs/show_select_radio_enums.dart';
import 'package:hadith/models/item_label_model.dart';
import 'package:hadith/models/key_type_model.dart';
import 'package:hadith/utils/localstorage.dart';

import '../core/domain/enums/verse_arabic_ui_2x_enum.dart';

void showSelectVerseUi2X(BuildContext context, {
      ArabicVerseUI2X? currentValue,
      void Function(ArabicVerseUI2X)? callback,
      KeyTypeModel<dynamic>? prefKeyType
    })
{

  final keyType = prefKeyType??PrefConstants.arabicVerseAppearanceEnum;
  final sharedPreferences = LocalStorage.sharedPreferences;

  final criteria = currentValue ??
      ArabicVerseUI2X.values[sharedPreferences.getInt(keyType.key) ?? keyType.defaultValue];

  showSelectRadioEnums<ArabicVerseUI2X>(context,
      currentValue: ItemLabelModel(item: criteria, label: criteria.description),
      radioItems: ArabicVerseUI2X.values.map((e) => ItemLabelModel(item: e, label: e.description)).toList(),
      closeListener: (selected)async{
        await sharedPreferences.setInt(keyType.key, selected.item.index);
        callback?.call(selected.item);
      }
  );
}
