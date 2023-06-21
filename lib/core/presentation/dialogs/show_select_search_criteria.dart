

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/core/domain/constants/k_pref.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/preferences/app_preferences.dart';
import 'package:hadith/core/domain/preferences/model/pref_key_enum.dart';
import 'package:hadith/dialogs/show_select_radio_enums.dart';
import 'package:hadith/models/item_label_model.dart';

void showSelectSearchCriteria(
    BuildContext context,
    {
      void Function(SearchCriteriaEnum)? callback,
      PrefKeyEnum<SearchCriteriaEnum>? pref
    }
) {

  final currentKPref = pref ?? KPref.searchCriteriaEnum;
  final appPref = context.read<AppPreferences>();

  final criteria = appPref.getEnumItem(currentKPref);

  showSelectRadioEnums<SearchCriteriaEnum>(context,
      currentValue: ItemLabelModel(item: criteria, label: criteria.description),
      radioItems: SearchCriteriaEnum.values.map((e) => ItemLabelModel(item: e, label: e.description)).toList(),
      closeListener: (selected)async{
        await appPref.setEnumItem(currentKPref, selected.item);
        callback?.call(selected.item);
      }
  );
}