


import 'package:hadith/core/domain/enums/search_criteria_enum.dart';

class SearchParam{
  final SearchCriteriaEnum searchCriteria;
  final String searchQuery;

  SearchParam({required this.searchCriteria, required this.searchQuery});
}