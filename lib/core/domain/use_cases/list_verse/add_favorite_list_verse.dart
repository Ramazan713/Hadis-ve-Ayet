

import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_hadith.dart';
import 'package:hadith/core/domain/models/list/list_model.dart';
import 'package:hadith/core/domain/models/list/list_verse.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_repo.dart';
import 'package:hadith/core/domain/repo/list/list_repo.dart';
import 'package:hadith/core/domain/repo/list/list_verse_repo.dart';

class AddFavoriteListVerse{
  late final ListRepo _listRepo;
  late final ListVerseRepo _listVerseRepo;

  AddFavoriteListVerse({required ListRepo listRepo, required ListVerseRepo listVerseRepo}){
    _listRepo = listRepo;
    _listVerseRepo = listVerseRepo;
  }

  Future<void> call(int verseId)async{
    final favList = await _listRepo.getFavoriteList(SourceTypeEnum.verse);
    if(favList == null){
      final listId = await _listRepo.insertList(
        const ListModel(
            name: "Favoriler",
            isRemovable: false,
            isArchive: false,
            id: null,
            sourceType: SourceTypeEnum.verse,
            pos: 1
        )
      );
      await _insertListVerse(listId, verseId);

    }else{
      final listVerse = await _listVerseRepo.getListVerse(verseId, favList.id??0);
      if(listVerse!=null){
        _listVerseRepo.deleteListVerse(listVerse);
      }else{
        await _insertListVerse(favList.id??0, verseId);
      }

    }
  }


  Future<void> _insertListVerse(int listId, int verseId) async{
    final maxPos = await _listVerseRepo.getMaxPos();
    await _listVerseRepo.insertListVerse(
        ListVerse(
          listId: listId,
          verseId: verseId,
          pos: maxPos + 1,
        )
    );
  }

}