

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/features/islamic_info/shared/domain/model/islamic_info_item.dart';
import 'package:hadith/features/islamic_info/shared/domain/model/islamic_info_title.dart';
part 'islamic_info_collection.freezed.dart';

@freezed
class IslamicInfoCollection with _$IslamicInfoCollection{
  const factory IslamicInfoCollection({
    required IslamicInfoTitle infoTitle,
    required List<IslamicInfoItem> infoItems
  }) = _IslamicInfoCollection;
}