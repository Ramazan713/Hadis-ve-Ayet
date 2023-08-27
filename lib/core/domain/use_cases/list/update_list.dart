

import 'package:hadith/core/data/mapper/list/list_view_mapper.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/domain/repo/list/list_repo.dart';

class UpdateList{
  late final ListRepo _listRepo;
  UpdateList({required ListRepo listRepo}){
    _listRepo = listRepo;
  }

  Future<void> call({required ListViewModel listViewModel,String? name, bool? isArchive})async{
    final listMaxPos = await _listRepo.getMaxPosList();
    final updatedModel = listViewModel.toListModel().copyWith(name: name,isArchive: isArchive,pos: listMaxPos + 1);

    await _listRepo.updateList(updatedModel);
  }
}