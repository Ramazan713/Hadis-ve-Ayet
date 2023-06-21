

import 'package:hadith/features/search_/domain/model/history.dart';

abstract class ISearchEvent{}

class SearchEventListenHistories extends ISearchEvent{}

class SearchEventListenSearchResult extends ISearchEvent{}

class SearchEventSetInit extends ISearchEvent{}

class SearchEventSearch extends ISearchEvent{
  final String searchKey;
  SearchEventSearch({required this.searchKey});
}

class SearchEventClearHistories extends ISearchEvent{}

class SearchEventDeleteHistory extends ISearchEvent{
  final History history;
  SearchEventDeleteHistory({required this.history});
}

