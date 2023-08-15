

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/enums/islamic_info_type.dart';
part 'islamic_info_title.freezed.dart';

@freezed
class IslamicInfoTitle with _$IslamicInfoTitle{
  const factory IslamicInfoTitle({
    required String title,
    required IslamicInfoType type,
    int? id,
    String? description
  }) = _IslamicInfoTitle;
}
