
import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/features/hadiths/domain/repo/hadith_pagination_repo.dart';

class HadithListPagingRepo extends HadithPaginationRepo{
  HadithListPagingRepo({
    required super.hadithRepo,
    required super.topicRepo,
    required super.itemListInfoRepo,
    required super.appPreferences
  });

  int _listId = 0;

  HadithListPagingRepo init(int listId){
    _listId = listId;
    return this;
  }

  @override
  Future<List<Hadith>> getHadithItems(int pageSize, int startIndex) async{
    return await hadithRepo.getPagingHadithsByListId(_listId, pageSize, startIndex);
  }

  @override
  Future<int> getTotalItems() async{
    return await hadithRepo.getHadithCountByListId(_listId);
  }

  @override
  Future<bool> isItemExists(HadithListModel item) {
    return hadithRepo.getExistsHadithByListId(_listId, item.pagingId);
  }

}