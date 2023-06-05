



import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/list/list_model.dart';
import 'package:hadith/core/domain/repo/list/list_repo.dart';

class GetFavoriteList{
  late final ListRepo _listRepo;

  GetFavoriteList({
    required ListRepo listRepo,
  }){
    _listRepo = listRepo;
  }


  Future<ListModel> call({required SourceTypeEnum sourceType})async{
    return await _getOrCreateFavoriteList(sourceType);
  }


  Future<ListModel> _getOrCreateFavoriteList(SourceTypeEnum sourceType)async{
    final listFav = await _listRepo.getFavoriteList(sourceType);
    if(listFav != null) return listFav;

    final listModel = ListModel(
      name: "Favoriler",
      isRemovable: false,
      isArchive: false,
      id: null,
      sourceType: sourceType,
      pos: 0,
    );
    final favListId = await _listRepo.insertList(listModel);
    return listModel.copyWith(id: favListId,setId: true);
  }
}