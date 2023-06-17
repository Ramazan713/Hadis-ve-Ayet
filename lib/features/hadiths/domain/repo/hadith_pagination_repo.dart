

import 'package:hadith/constants/preference_constants.dart';
import 'package:hadith/core/domain/enums/source_type_enum.dart';
import 'package:hadith/core/domain/models/item_list_info.dart';
import 'package:hadith/core/domain/repo/item_list_info_repo.dart';
import 'package:hadith/core/domain/repo/topic_repo.dart';
import 'package:hadith/core/domain/repo/pagination_repo.dart';
import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/core/domain/repo/hadith_repo.dart';
import 'package:hadith/utils/localstorage.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HadithPaginationRepo extends PaginationRepo<HadithListModel>{

  @protected
  late final HadithRepo hadithRepo;
  late final TopicRepo _topicRepo;
  late final ItemListInfoRepo _itemListInfoRepo;
  final SharedPreferences _sharedPreferences = LocalStorage.sharedPreferences;

  bool get _useArchiveListFeatures => _sharedPreferences.getBool(PrefConstants.useArchiveListFeatures.key)??false;


  HadithPaginationRepo({required this.hadithRepo,required TopicRepo topicRepo,
    required ItemListInfoRepo itemListInfoRepo
  }){
    _topicRepo = topicRepo;
    _itemListInfoRepo = itemListInfoRepo;
  }

  @protected
  Future<List<Hadith>> getHadithItems(int pageSize, int startIndex);

  @override
  Future<List<HadithListModel>> getItems(int startIndex, int endIndex) async{
    final hadiths = await getHadithItems(endIndex-startIndex, startIndex);
    final items = <HadithListModel>[];

    var index = 1;
    for(final hadith in hadiths){
      final item = await _getHadithListModel(hadith, startIndex + index, _useArchiveListFeatures);
      items.add(item);
      index++;
    }
    return items;

  }

  Future<HadithListModel> _getHadithListModel(Hadith hadith, int rowNumber,bool useArchiveListFeatures)async{
    final hadithId = hadith.id ?? 0;

    final listInfo = await _getListInfo(hadithId);
    final topicNames = await _getTopicNames(hadithId);

    return HadithListModel(
        isInFavorite: listInfo.inFavorite,
        isInAnyList: listInfo.getInAnyListWithArchiveList(useArchiveListFeatures),
        isInAnyArchiveList: listInfo.inAnyArchiveList,
        hadith: hadith,
        rowNumber: rowNumber,
        topicNames: topicNames
    );
  }

  Future<ItemListInfo> _getListInfo(int hadithId)async{
    final listInfo = await _itemListInfoRepo.getItemListInfo(hadithId, SourceTypeEnum.hadith);
    return listInfo ?? ItemListInfo(itemId: hadithId,
        sourceType: SourceTypeEnum.hadith, inAnyList: false, inAnyArchiveList: false, inFavorite: false);
  }

  Future<String> _getTopicNames(int hadithId) async{
    final topics = await _topicRepo.getTopicNamesByHadithId(hadithId);
    return topics.join("; ");
  }


  @override
  Future<HadithListModel?> getUpdatedItem(HadithListModel item) async{
    final updatedHadith = await hadithRepo.getHadithById(item.hadith.id ?? 0);
    if(updatedHadith == null) return null;
    final itemListInfo = await _getListInfo(updatedHadith.id??0);
    return item.updateWith(
        itemListInfo: itemListInfo,
        useArchiveListFeatures: _useArchiveListFeatures,
        updatedHadith: updatedHadith);
  }

}