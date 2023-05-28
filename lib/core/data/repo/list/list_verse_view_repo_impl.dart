

import 'package:hadith/core/data/local/mapper/list/list_view_mapper.dart';
import 'package:hadith/core/data/local/services/list/list_verse_view_dao.dart';
import 'package:hadith/core/domain/models/list/list_view_model.dart';
import 'package:hadith/core/domain/repo/list/list_verse_view_repo.dart';

class ListVerseViewRepoImpl extends ListVerseViewRepo{

  late final ListVerseViewDao _listVerseViewDao;

  ListVerseViewRepoImpl({required ListVerseViewDao listVerseViewDao}){
    _listVerseViewDao = listVerseViewDao;
  }

  @override
  Stream<List<ListViewModel>> getStreamListVerseViewByIsArchive(bool isArchive) {
    return _listVerseViewDao.getStreamListVerseViewByIsArchive(isArchive)
        .map((items)=> items.map((e) => e.toListViewModel()).toList());
  }

  @override
  Stream<List<ListViewModel>> getStreamListVersesViewByQueryAndIsArchive(String query, bool isArchive) {

    final queryLikeForSearch = "%$query%".split(" ").join("%");
    final queryLikeForOrder = "$query%".split(" ").join("%");
    final queryRaw = query.toLowerCase();

    return _listVerseViewDao.getStreamListVersesViewByQueryAndIsArchive(
        queryLikeForSearch, queryLikeForOrder, queryRaw, isArchive)
        .map((items)=> items.map((e) => e.toListViewModel()).toList());
  }

}