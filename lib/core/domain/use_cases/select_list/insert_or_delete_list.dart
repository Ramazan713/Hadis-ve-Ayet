
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_hadith.dart';
import 'package:hadith/core/domain/models/list/list_verse.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_repo.dart';
import 'package:hadith/core/domain/repo/list/list_verse_repo.dart';

class InsertOrDeleteListItem{

  late final ListHadithRepo _listHadithRepo;
  late final ListVerseRepo _listVerseRepo;

  InsertOrDeleteListItem({
    required ListHadithRepo listHadithRepo,
    required ListVerseRepo listVerseRepo
  }){
    _listHadithRepo = listHadithRepo;
    _listVerseRepo = listVerseRepo;
  }


  Future<void> call({required int itemId, required int listId, required SourceTypeEnum sourceType})async{
    switch(sourceType){
      case SourceTypeEnum.hadith:
        await _insertOrDeleteHadithList(hadithId: itemId, listId: listId);
        break;
      case SourceTypeEnum.verse:
        await _insertOrDeleteVerseList(verseId: itemId, listId: listId);
        break;
    }
  }

  Future<void> _insertOrDeleteHadithList({required int hadithId, required int listId})async{
    final listHadith = await _listHadithRepo.getListHadith(hadithId, listId);
    if(listHadith!=null){
      await _listHadithRepo.deleteListHadith(listHadith);
    }else{
      final maxPos = await _listHadithRepo.getMaxPos();
      final listHadith = ListHadith(listId: listId, hadithId: hadithId, pos: maxPos + 1);
      await _listHadithRepo.insertListHadith(listHadith);
    }
  }

  Future<void> _insertOrDeleteVerseList({required int verseId, required int listId})async{
    final listVerse = await _listVerseRepo.getListVerse(verseId, listId);
    if(listVerse!=null){
      await _listVerseRepo.deleteListVerse(listVerse);
    }else{
      final maxPos = await _listVerseRepo.getMaxPos();
      final listVerse = ListVerse(listId: listId, verseId: verseId, pos: maxPos + 1);
      await _listVerseRepo.insertListVerse(listVerse);
    }
  }
}