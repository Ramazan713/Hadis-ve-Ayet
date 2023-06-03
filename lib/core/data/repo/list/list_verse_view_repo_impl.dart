

import 'package:hadith/core/data/local/mapper/list/list_view_mapper.dart';
import 'package:hadith/core/data/local/services/list/list_verse_view_dao.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/domain/repo/list/list_verse_view_repo.dart';
import 'package:hadith/core/domain/use_cases/query_ext_use_case.dart';

class ListVerseViewRepoImpl extends ListVerseViewRepo{

  late final ListVerseViewDao _listVerseViewDao;
  late final QueryExtUseCase _queryExtUseCase;

  ListVerseViewRepoImpl({
    required ListVerseViewDao listVerseViewDao,
    required QueryExtUseCase queryExtUseCase
  }){
    _listVerseViewDao = listVerseViewDao;
    _queryExtUseCase = queryExtUseCase;
  }

  @override
  Stream<List<ListViewModel>> getStreamListVerseViewByIsArchive(bool isArchive) {
    return _listVerseViewDao.getStreamListVerseViewByIsArchive(isArchive)
        .map((items)=> items.map((e) => e.toListViewModel()).toList());
  }

  @override
  Stream<List<ListViewModel>> getStreamListVersesViewByQueryAndIsArchive(String query, bool isArchive) {
    final queryResult = _queryExtUseCase.call(query);

    return _listVerseViewDao.getStreamListVersesViewByQueryAndIsArchive(
        queryResult.queryLikeForSearch, queryResult.queryLikeForOrder, queryResult.queryRaw,
        isArchive
    ).map((items)=> items.map((e) => e.toListViewModel()).toList());
  }

}