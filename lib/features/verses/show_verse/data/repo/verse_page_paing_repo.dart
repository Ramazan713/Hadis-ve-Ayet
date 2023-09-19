
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
import 'package:hadith/features/verses/show_verse/domain/repo/verse_pagination_repo.dart';

class VersePagePagingRepo extends VersePaginationRepo{

  int _pageNo = 1;

  VersePagePagingRepo({
    required super.verseRepo,
    required super.verseArabicRepo,
    required super.itemListInfoRepo
  });

  VersePagePagingRepo init({int pageNo = 1}){
    _pageNo = pageNo;
    return this;
  }

  @override
  Future<int> getTotalItems() {
    return verseRepo.getVerseCountByPageNo(_pageNo);
  }

  @override
  Future<List<Verse>> getVerseItems(int pageSize, int startIndex, int startPage, int endPage) {
    return verseRepo.getPagingVersesByPageNo(startPage);
  }

  @override
  Future<bool> isItemExists(VerseListModel item) {
    return verseRepo.getExistsVerseByPageNo(_pageNo, item.pagingId);
  }

  @override
  int groupBy(VerseListModel item) {
    return item.verse.pageNo;
  }
}