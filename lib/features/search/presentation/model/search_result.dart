
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/features/search/presentation/model/search_content.dart';
part 'search_result.freezed.dart';

@freezed
class SearchResult with _$SearchResult{
  const factory SearchResult({
    required String title,
    required List<SearchContent> searchContents,
    required int resultCount,
    required BookScopeEnum bookScope,
  }) = _SearchResult;
}
