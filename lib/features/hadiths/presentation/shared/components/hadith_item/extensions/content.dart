

import 'package:hadith/constants/app_constants.dart';
import 'package:hadith/core/utils/search_utils.dart';
import 'package:hadith/utils/text_utils.dart';

import '../hadith_item.dart';
import 'package:flutter/material.dart';

extension HadithItemContentExt on HadithItem{

  Widget getContentBody(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _getContentWidget(context),

        const SizedBox(
          height: 13,
        ),

        Text("- ${hadithList.hadith.source}",
            textAlign: TextAlign.center,
            style: getTextStyle(context)?.copyWith(fontSize: fontSize - 4)
        ),
      ],
    );
  }


  Widget _getContentWidget(BuildContext context){

    return ValueListenableBuilder<bool>(
        valueListenable: showContinue,
        builder: (context,showContinue,child){
          return RichText(
            text: TextSpan(
              children: _getContentChildren(context,showContinue),
            ),
            textAlign: TextAlign.center,
          );
        }
    );
  }

  List<TextSpan> _getContentChildren(BuildContext context, bool showContinue){
    final content = !showContinue && isContentLarge
        ? hadith.content.substring(0, kMaxContentSize)
        : hadith.content;

    final widgets = SearchUtils.getSelectedText(
        context,
        content: content,
        searchParam: searchParam,
        textStyle: getTextStyle(context),
    );

    if (!showContinue && isContentLarge) {
      widgets.add(_getContinueWidget(context));
    }
    return widgets;
  }

  TextSpan _getContinueWidget(BuildContext context){
    return TextSpan(children: [
      WidgetSpan(
          child: InkWell(
            child: Text(
              "  ... devamını göster",
              style: getTextStyle(context)?.copyWith(
                  fontWeight: FontWeight.w500, fontSize: fontSize - 2),
            ),
            onTap: () {
              showContinue.value = true;
            },
          )),
    ]);
  }

}