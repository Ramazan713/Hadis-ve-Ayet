

import 'package:flutter/material.dart';
import 'package:hadith/utils/search_helper.dart';
import 'package:hadith/utils/theme_util.dart';


import '../constants/enums/search_criteria_enum.dart';

class TextUtils{
  static List<TextSpan>getSelectedText(String fullText,String? searchKey,
  {bool caseSensitive=false,TextStyle? textStyle,required BuildContext context,
    bool inheritTextStyle=false,required SearchCriteriaEnum? searchCriteriaEnum}){

    if(searchKey == null || searchCriteriaEnum == null){
      return [TextSpan(text: fullText,style: textStyle)];
    }

    List<TextSpan>spans=[];

    TextStyle searchStyle=TextStyle(
        backgroundColor: ThemeUtil.getThemeModel(context).selectedTextColor()
    );

    if(inheritTextStyle&&textStyle!=null){
      searchStyle=searchStyle.merge(textStyle);
    }
    final RegExp reg = SearchHelper.findWordsPattern(searchKey, caseSensitive);

    var firstIndex=0;
    for(var matcher in reg.allMatches(fullText)){
      if(firstIndex<matcher.start){
        spans.add(TextSpan(text: fullText.substring(firstIndex,matcher.start),style: textStyle));
      }
      final text=fullText.substring(matcher.start,matcher.end);
      spans.add(TextSpan(text: text,style: searchStyle));
      firstIndex=matcher.end;
    }

    if(firstIndex<fullText.length){
      spans.add(TextSpan(text: fullText.substring(firstIndex,fullText.length),style: textStyle));
    }

    return spans;
  }
}