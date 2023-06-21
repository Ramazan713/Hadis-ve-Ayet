import 'package:hadith/core/presentation/components/verses/verse_content_full_item.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/components/verse_item/verse_item.dart';
import 'package:flutter/material.dart';


extension VerseItemContentExt on VerseItem{


  Widget getContent(BuildContext context){
    return Padding(
        padding: const EdgeInsets.only(top: 7, bottom: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            VerseContentFullItem(
                verseListModel: verseListModel,
                arabicVerseUIEnum: arabicVerseUIEnum,
                fontModel: fontModel,
                searchParam: searchParam,
            )
          ],
        )
    );
  }
}