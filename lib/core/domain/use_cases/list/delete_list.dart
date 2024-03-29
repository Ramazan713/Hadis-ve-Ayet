

import 'package:hadith/core/data/mapper/list/list_view_mapper.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/domain/repo/list/list_repo.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_type.dart';
import 'package:hadith/core/features/save_point/domain/repo/save_point_repo.dart';

class DeleteList{

  late final ListRepo _listRepo;
  late final SavePointRepo _savePointRepo;

  DeleteList({required ListRepo listRepo, required SavePointRepo savePointRepo}){
    _listRepo = listRepo;
    _savePointRepo = savePointRepo;
  }

  Future<void> call(ListViewModel listViewModel)async{
      await _listRepo.deleteList(listViewModel.toListModel());
      await _savePointRepo.deleteSavePointsWithQuery(SavePointType.list, listViewModel.id.toString());
  }

}