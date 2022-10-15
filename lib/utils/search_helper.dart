
import 'package:hadith/constants/enums/search_criteria_enum.dart';

import '../constants/preference_constants.dart';
import 'localstorage.dart';

class SearchHelper{
  static final _regEnums = [SearchCriteriaEnum.multipleKeys,
    SearchCriteriaEnum.inMultipleKeys,SearchCriteriaEnum.oneExpression];

  static SearchCriteriaEnum getCriteria(){
    final pos=LocalStorage.sharedPreferences.getInt(PrefConstants.searchCriteriaEnum.key)??
        PrefConstants.searchCriteriaEnum.defaultValue;
    return SearchCriteriaEnum.values[pos];
  }

  static bool isRegEnum(SearchCriteriaEnum criteriaEnum){
    return _regEnums.contains(criteriaEnum);
  }

  static String getRegExQueryWithCriteria(String query,SearchCriteriaEnum criteriaEnum){

    switch(criteriaEnum){
      case SearchCriteriaEnum.multipleKeys:
        return "${query.split(' ').map((e) => "(?=.*\\b$e\\b)").join('')}.*";
      case SearchCriteriaEnum.inMultipleKeys:
        return "${query.split(' ').map((e) => "(?=.*$e)").join('')}.*";
      case SearchCriteriaEnum.oneExpression:
        return ".*\\b$query\\b.*";
      default:
        return query;
    }
  }
  static String getRegExQuery(String query){
    return getRegExQueryWithCriteria(query, getCriteria());
  }

  static String getLikeQueryWithCriteria(String query,SearchCriteriaEnum criteriaEnum){
    switch(criteriaEnum){
      case SearchCriteriaEnum.inOneExpression:
        return "%$query%";
      default:
        return query;
    }
  }

  static String getLikeQuery(String query){
    return getRegExQueryWithCriteria(query, getCriteria());
  }

  static RegExp findWordsPattern(String searchKey,bool caseSensitive){
    final criteriaEnum = getCriteria();
    switch(criteriaEnum){
      case SearchCriteriaEnum.oneExpression:
        return RegExp("\\b$searchKey\\b",caseSensitive: caseSensitive);

      case SearchCriteriaEnum.inOneExpression:
        return RegExp(searchKey,caseSensitive: caseSensitive);

      case SearchCriteriaEnum.multipleKeys:
        final pattern=searchKey.split(' ').map((e) => "(\\b$e\\b)|").join('');
        return RegExp(pattern.substring(0,pattern.length-1),caseSensitive:caseSensitive);

      case SearchCriteriaEnum.inMultipleKeys:
        final pattern=searchKey.split(' ').map((e) => "$e|").join('');
        return RegExp(pattern.substring(0,pattern.length-1),caseSensitive: caseSensitive);
    }
  }


}