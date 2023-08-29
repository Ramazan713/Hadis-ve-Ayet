

import 'package:hadith/features/search/domain/model/history.dart';

abstract class ISearchEvent{}

class SearchEventListenHistories extends ISearchEvent{}

class SearchEventListenSearchResult extends ISearchEvent{}

class SearchEventSearch extends ISearchEvent{
  final String searchKey;
  SearchEventSearch({required this.searchKey});
}

class SearchEventSetQuery extends ISearchEvent{
  final String query;
  SearchEventSetQuery({required this.query});
}

class SearchEventDeleteHistory extends ISearchEvent{
  final History history;
  SearchEventDeleteHistory({required this.history});
}

