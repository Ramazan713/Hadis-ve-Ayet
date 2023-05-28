

import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_hadith.dart';
import 'package:hadith/core/domain/models/list/list_model.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_repo.dart';
import 'package:hadith/core/domain/repo/list/list_repo.dart';

class AddFavoriteListHadith{
  late final ListRepo _listRepo;
  late final ListHadithRepo _listHadithRepo;

  AddFavoriteListHadith({required ListRepo listRepo, required ListHadithRepo listHadithRepo}){
    _listRepo = listRepo;
    _listHadithRepo = listHadithRepo;
  }

  Future<void> call(int hadithId)async{
    final favList = await _listRepo.getFavoriteList(SourceTypeEnum.hadith);

    if(favList == null){
      final listId = await _listRepo.insertList(
        const ListModel(
            name: "Favoriler",
            isRemovable: false,
            isArchive: false,
            id: null,
            sourceType: SourceTypeEnum.hadith,
            pos: 1
        )
      );
      await _insertListHadith(listId, hadithId);
    }else{
      final listHadith = await _listHadithRepo.getListHadith(hadithId, favList.id??0);
      if(listHadith!=null){
        _listHadithRepo.deleteListHadith(listHadith);
      }else{
        await _insertListHadith(favList.id??0, hadithId);
      }

    }
  }


  Future<void> _insertListHadith(int listId, int hadithId) async{
    final maxPos = await _listHadithRepo.getMaxPos();
    print("_insertListHadith: ${maxPos}: $listId : $hadithId");

    await _listHadithRepo.insertListHadith(
        ListHadith(
          listId: listId,
          hadithId: hadithId,
          pos: maxPos + 1,
        )
    );
  }

}