
import 'package:hadith/core/domain/enums/save_point/save_point_destination.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/core/domain/models/verse/verse_list_model.dart';
import 'package:hadith/core/domain/repo/search_repo.dart';
import 'package:hadith/features/verses/show_verse/domain/repo/verse_pagination_repo.dart';

class VerseSearchPagingRepo extends VersePaginationRepo{

  late final SearchRepo _searchRepo;

  SearchCriteriaEnum criteria = SearchCriteriaEnum.inMultipleKeys;
  String _query = "";

  VerseSearchPagingRepo({
    required SearchRepo searchRepo,
    required super.itemListInfoRepo,
    required super.verseRepo,
    required super.verseArabicRepo
  }){
    _searchRepo = searchRepo;
  }

  VerseSearchPagingRepo init(DestinationSearch destination){
    _query = destination.query;
    criteria = destination.criteria;
    return this;
  }

  @override
  Future<int> getTotalItems() {
    return _searchRepo.getCountVerse(_query, criteria);
  }

  @override
  Future<List<Verse>> getVerseItems(int pageSize, int startIndex) {
    return _searchRepo.getVerses(_query, criteria, pageSize, startIndex);
  }

  @override
  Future<bool> isItemExists(VerseListModel item) {
    return Future.value(false);
  }
}