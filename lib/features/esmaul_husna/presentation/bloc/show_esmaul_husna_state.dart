
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/features/esmaul_husna/domain/models/esmaul_husna.dart';
part 'show_esmaul_husna_state.freezed.dart';

@freezed
class ShowEsmaulHusnaState with _$ShowEsmaulHusnaState{
  const ShowEsmaulHusnaState._();

  const factory ShowEsmaulHusnaState({
    required bool isDetailOpen,
    required List<EsmaulHusna> items,
    required bool isLoading,
    required FontModel fontModel,
    required String searchQuery,
    required SearchCriteriaEnum searchCriteria,
    required bool isSearchBarVisible,
    EsmaulHusna? selectedItem,
    int? jumpToPos,
    String? message,
  }) = _ShowEsmaulHusnaState;

  static ShowEsmaulHusnaState init(){
    return ShowEsmaulHusnaState(
      fontModel: FontModel.init(),
      isDetailOpen: false,
      items: [],
      isLoading: false,
      isSearchBarVisible: false,
      searchQuery: "",
      searchCriteria: SearchCriteriaEnum.defaultValue,
    );
  }

  SearchParam get searchParam => SearchParam(
      searchCriteria: searchCriteria,
      searchQuery: searchQuery
  );

}