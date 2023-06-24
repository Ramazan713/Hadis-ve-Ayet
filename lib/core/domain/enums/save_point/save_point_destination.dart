import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/enums/save_point/list_book_scope.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/features/save_point/constants/book_scope_enum.dart';

import 'save_point_type.dart';

sealed class SavePointDestination{
  late final SavePointType _type;
  late final String _parentKey;
  late final String _parentName;
  late final BookScopeEnum _bookScope;

  SavePointDestination({required SavePointType type, required String parentKey,
    required BookScopeEnum bookScope,
    required String parentName
  }){
    _parentKey = parentKey;
    _parentName = parentName;
    _bookScope = bookScope;
    _type = type;
  }

  SavePointType getType() => _type;
  String getParentKey() => _parentKey;
  String getParentName() => _parentName;
  BookScopeEnum getBookScope() => _bookScope;

  String get typeDescription => _type.title;

  static SavePointDestination? fromParam(int typeId, String parentKey,
      String parentName,BookScopeEnum bookScope){

    if(typeId == DestinationList.type.typeId){
      return DestinationList(listId: int.tryParse(parentKey)??1,
          listName: parentName, listBookScope: ListBookScopeExt.fromWithDefault(bookScope));
    }
    else if(typeId == DestinationTopic.type.typeId){
      return DestinationTopic(topicId: int.tryParse(parentKey)??0,
          topicName: parentName, bookEnum: bookScope.book??BookEnum.serlevha
      );
    }
    else if(typeId == DestinationAll.type.typeId){
      return DestinationAll(bookEnum: bookScope.book??BookEnum.serlevha);
    }
    else if(typeId == DestinationSurah.type.typeId){
      return DestinationSurah(surahId: int.tryParse(parentKey)??1,
          surahName: parentName
      );
    }
    else if(typeId == DestinationCuz.type.typeId){
      return DestinationCuz(cuzId: int.tryParse(parentKey)??1,
          cuzName: parentName
      );
    }
    else if(typeId == DestinationSearch.type.typeId){
      return DestinationSearch.from(
          parentKey: parentKey,
          bookScope: bookScope
      );
    }
    return null;
  }

  static SavePointDestination fromParamWithDefault(int typeId, String parentKey,
      String parentName,BookScopeEnum bookScope){

    return fromParam(typeId, parentKey, parentName, bookScope) ??
      DestinationAll(bookEnum: BookEnum.sitte);
  }

  static SavePointDestination from(int typeId, String parentKey,
      String parentName,int bookScope){
    return fromParamWithDefault(typeId, parentKey, parentName, BookScopeExt.fromBinaryId(bookScope));
  }
}





class DestinationList extends SavePointDestination{
  static const SavePointType type = SavePointType.list;

  final int listId;
  final String listName;
  final ListBookScope listBookScope;

  DestinationList({
    required this.listId,
    required this.listName,
    required this.listBookScope
  }): super(
      bookScope: listBookScope.bookScopeEnum,
      parentKey: listId.toString(),
      parentName: listName,
      type: type
  );
}

class DestinationTopic extends SavePointDestination{
  static const SavePointType type = SavePointType.topic;
  final int topicId;
  final String topicName;
  final BookEnum bookEnum;

  DestinationTopic({
    required this.topicId,
    required this.topicName,
    required this.bookEnum
  }): super(
      bookScope: bookEnum.bookScope ?? BookScopeEnum.serlevha,
      parentKey: topicId.toString(),
      parentName: topicName,
      type: type
  );
}

class DestinationAll extends SavePointDestination{
  static const SavePointType type = SavePointType.all;
  final BookEnum bookEnum;

  DestinationAll({required this.bookEnum}): super(
      bookScope: bookEnum.bookScope ?? BookScopeEnum.serlevha,
      parentKey: bookEnum.bookId.toString(),
      parentName: "Tümü",
      type: type
  );
}

class DestinationSurah extends SavePointDestination {
  static const SavePointType type = SavePointType.surah;
  final String surahName;
  final int surahId;

  DestinationSurah({required this.surahId, required this.surahName}): super(
      bookScope: BookScopeEnum.diyanetMeal,
      parentKey: surahId.toString(),
      parentName: surahName,
      type: type
  );

  @override
  String get typeDescription => surahName;
}

class DestinationCuz extends SavePointDestination {
  static const SavePointType type = SavePointType.cuz;
  final String cuzName;
  final int cuzId;

  DestinationCuz({required this.cuzName, required this.cuzId}): super(
      bookScope: BookScopeEnum.diyanetMeal,
      parentKey: cuzId.toString(),
      parentName: cuzName,
      type: type
  );

  @override
  String get typeDescription => "$cuzId.${type.title}";
}

class DestinationSearch extends SavePointDestination {
  static const SavePointType type = SavePointType.search;
  final String query;
  final BookScopeEnum bookScope;
  final SearchCriteriaEnum criteria;

  DestinationSearch({
    required this.query,
    required this.bookScope,
    required this.criteria
  }): super(
      bookScope: bookScope,
      parentKey: "${criteria.enumValue}***$query",
      parentName: query,
      type: type
  );

  static DestinationSearch from({required String parentKey, required BookScopeEnum bookScope}){
    final dataArr = parentKey.split("***");
    String query = parentKey;
    SearchCriteriaEnum criteria = SearchCriteriaEnum.defaultValue;
    if(dataArr.length == 2){
      final criteriaValue = int.tryParse(dataArr[0]);
      if(criteriaValue!=null){
        criteria = SearchCriteriaEnum.from(criteriaValue);
        query = dataArr[1];
      }
    }
    return DestinationSearch(
        query: query,
        bookScope: bookScope,
        criteria: criteria,
    );
  }

}