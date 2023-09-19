

import 'package:hadith/core/domain/models/verse/verse.dart';import 'package:hadith/core/domain/models/verse/verse_list_model.dart';import 'package:hadith/features/verses/show_verse/domain/repo/verse_pagination_repo.dart';

class VerseCuzPagingRepo extends VersePaginationRepo{

  int _cuzNo = 0;

  VerseCuzPagingRepo({
    required super.verseRepo,
    required super.verseArabicRepo,
    required super.itemListInfoRepo
  });

  VerseCuzPagingRepo init({required int cuzNo}){
    _cuzNo = cuzNo;
    return this;
  }

  @override
  Future<int> getTotalItems() {
    return verseRepo.getVerseCountByCuzNo(_cuzNo);
  }

  @override
  Future<List<Verse>> getVerseItems(int pageSize, int startIndex, int startPage, int endPage) {
    return verseRepo.getPagingVersesByCuzNo(_cuzNo, pageSize, startIndex);
  }

  @override
  Future<bool> isItemExists(VerseListModel item) {
    return verseRepo.getExistsVerseByCuzNo(_cuzNo, item.pagingId);
  }

}