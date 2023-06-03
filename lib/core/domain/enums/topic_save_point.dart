

import 'package:hadith/constants/enums/book_enum.dart';

sealed class TopicSavePointType{

  late final int _typeId;

  TopicSavePointType({required int typeId}){
    _typeId = typeId;
  }

  int getTypeId() => _typeId;
  String getSaveKey();


  static TopicSavePointType? from(int typeId, String saveKey){
    switch(typeId){
      case TopicSavePointTypeTopic.typeId:
        int? sectionOrBookId = int.tryParse(saveKey);
        if(sectionOrBookId==null) return null;
        
        if(sectionOrBookId < 0){ // for book
          return TopicSavePointTypeTopicUsesAllBook(
            bookEnum: BookEnum.from(sectionOrBookId.abs())
          );
        }
        return TopicSavePointTypeTopic(sectionId: sectionOrBookId);

      case TopicSavePointTypeCuz.typeId:
        return TopicSavePointTypeCuz();
      case TopicSavePointTypeSurah.typeId:
        return TopicSavePointTypeSurah();
    }
     return null;
  }

  static TopicSavePointType fromOrDefault(int typeId, String saveKey){
    return from(typeId, saveKey) ?? TopicSavePointTypeTopic(sectionId: 1);
  }

}

class TopicSavePointTypeTopic extends TopicSavePointType{
  static const int typeId = 2;

  final int sectionId;

  TopicSavePointTypeTopic({required this.sectionId,}): super(typeId: typeId,);

  @override
  String getSaveKey() {
    return "$sectionId";
  }
}

class TopicSavePointTypeTopicUsesAllBook extends TopicSavePointType{
  static const int typeId = 2;

  final BookEnum bookEnum;

  TopicSavePointTypeTopicUsesAllBook({required this.bookEnum}): super(typeId: typeId,);

  @override
  String getSaveKey() {
    return "-${bookEnum.bookId}";
  }
}


class TopicSavePointTypeCuz extends TopicSavePointType{
  static const int typeId = 1;

  TopicSavePointTypeCuz(): super(typeId: typeId);

  @override
  String getSaveKey() => "cuz";


}

class TopicSavePointTypeSurah extends TopicSavePointType{
  static const int typeId = 3;

  TopicSavePointTypeSurah(): super(typeId: typeId);

  @override
  String getSaveKey() => "surah";
}
