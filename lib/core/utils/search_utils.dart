

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/utils/theme_util.dart';

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

    TextStyle searchStyle= TextStyle(
        backgroundColor: ThemeUtil.getThemeModel(context).selectedTextColor()
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