import 'package:flutter/material.dart';
import 'package:hadith/core/domain/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/domain/constants/k_verse.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/domain/models/font_model/font_model.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
import 'package:hadith/core/utils/search_utils.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/verse_item/verse_arabic_content_item.dart';
import 'package:hadith/utils/text_utils.dart';

import 'arabic_content_item.dart';


class VerseContentFullItem extends StatelessWidget {

  final VerseListModel verseListModel;
  final ArabicVerseUI2X arabicVerseUIEnum;
  final FontModel fontModel;
  final SearchParam? searchParam;


  const VerseContentFullItem({
    Key? key,
    required this.verseListModel,
    required this.arabicVerseUIEnum,
    required this.fontModel,
    this.searchParam
  }) : super(key: key);

  Verse get verse => verseListModel.verse;

  FontWeight get fontWeight => verse.isProstrationVerse ? FontWeight.w500 : FontWeight.normal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _getVerseItemContent(context),
    );
  }



  List<Widget> _getVerseItemContent(BuildContext context){

    final fontWeight = verse.isProstrationVerse ? FontWeight.w500 : FontWeight.normal;

    final sharedTextStyle = getSharedTextStyle(context);

    final contents = SearchUtils.getSelectedText(
        context,
        content: verse.content,
        searchParam: searchParam,
        textStyle: sharedTextStyle,
    );

    final items=<Widget>[
      _getVerseItemMentionWidget(
        context,
        verseListModel.verse,
        sharedTextStyle
      ),
      const SizedBox(height: 7,),
    ];

    if(arabicVerseUIEnum.arabicVisible){
      items.add(
          VerseArabicContentItem(
            verseArabics: verseListModel.verseArabics,
            fontSize: fontModel.arabicFontSize,
            fontFamily: fontModel.arabicFontFamilyEnum,
            fontWeight: fontWeight,
          )
      );
      items.add(const SizedBox(height: 17,));
    }

    if(arabicVerseUIEnum.mealVisible){
      items.add(
          RichText(
            text: TextSpan(
                text: "${verse.verseNumber} - ",
                children: contents,
                style: sharedTextStyle
            )
          )
      );
    }
    return items;
  }


  Widget _getVerseItemMentionWidget(BuildContext context,Verse verse, TextStyle? sharedTextStyle) {
    var verseNum = int.parse(verse.verseNumber.split(",")[0]);

    if (verseNum == 1) {

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4,bottom: 12),
            child: Text(
              "${verse.surahName} Suresi",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: fontModel.contentFontSize + 3
              ),
              textAlign: TextAlign.center,
            ),
          ),
          getMentionContent(context, verse)
        ],
      );
    }
    return const SizedBox(
      height: 0,
    );
  }

  Widget getMentionContent(BuildContext context, Verse verse){

    if(KVerse.mentionExclusiveIds.contains(verse.surahId)){
      return const SizedBox();
    }

    if(arabicVerseUIEnum.arabicVisible){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ArabicContentItem(
          content: KVerse.mentionTextArabic,
          fontSize: fontModel.arabicFontSize - 3,
          fontFamily: fontModel.arabicFontFamilyEnum,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 19),
      child: Text(
        KVerse.mentionText,
        textAlign: TextAlign.start,
        style: getSharedTextStyle(context)?.copyWith(
           fontSize: (getSharedTextStyle(context)?.fontSize??20) - 3
        ),
      ));
  }

  TextStyle? getSharedTextStyle(BuildContext context){
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: fontWeight,
      fontSize: fontModel.contentFontSize,
    );
  }

}
