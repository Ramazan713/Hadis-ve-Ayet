

import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/core/features/pagination/domain/pagination_repo.dart';
import 'package:hadith/db/entities/hadith.dart';
import 'package:hadith/db/repos/list_repo.dart';
import 'package:hadith/db/repos/topic_repo.dart';
import 'package:hadith/features/hadiths/data/services/hadith_all_dao.dart';
import 'package:hadith/features/hadiths/domain/hadith_list_model.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HadithAllPagingRepo extends PaginationRepo<HadithListModel>{

  late final HadithAllDao _hadithAllDao;
  late final TopicRepo _topicRepo;
  late final ListRepo _listRepo;
  final SharedPreferences _sharedPreferences = LocalStorage.sharedPreferences;
  // final int hadithBookId;

  HadithAllPagingRepo({required HadithAllDao hadithAllDao,required TopicRepo topicRepo,required ListRepo listRepo}){
    _hadithAllDao = hadithAllDao;
    _topicRepo = topicRepo;
    _listRepo = listRepo;
  }

  @override
  Future<List<HadithListModel>> getItems(int startIndex, int endIndex)async{
    final hadiths = await _hadithAllDao.getPagingAllHadiths(endIndex-startIndex, startIndex);
    final items = <HadithListModel>[];
    var index = 1;
    for(final hadith in hadiths){
      final item = await _getHadithListModel(hadith, startIndex + index);
      items.add(item);
      index++;
    }
    return items;
  }

  @override
  Future<int> getTotalItems() async{
    return (await _hadithAllDao.getAllHadithCount()) ?? 0 ;
  }


  Future<HadithListModel> _getHadithListModel(Hadith hadith, int rowNumber)async{
    final isInFavorite = await _isHadithFavorite(hadith);
    final isInAnyList = await _isHadithAddListNotEmpty(hadith);
    final topics = await _topicRepo.getHadithTopics(hadith.id ??0);

    return HadithListModel(
        isInFavorite: isInFavorite,
        isInAnyList: isInAnyList,
        hadith: hadith,
        rowNumber: rowNumber,
        topics: topics
    );
  }



  Future<bool>_isHadithFavorite(Hadith hadith)async{
    final listItems=await _listRepo.getHadithListWithRemovable(hadith.id??0, false);
    return listItems.isNotEmpty;
  }

  Future<bool>_isHadithAddListNotEmpty(Hadith hadith)async{
    final useArchiveListFeatures = _sharedPreferences.getBool(PrefConstants.useArchiveListFeatures.key)??false;
    final listItems=useArchiveListFeatures?await _listRepo.getHadithListWithRemovable(hadith.id??0, true):
    await _listRepo.getHadithListWithRemovableArchive(hadith.id??0, true, false);
    return listItems.isNotEmpty;
  }

  @override
  Future<HadithListModel?> getUpdatedItem(HadithListModel item) async{
    final updatedHadith = await _hadithAllDao.getHadithById(item.hadith.id ?? 0);
    if(updatedHadith == null) return null;
    return _getHadithListModel(updatedHadith, item.rowNumber);
  }

}