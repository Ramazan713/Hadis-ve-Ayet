

import 'package:hadith/core/domain/models/list/list_verse.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/domain/repo/list/list_verse_repo.dart';

class AddListVerse{
  late final ListVerseRepo _listVerseRepo;

  AddListVerse({ required ListVerseRepo listVerseRepo}){
    _listVerseRepo = listVerseRepo;
  }


  Future<void> call(ListViewModel listView, int verseId)async{
    final listId = listView.id;
    final listVerse = await _listVerseRepo.getListVerse(verseId, listId);
    if(listVerse!=null){
      _listVerseRepo.deleteListVerse(listVerse);
    }else{
      final pos = await _listVerseRepo.getMaxPos();
      await _listVerseRepo.insertListVerse(
          ListVerse(listId: listId, verseId: verseId, pos: pos + 1)
      );
    }
  }

}