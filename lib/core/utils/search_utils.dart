

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/search_param.dart';

class SearchUtils{

  static List<TextSpan> getSelectedText(
      BuildContext context,
      {
        required String content,
        bool caseSensitive=false,
        TextStyle? textStyle,
        required SearchParam? searchParam,
      }
  ){

    if(searchParam == null){
      return [
        TextSpan(text: content,style: textStyle)
      ];
    }

    List<TextSpan>spans = [];

    final paint = Paint();
    paint.color = Theme.of(context).colorScheme.onSecondaryContainer;

    TextStyle searchStyle= TextStyle(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      foreground: paint
    );

    searchStyle = searchStyle.merge(textStyle?.copyWith(inherit: true));


    final RegExp reg = searchParam.searchCriteria.getRegex(query: searchParam.searchQuery,caseSensitive: caseSensitive);

    var firstIndex=0;
    for(var matcher in reg.allMatches(content)){
      if(firstIndex < matcher.start){
        spans.add(
            TextSpan(
                text: content.substring(firstIndex,matcher.start),
                style: textStyle
            )
        );
      }
      final text = content.substring(matcher.start,matcher.end);

      spans.add(
          TextSpan(
              text: text,
              style: searchStyle
          )
      );
      firstIndex = matcher.end;
    }

    if(firstIndex < content.length){
      spans.add(
          TextSpan(
              text: content.substring(firstIndex,content.length),
              style: textStyle
          )
      );
    }

    return spans;
  }
}