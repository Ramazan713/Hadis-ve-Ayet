

import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_repo.dart';
import 'package:hadith/core/domain/repo/list/list_verse_repo.dart';

class DeleteItemsInList{
  late final ListHadithRepo _listHadithRepo;
  late final ListVerseRepo _listVerseRepo;

  DeleteItemsInList({required ListHadithRepo listHadithRepo, required ListVerseRepo listVerseRepo}){
    _listHadithRepo = listHadithRepo;
    _listVerseRepo = listVerseRepo;
  }

  Future<void> call(int listId, SourceTypeEnum sourceType) async{
    switch(sourceType){
      case SourceTypeEnum.hadith:
        final listHadiths = await _listHadithRepo.getListHadithsWithListId(listId);
        await _listHadithRepo.deleteListHadiths(listHadiths);
        break;
      case SourceTypeEnum.verse:
        final listVerses = await _listVerseRepo.getListVersesWithListId(listId);
        await _listVerseRepo.deleteListVerses(listVerses);
        break;
    }
  }

}