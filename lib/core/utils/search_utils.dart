

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/domain/models/search_part/search_part.dart';
import 'package:hadith/core/extensions/string_ext.dart';

class SearchUtils{

  static List<TextSpan> getSelectedTextWithParts(BuildContext context,{
    required List<SearchPart> parts,
    TextStyle? textStyle,
  }){
    final paint = Paint();
    paint.color = Theme.of(context).colorScheme.onSecondaryContainer;

    TextStyle searchStyle = TextStyle(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        foreground: paint
    );

    searchStyle = searchStyle.merge(textStyle?.copyWith(inherit: true));
    List<TextSpan> spans = [];

    for(final part in parts){
      final currentStyle = part.isSearchField ? searchStyle : textStyle;
      spans.add(
        TextSpan(
          text: part.text,
          style: currentStyle
        )
      );
    }
    return spans;
  }

  static List<SearchPart> getSearchParts({
    required String content,
    required SearchParam searchParam,
    bool caseSensitive = false,
  }){
    final result = <SearchPart>[];

    final RegExp reg = searchParam.searchCriteria.getRegex(query: searchParam.searchQuery,caseSensitive: caseSensitive);
    final matches = reg.allMatches(content);

    var firstIndex = 0;

    for(var matcher in matches){
      final start = matcher.start;
      final end = matcher.end;
      if(start == end) continue;
      if(firstIndex < start){
        result.add(
          SearchPart(
            text: content.substring(firstIndex,start),
            isSearchField: false
          )
        );
      }
      final text = content.substring(start,end);

      result.add(
        SearchPart(
          text: text,
          isSearchField: true
        )
      );
      firstIndex = end;
    }

    if(firstIndex < content.length){
      result.add(
        SearchPart(
          text: content.substring(firstIndex,content.length),
          isSearchField: false
        )
      );
    }
    return result;
  }

  static List<TextSpan> getOrDefaultSelectedTextWithParts(BuildContext context,{
    required String content,
    required List<SearchPart> parts,
    required SearchParam? searchParam,
    TextStyle? textStyle,
  }){
    if(searchParam == null || searchParam.searchQuery.isEmptyString){
      return [
        TextSpan(text: content,style: textStyle)
      ];
    }
    return getSelectedTextWithParts(context, parts: parts,textStyle: textStyle);
  }

  static List<TextSpan> getSelectedText(BuildContext context, {
    required String content,
    bool caseSensitive = false,
    TextStyle? textStyle,
    required SearchParam? searchParam,
  }){
    if(searchParam == null || searchParam.searchQuery.isEmptyString){
      return [
        TextSpan(text: content,style: textStyle)
      ];
    }

    final parts = getSearchParts(
        content: content,
        searchParam: searchParam,
        caseSensitive: caseSensitive
    );
    return getSelectedTextWithParts(context,
        parts: parts,
        textStyle: textStyle
    );
  }

}