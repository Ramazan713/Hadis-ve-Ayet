

import 'package:hadith/core/domain/models/list/list_hadith.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_repo.dart';

class AddListHadith{
  late final ListHadithRepo _listHadithRepo;

  AddListHadith({required ListHadithRepo listHadithRepo}){
    _listHadithRepo = listHadithRepo;
  }

  Future<void> call(ListViewModel listView, int hadithId)async{
    final listId = listView.id;
    final listHadith = await _listHadithRepo.getListHadith(hadithId, listId);
    if(listHadith!=null){
      _listHadithRepo.deleteListHadith(listHadith);
    }else{
      final pos = await _listHadithRepo.getMaxPos();
      await _listHadithRepo.insertListHadith(
        ListHadith(listId: listId, hadithId: hadithId, pos: pos + 1)
      );
    }
  }
}