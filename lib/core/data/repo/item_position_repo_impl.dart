

import 'package:hadith/core/data/local/services/item_pos_dao.dart';
import 'package:hadith/core/domain/repo/item_position_repo.dart';

class ItemPositionRepoImpl extends ItemPositionRepo{

  late final ItemPositionDao _itemPositionDao;

  ItemPositionRepoImpl({
    required ItemPositionDao itemPositionDao
  }){
    _itemPositionDao = itemPositionDao;
  }

  @override
  Future<int> getSurahPos(int surahId, int mealId) async{
    return (await _itemPositionDao.getSurahPos(surahId, mealId)) ?? 0;
  }
  
}