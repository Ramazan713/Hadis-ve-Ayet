

import 'package:hadith/core/domain/preferences/model/i_pref_enum.dart';

enum SearchCriteriaEnum with IPrefEnum{

  inMultipleKeys(
    enumValue: 0,
    isRegex: true,
    description: "Anahtar kelimeleri içinde ara",
  ),
  multipleKeys(
      enumValue: 1,
      isRegex: true,
      description: "Anahtar kelimelerle ara",
  ),
  inOneExpression(
      enumValue: 2,
      isRegex: false,
      description: "Tek bir ifadeyi içinde ara",
  ),
  oneExpression(
      enumValue: 3,
      isRegex: true,
      description: "Tek bir ifade olarak ara",
  );

  const SearchCriteriaEnum({
    required this.description,
    required this.enumValue,
    required this.isRegex
  });

  @override
  final int enumValue;

  final String description;

  final bool isRegex;

  String getQuery(String query){
    switch(this){
      case SearchCriteriaEnum.multipleKeys: //"(?=.*\\b$e\\b)").join('')}.*"
        return "${query.split(' ').map((e) => "(?=.*\\b$e\\b)").join('')}.*";

      case SearchCriteriaEnum.inMultipleKeys:
        return "${query.split(' ').map((e) => "(?=.*$e)").join('')}.*";

      case SearchCriteriaEnum.oneExpression:
        return ".*\\b$query\\b.*";

      case SearchCriteriaEnum.inOneExpression:
        return "%$query%";
    }
  }

  RegExp getRegex({
    required String query,
    bool caseSensitive = true
  }){
    final String pattern;

    switch(this){
      case SearchCriteriaEnum.multipleKeys:
        pattern = query.split(' ').map((e) => "(\\b$e\\b)|").join('');
        break;
      case SearchCriteriaEnum.inMultipleKeys:
        pattern = query.split(' ').map((e) => "$e|").join('');
        break;
      case SearchCriteriaEnum.oneExpression:
        pattern = "\\b$query\\b";
        break;
      case SearchCriteriaEnum.inOneExpression:
        pattern = query;
        break;
    }

    return RegExp(pattern,caseSensitive: caseSensitive);
  }


  static SearchCriteriaEnum get defaultValue => SearchCriteriaEnum.inMultipleKeys;

  static SearchCriteriaEnum from(int enumValue){

    if(enumValue == SearchCriteriaEnum.inMultipleKeys.enumValue){
      return SearchCriteriaEnum.inMultipleKeys;
    }
    else if(enumValue == SearchCriteriaEnum.multipleKeys.enumValue){
      return SearchCriteriaEnum.multipleKeys;
    }
    else if(enumValue == SearchCriteriaEnum.inOneExpression.enumValue){
      return SearchCriteriaEnum.inOneExpression;
    }
    else if(enumValue == SearchCriteriaEnum.oneExpression.enumValue){
      return SearchCriteriaEnum.oneExpression;
    }
    return defaultValue;
  }

}