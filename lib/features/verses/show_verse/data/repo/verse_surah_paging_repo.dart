

import 'package:hadith/core/domain/models/verse/verse.dart';import 'package:hadith/core/domain/models/verse/verse_list_model.dart';import 'package:hadith/features/verses/show_verse/domain/repo/verse_pagination_repo.dart';

class VerseSurahPagingRepo extends VersePaginationRepo{

  int _surahId = 0;

  VerseSurahPagingRepo({
    required super.verseRepo,
    required super.verseArabicRepo,
    required super.itemListInfoRepo,
    required super.appPreferences
  });

  VerseSurahPagingRepo init({required int surahId}){
    _surahId = surahId;
    return this;
  }

  @override
  Future<int> getTotalItems() {
    return verseRepo.getVerseCountBySurahId(_surahId);
  }

  @override
  Future<List<Verse>> getVerseItems(int pageSize, int startIndex, int startPage, int endPage) {
    return verseRepo.getPagingVersesBySurahId(_surahId, pageSize, startIndex);
  }

  @override
  Future<bool> isItemExists(VerseListModel item) {
    return verseRepo.getExistsVerseBySurahId(_surahId, item.pagingId);
  }

}