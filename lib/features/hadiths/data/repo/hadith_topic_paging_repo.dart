

import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/features/hadiths/domain/repo/hadith_pagination_repo.dart';

class HadithTopicPagingRepo extends HadithPaginationRepo{

  HadithTopicPagingRepo({
    required super.hadithRepo,
    required super.topicRepo,
    required super.itemListInfoRepo,
    required super.appPreferences
  });

  int _topicId = 0;

  HadithTopicPagingRepo init(int topicId){
    _topicId = topicId;
    return this;
  }


  @override
  Future<List<Hadith>> getHadithItems(int pageSize, int startIndex) async{
    return await hadithRepo.getPagingHadithsByTopicId(_topicId, pageSize, startIndex);
  }

  @override
  Future<int> getTotalItems() {
    return hadithRepo.getHadithCountByTopicId(_topicId);
  }

  @override
  Future<bool> isItemExists(HadithListModel item) {
    return hadithRepo.getExistsHadithByTopicId(_topicId, item.pagingId);
  }

}