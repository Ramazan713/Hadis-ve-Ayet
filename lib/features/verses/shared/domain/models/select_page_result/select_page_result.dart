

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'select_page_result.freezed.dart';

@freezed
class SelectPageResult with _$SelectPageResult{
  const factory SelectPageResult({
    required int pageNo,
    required int pagePos
  }) = _SelectPageResult;
}