


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/models/search_part/search_part.dart';
part 'search_content.freezed.dart';

@freezed
class SearchContent with _$SearchContent{
  const factory SearchContent({
    required String content,
    required String source,
    required List<SearchPart> searchParts,
  }) = _SearchContent;
}