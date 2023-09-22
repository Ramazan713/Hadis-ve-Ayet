

import 'package:hadith/core/domain/models/verse/verse.dart';import 'package:hadith/core/domain/models/verse/verse_list_model.dart';import 'package:hadith/features/verses/show_verse/domain/repo/verse_pagination_repo.dart';

class VerseListPagingRepo extends VersePaginationRepo{

  int _listId = 0;

  VerseListPagingRepo({
    required super.verseRepo,
    required super.verseArabicRepo,
    required super.itemListInfoRepo,
    required super.appPreferences
  });

  VerseListPagingRepo init({required int listId}){
    _listId = listId;
    return this;
  }

  @override
  Future<int> getTotalItems() {
    return verseRepo.getVerseCountByListId(_listId);
  }

  @override
  Future<List<Verse>> getVerseItems(int pageSize, int startIndex, int startPage, int endPage) {
    return verseRepo.getPagingVersesByListId(_listId, pageSize, startIndex);
  }

  @override
  Future<bool> isItemExists(VerseListModel item) {
    return verseRepo.getExistsVerseByListId(_listId, item.pagingId);
  }

}