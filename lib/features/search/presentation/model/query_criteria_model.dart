

import 'package:hadith/core/domain/enums/search_criteria_enum.dart';

class QueryCriteriaModel{
  final SearchCriteriaEnum criteria;
  final String query;
  QueryCriteriaModel({required this.criteria, required this.query});
}