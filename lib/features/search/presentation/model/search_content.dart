


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'search_content.freezed.dart';

@freezed
class SearchContent with _$SearchContent{
  const factory SearchContent({
    required String content,
    required String source
  }) = _SearchContent;
}