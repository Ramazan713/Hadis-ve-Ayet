

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'search_part.freezed.dart';

@freezed
class SearchPart with _$SearchPart{
  const factory SearchPart({
    required String text,
    required bool isSearchField
  }) = _SearchPart;
}