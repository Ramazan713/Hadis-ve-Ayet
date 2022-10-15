import 'package:flutter/widgets.dart';
import 'package:hadith/constants/enums/search_criteria_enum.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:hadith/utils/search_helper.dart';

import '../../constants/preference_constants.dart';
import '../../dialogs/show_select_radio_enums.dart';
import '../../models/item_label_model.dart';

void showSelectSearchCriteria(BuildContext context,
    { SearchCriteriaEnum? currentValue,
     void Function(SearchCriteriaEnum)? callback}) {

  final criteria = currentValue?? SearchHelper.getCriteria();
  final currentModel = ItemLabelModel(item: criteria,label: criteria.getDescription());
  final sharedPreferences = LocalStorage.sharedPreferences;

  final List<ItemLabelModel<SearchCriteriaEnum>> radioItems=
  SearchCriteriaEnum.values.map((e) => ItemLabelModel(item: e,label:e.getDescription())).toList();

  showSelectRadioEnums<SearchCriteriaEnum>(context,
      currentValue: currentModel,
      radioItems: radioItems, closeListener: (lastSelected)async{
        await sharedPreferences.setInt(PrefConstants.searchCriteriaEnum.key, lastSelected.item.index);
        callback?.call(lastSelected.item);
      });
}
