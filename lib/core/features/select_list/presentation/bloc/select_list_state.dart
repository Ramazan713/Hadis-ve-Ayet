

import 'package:equatable/equatable.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/selectable_list_view_model.dart';


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'select_list_state.freezed.dart';

@freezed
class SelectListState with _$SelectListState{
  const factory SelectListState({
    required List<SelectableListViewModel> items,
    required int itemId,
    required SourceTypeEnum sourceType,
    int? listIdControl,
    String? message,
    bool? listAffected
  }) = _SelectListState;

  static SelectListState init(){
    return const SelectListState(
      items: [],
      sourceType: SourceTypeEnum.hadith,
      itemId: 0,
    );
  }
}
