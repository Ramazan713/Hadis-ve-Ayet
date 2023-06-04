

import 'package:hadith/core/data/local/mapper/list/list_view_mapper.dart';
import 'package:hadith/core/data/local/services/list/list_hadith_view_dao.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/domain/repo/list/list_hadith_view_repo.dart';
import 'package:hadith/core/domain/use_cases/query_ext_use_case.dart';

class ListHadithViewRepoImpl extends ListHadithViewRepo{
  late final ListHadithViewDao _listHadithViewDao;
  late final QueryExtUseCase _queryExtUseCase;

  ListHadithViewRepoImpl({
    required ListHadithViewDao listHadithViewDao,
    required QueryExtUseCase queryExtUseCase
  }){
    _listHadithViewDao = listHadithViewDao;
    _queryExtUseCase = queryExtUseCase;
  }

  @override
  Stream<List<ListViewModel>> getStreamListHadithByQueryAndIsArchive(String query, bool isArchive) {
    final queryResult = _queryExtUseCase.call(query);

    return _listHadithViewDao.getStreamListHadithByQueryAndIsArchive(
        queryResult.queryLikeForSearch, queryResult.queryLikeForOrder, queryResult.queryRaw, isArchive)
        .map((items)=> items.map((e) => e.toListViewModel()).toList());
  }

  @override
  Stream<List<ListViewModel>> getStreamListHadithViewsByIsArchive(bool isArchive) {
    return _listHadithViewDao.getStreamListHadithViewsByIsArchive(isArchive)
        .map((items)=> items.map((e) => e.toListViewModel()).toList());
  }

  @override
  Stream<List<ListViewModel>> getStreamRemovableListHadithViews() {
    return _listHadithViewDao.getStreamRemovableListHadithViews()
        .map((items) => items.map((e) => e.toListViewModel()).toList());
  }

  @override
  Stream<List<ListViewModel>> getStreamRemovableListHadithViewsByIsArchive(bool isArchive) {
    return _listHadithViewDao.getStreamRemovableListHadithViewsByIsArchive(isArchive)
        .map((items)=> items.map((e) => e.toListViewModel()).toList());
  }

}