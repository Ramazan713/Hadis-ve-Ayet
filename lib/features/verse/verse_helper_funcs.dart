import 'package:flutter/material.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_3x_enum.dart';
import 'package:hadith/constants/verse_constant.dart';
import 'package:hadith/db/entities/verse.dart';
import 'package:hadith/db/entities/verse_arabic.dart';
import 'package:hadith/dialogs/show_info_bottom_dia.dart';

import 'common_models/verse_model.dart';


List<Widget> getVerseItemContent(List<TextSpan> content,VerseModel verseModel,double fontSize
    ,TextStyle? contentTextStyle,ArabicVerseUI2X arabicVerseUIEnum){
  final contents=<Widget>[
    getVerseItemMentionWidget(verseModel.item,fontSize,contentTextStyle),
    const SizedBox(height: 7,),
  ];
  final showTurkishVerseNum = arabicVerseUIEnum == ArabicVerseUI3X.arabic;

  if(arabicVerseUIEnum.arabicVisible){
    contents.add(getArabicVerseWidgetWithVerseModel(verseModel,fontSize,contentTextStyle
        ,showTurkishVerseNum));
    contents.add(const SizedBox(height: 17,));
  }

  if(arabicVerseUIEnum.mealVisible){
    contents.add( RichText(
        text: TextSpan(
            text: "${verseModel.item.verseNumber} - ",
            children: content,
            style: contentTextStyle)));
  }
  return contents;
}


Widget getVerseItemInfoWidget(BuildContext context,Verse verse,double fontSize) {
  return verse.isProstrationVerse
      ? IconButton(
      onPressed: () {
        showInfoBottomDia(context,
            title: "Uyarı", content: "Koyu renkli alan secde ayetidir");
      },
      icon: Icon(Icons.info, size: fontSize + 5))
      : const SizedBox(height: 0,);
}

Widget getVerseItemMentionWidget(Verse verse,double fontSize,TextStyle? contentTextStyle) {
  var verseNum = int.parse(verse.verseNumber.split(",")[0]);
  if (verseNum == 1 &&
      !VerseConstant.mentionExclusiveIds.contains(verse.surahId)) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 19),
        child: Text(
          VerseConstant.mentionText,
          textAlign: TextAlign.start,
          style: contentTextStyle?.copyWith(
              fontSize:fontSize-3
          ),
        ));
  }
  return const SizedBox(
    height: 0,
  );
}


TextSpan getArabicTextSpan(String content,double fontSize,
    {String fontFamily = "ScheherazadeNew",int height = 2,TextStyle? style}){

  final textStyle = style ?? const TextStyle();

  return TextSpan(
    text: content,
    style: textStyle.copyWith(
        fontFamily: "ScheherazadeNew",
        fontSize: fontSize+13,
        height: 2.0
    )
  );
}


Widget getArabicContentWidget(String content,double fontSize,
    {String fontFamily = "ScheherazadeNew",double height = 2,TextStyle? style,TextAlign?textAlign}){
  final textStyle = style ?? const TextStyle();
  return Text(content,
      textAlign: textAlign,
      style: textStyle.copyWith(
          fontFamily: "ScheherazadeNew",
          fontSize: fontSize+13,
          height: height,

      )
  );
}

Widget getArabicRichWidget(String content,double fontSize,
    {String fontFamily = "ScheherazadeNew",int height = 2,TextStyle? style}){
  return RichText(
    text: getArabicTextSpan(content, fontSize,fontFamily: fontFamily,height: height,style: style),
    textDirection: TextDirection.rtl,);
}


Widget getArabicVerseWidgetWithVerseModel(VerseModel verseModel,double fontSize,TextStyle? contentTextStyle,
    bool showTurkishVerseNum){
  final children=<InlineSpan>[];
  final verseStopImg=Image.asset("assets/images/verse_stop.png",width: fontSize+7,height: fontSize+3);

  if(showTurkishVerseNum){
    children.add(TextSpan(text: "${verseModel.item.verseNumber} - ",style: contentTextStyle?.copyWith(
        fontSize: fontSize+2
    )));
  }
  for(var arabicVerse in verseModel.arabicVerses){
    children.add(TextSpan(
      style: TextStyle(fontSize: fontSize+5),
      children: [
        getArabicTextSpan(arabicVerse.verse,fontSize,style: contentTextStyle),
        WidgetSpan(child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(width: fontSize+13,),
            verseStopImg,
            Text(arabicVerse.verseNumber,)
          ],
        )),
      ],
    ));
  }
  return RichText(text: TextSpan(children: children),textDirection: TextDirection.rtl,);
}