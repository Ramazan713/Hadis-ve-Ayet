

import 'package:hadith/core/domain/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/core/domain/models/hadith.dart';
import 'package:hadith/core/domain/repo/search_repo.dart';
import 'package:hadith/core/domain/enums/book_scope_enum.dart';
import 'package:hadith/core/features/save_point/domain/enums/save_point_destination.dart';
import 'package:hadith/features/hadiths/domain/models/hadith_list_model.dart';
import 'package:hadith/features/hadiths/domain/repo/hadith_pagination_repo.dart';

class HadithSearchPagingRepo extends HadithPaginationRepo{

  late final SearchRepo _searchRepo;

  SearchCriteriaEnum criteria = SearchCriteriaEnum.inMultipleKeys;
  String _query = "";
  BookScopeEnum _bookScopeEnum = BookScopeEnum.serlevha;

  HadithSearchPagingRepo({
    required SearchRepo searchRepo,
    required super.hadithRepo,
    required super.topicRepo,
    required super.itemListInfoRepo,
    required super.appPreferences
  }){
    _searchRepo = searchRepo;
  }

  HadithSearchPagingRepo init(DestinationSearch destination){
    _query = destination.query;
    _bookScopeEnum = destination.bookScope;
    criteria = destination.criteria;
    return this;
  }


  @override
  Future<List<Hadith>> getHadithItems(int pageSize, int startIndex) {
    switch(_bookScopeEnum){
      case BookScopeEnum.sitte:
        return _searchRepo.getHadithsByBookId(_query, criteria, BookEnum.sitte.bookId,
            pageSize, startIndex);
      case BookScopeEnum.serlevha:
        return _searchRepo.getHadithsByBookId(_query, criteria, BookEnum.serlevha.bookId,
            pageSize, startIndex);
      case BookScopeEnum.serlevhaSitte:
        return _searchRepo.getAllHadiths(_query, criteria, pageSize, startIndex);
      default:
        return Future.value([]);
    }
  }

  @override
  Future<int> getTotalItems() async{
    switch(_bookScopeEnum){
      case BookScopeEnum.sitte:
        return _searchRepo.getCountHadithByBookId(_query, criteria, BookEnum.sitte.bookId);
      case BookScopeEnum.serlevha:
        return _searchRepo.getCountHadithByBookId(_query, criteria, BookEnum.serlevha.bookId);
      case BookScopeEnum.serlevhaSitte:
        return _searchRepo.getCountAllHadith(_query, criteria);
      default:
        return Future.value(0);
    }
  }

  @override
  Future<bool> isItemExists(HadithListModel item) {
    return Future.value(false);
  }

}