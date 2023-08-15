

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'islamic_info_item.freezed.dart';

@freezed
class IslamicInfoItem with _$IslamicInfoItem{
  const factory IslamicInfoItem({
    required int titleId,
    int? id,
    String? name,
    String? description
  }) = _IslamicInfoItem;
}