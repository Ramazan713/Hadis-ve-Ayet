


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/features/esmaul_husna/shared/domain/esmaul_husna.dart';
part 'detail_esmaul_husna_state.freezed.dart';

@freezed
class DetailEsmaulHusnaState with _$DetailEsmaulHusnaState{
  const factory DetailEsmaulHusnaState({
    required List<EsmaulHusna> items,
    required bool isLoading,
    required FontModel fontModel,
    EsmaulHusna? currentItem,
    String? message,
  }) = _DetailEsmaulHusnaState;

  static DetailEsmaulHusnaState init(){
    return DetailEsmaulHusnaState(
      isLoading: false,
      items: [],
      fontModel: FontModel.init(),
    );
  }

}