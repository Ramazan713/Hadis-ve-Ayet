

import 'package:flutter/material.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/features/verses/show_verse/presentation/shared/show_verse_info_dia.dart';
import '../verse_item.dart';

extension VerseItemHeaderExt on VerseItem{

  Widget getHeader(BuildContext context){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _getSurahInfo(context),
        _getRowNumber(context),
        _getPageNumAndInfo(context),
      ],
    );
  }


  Widget _getSurahInfo(BuildContext context){
    return Expanded(
      child: Text(
        "${verse.surahId}/${verse.surahName}",
        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: smallFontValue),
      ),
    );
  }

  Widget _getRowNumber(BuildContext context){
    return Expanded(
        child: Text(
          "${verseListModel.rowNumber}",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(fontSize: smallFontValue)
        )
    );
  }

  Widget _getPageNumAndInfo(BuildContext context){
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _getVerseItemInfoWidget(context, verse),
          const SizedBox(width: 7,),
          Text(
            "${verse.pageNo}",
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(fontSize: smallFontValue)
          )
        ],
      ),
    );
  }

  Widget _getVerseItemInfoWidget(BuildContext context,Verse verse) {
    if(!verse.isProstrationVerse) return const SizedBox(height: 0,);
    return IconButton(
      alignment: Alignment.center,
      onPressed: () {
        showVerseInfoDia(
            context,
            title: "Uyarı",
            content: "Koyu renkli alan secde ayetidir"
        );
      },
      icon: Icon(Icons.info, size: fontModel.contentFontSize + 5)
    );
  }
}