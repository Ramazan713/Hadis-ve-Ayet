

import 'package:hadith/core/domain/models/item_list_info.dart';
import 'package:hadith/core/domain/models/paging/i_paging_item.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/core/domain/models/verse/verse_arabic.dart';

class VerseListModel with IPagingItem{
  final bool isInFavorite;
  final bool isInAnyList;
  final bool isInAnyArchiveList;
  final Verse verse;
  final List<VerseArabic> verseArabics;
  int _rowNumber = 0;

  VerseListModel({
    required this.isInFavorite,
    required this.isInAnyArchiveList,
    required this.isInAnyList,
    required this.verse,
    required this.verseArabics,
    required int rowNumber
  }){
    _rowNumber = rowNumber;
  }

  VerseListModel updateWith({
    required ItemListInfo itemListInfo,
    required bool useArchiveListFeatures,
  }){
    return VerseListModel(
        isInFavorite: itemListInfo.inFavorite,
        isInAnyList: itemListInfo.getInAnyListWithArchiveList(useArchiveListFeatures),
        rowNumber: _rowNumber,
        isInAnyArchiveList: itemListInfo.inAnyArchiveList,
        verse: verse,
        verseArabics: verseArabics
    );
  }

  @override
  int get pagingId => verse.id ?? 0;

  @override
  int get rowNumber => _rowNumber;

  @override
  set rowNumber(value) {
    _rowNumber = value;
  }

}