

import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_model.dart';
import 'package:hadith/core/domain/repo/list/list_repo.dart';

class InsertList{

  late final ListRepo _listRepo;
  InsertList({required ListRepo listRepo}){
    _listRepo = listRepo;
  }

  Future<void> call(String name, SourceTypeEnum sourceType)async{
    final maxPos = await _listRepo.getMaxPosListWithSourceType(sourceType);

    final listModel = ListModel(
      id: null,
      name: name,
      isRemovable: true,
      isArchive: false,
      sourceType: sourceType,
      pos: maxPos + 1
    );
    await _listRepo.insertList(listModel);
  }
}