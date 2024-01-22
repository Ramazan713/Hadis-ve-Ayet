abstract class ISurahEvent{}

class SurahEventLoadData extends ISurahEvent{}

class SurahEventSetSearchBarVisibility extends ISurahEvent{
  final bool isSearchBarVisible;
  SurahEventSetSearchBarVisibility({required this.isSearchBarVisible});
}

class SurahEventSearch extends ISurahEvent{
  final String query;
  SurahEventSearch({required this.query});
}