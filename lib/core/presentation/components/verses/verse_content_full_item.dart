import 'package:flutter/material.dart';
import 'package:hadith/constants/enums/verse_arabic_ui_2x_enum.dart';
import 'package:hadith/core/domain/constants/k_verse.dart';
import 'package:hadith/core/domain/models/search_param.dart';
import 'package:hadith/core/domain/models/font_model.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _getVerseItemContent(context),
    );
  }



  List<Widget> _getVerseItemContent(BuildContext context){

    final fontWeight = verse.isProstrationVerse ? FontWeight.w500 : FontWeight.normal;

    final sharedTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontWeight: fontWeight,
      fontSize: fontModel.contentFontSize,
    );

    final contents = TextUtils.getSelectedText(
        verse.content,
        searchParam?.searchQuery,
        textStyle: sharedTextStyle,
        context: context,
        inheritTextStyle: true,
        searchCriteriaEnum: searchParam?.searchCriteria
    );

    final items=<Widget>[

      _getVerseItemMentionWidget(
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


  Widget _getVerseItemMentionWidget(Verse verse, TextStyle? sharedTextStyle) {
    var verseNum = int.parse(verse.verseNumber.split(",")[0]);

    if (verseNum == 1 && !KVerse.mentionExclusiveIds.contains(verse.surahId)) {

      if(arabicVerseUIEnum.arabicVisible){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ArabicContentItem(
            content: KVerse.mentionTextArabic,
            fontSize: fontModel.arabicFontSize - 5,
            fontFamily: fontModel.arabicFontFamilyEnum,
          ),
        );
      }

      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 19),
          child: Text(
            KVerse.mentionText,
            textAlign: TextAlign.start,
            style: sharedTextStyle?.copyWith(
                fontSize: (sharedTextStyle.fontSize??20) - 5
            ),
          ));
    }
    return const SizedBox(
      height: 0,
    );
  }
}
