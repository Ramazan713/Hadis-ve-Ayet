

import 'package:hadith/core/domain/models/verse/verse.dart';import 'package:hadith/core/domain/models/verse/verse_list_model.dart';import 'package:hadith/features/verses/show_verse/domain/repo/verse_pagination_repo.dart';

class VerseTopicPagingRepo extends VersePaginationRepo{

  int _topicId = 0;

  VerseTopicPagingRepo({
    required super.verseRepo,
    required super.verseArabicRepo,
    required super.itemListInfoRepo
  });

  VerseTopicPagingRepo init({required int topicId}){
    _topicId = topicId;
    return this;
  }

  @override
  Future<int> getTotalItems() {
    return verseRepo.getVerseCountByTopicId(_topicId);
  }

  @override
  Future<List<Verse>> getVerseItems(int pageSize, int startIndex) {
    return verseRepo.getPagingVersesByTopicId(_topicId, pageSize, startIndex);
  }

  @override
  Future<bool> isItemExists(VerseListModel item) {
    return verseRepo.getExistsVerseByTopicId(_topicId, item.pagingId);
  }

}