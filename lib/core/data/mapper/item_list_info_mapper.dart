
import 'package:hadith/core/data/local/views/hadith_info_list_view.dart';
import 'package:hadith/core/data/local/views/verse_info_list_view.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/item_list_info.dart';

extension HadithInfoListViewExt on HadithInfoListView{

  ItemListInfo toItemListInfo(){
    return ItemListInfo(
      itemId: hadithId,
      inAnyArchiveList: inAnyArchiveList,
      inAnyList: inAnyList,
      inFavorite: inFavorite,
      sourceType: SourceTypeEnum.hadith
    );
  }

}

extension VerseInfoListViewExt on VerseInfoListView{

  ItemListInfo toItemListInfo(){
    return ItemListInfo(
        itemId: verseId,
        inAnyArchiveList: inAnyArchiveList,
        inAnyList: inAnyList,
        inFavorite: inFavorite,
        sourceType: SourceTypeEnum.verse
    );
  }
}

