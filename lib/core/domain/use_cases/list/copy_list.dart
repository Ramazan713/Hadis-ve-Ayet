

import 'package:hadith/core/data/mapper/list/list_view_mapper.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_repo.dart';
import 'package:hadith/core/domain/repo/list/list_repo.dart';
import 'package:hadith/core/domain/repo/list/list_verse_repo.dart';

class CopyList{

  late final ListRepo _listRepo;
  late final ListVerseRepo _listVerseRepo;
  late final ListHadithRepo _listHadithRepo;

  CopyList({
    required ListRepo listRepo,
    required ListVerseRepo listVerseRepo,
    required ListHadithRepo listHadithRepo
  }){
    _listRepo = listRepo;
    _listVerseRepo = listVerseRepo;
    _listHadithRepo = listHadithRepo;
  }

  Future<void> call(ListViewModel listViewModel)async{
   final maxPos = await _listRepo.getMaxPosListWithSourceType(listViewModel.sourceType);

   final copyModel = listViewModel.toListModel().copyWith(
     id: null, setId: true,
     name: "${listViewModel.name} - Kopya",
     isRemovable: true,
     pos: maxPos + 1
   );

   final copyListId = await _listRepo.insertList(copyModel);

   switch(listViewModel.sourceType){
     case SourceTypeEnum.verse:

       final listVerses = await _listVerseRepo.getListVersesWithListId(listViewModel.id);
       final newListVerses = listVerses.map((e) => e.copyWith(listId: copyListId)).toList();
       await _listVerseRepo.insertListVerses(newListVerses);
       break;

     case SourceTypeEnum.hadith:

       final listHadiths = await _listHadithRepo.getListHadithsWithListId(listViewModel.id);
       final newListVerses = listHadiths.map((e) => e.copyWith(listId: copyListId)).toList();
       await _listHadithRepo.insertListHadiths(newListVerses);
       break;
   }

  }
}