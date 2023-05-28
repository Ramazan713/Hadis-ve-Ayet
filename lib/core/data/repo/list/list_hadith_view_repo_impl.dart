

import 'package:hadith/core/data/local/mapper/list/list_view_mapper.dart';
import 'package:hadith/core/data/local/services/list/list_hadith_view_dao.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_view_repo.dart';

class ListHadithViewRepoImpl extends ListHadithViewRepo{
  late final ListHadithViewDao _listHadithViewDao;

  ListHadithViewRepoImpl({required ListHadithViewDao listHadithViewDao}){
    _listHadithViewDao = listHadithViewDao;
  }

  @override
  Stream<List<ListViewModel>> getStreamListHadithByQueryAndIsArchive(String query, bool isArchive) {
    final queryLikeForSearch = "%$query%".split(" ").join("%");
    final queryLikeForOrder = "$query%".split(" ").join("%");
    final queryRaw = query.toLowerCase();

    return _listHadithViewDao.getStreamListHadithByQueryAndIsArchive(
        queryLikeForSearch, queryLikeForOrder, queryRaw, isArchive)
        .map((items)=> items.map((e) => e.toListViewModel()).toList());
  }

  @override
  Stream<List<ListViewModel>> getStreamListHadithViewsByIsArchive(bool isArchive) {
    return _listHadithViewDao.getStreamListHadithViewsByIsArchive(isArchive)
        .map((items)=> items.map((e) => e.toListViewModel()).toList());
  }

}