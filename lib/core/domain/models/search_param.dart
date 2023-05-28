

import 'package:hadith/constants/enums/search_criteria_enum.dart';

class SearchParam{
  final SearchCriteriaEnum searchCriteria;
  final String searchQuery;

  SearchParam({required this.searchCriteria, required this.searchQuery});
}