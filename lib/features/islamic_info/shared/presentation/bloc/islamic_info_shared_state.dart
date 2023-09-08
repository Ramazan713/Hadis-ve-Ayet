


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/domain/enums/islamic_info_type.dart';
import 'package:hadith/features/islamic_info/shared/domain/model/islamic_info_collection.dart';
part 'islamic_info_shared_state.freezed.dart';

@freezed
class IslamicInfoSharedState with _$IslamicInfoSharedState{
  const factory IslamicInfoSharedState({
    required List<IslamicInfoCollection> items,
    required IslamicInfoType infoType,
    required bool isLoading,
    required FontModel fontModel
  }) = _IslamicInfoSharedState;

  static IslamicInfoSharedState init(){
    return IslamicInfoSharedState(
      items: [],
      isLoading: false,
      infoType: IslamicInfoType.none,
      fontModel: FontModel.init()
    );
  }

}