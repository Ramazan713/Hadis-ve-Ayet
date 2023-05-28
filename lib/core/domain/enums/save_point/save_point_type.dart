
import 'package:hadith/constants/enums/book_enum.dart';

enum SavePointType{

  list(
      typeId: 1,
      title: "Liste"
  ),
  topic(
      typeId: 2,
      title: "Konu"
  ),
  all(
      typeId: 3,
      title: "Hepsi"
  ),
  surah(
      typeId: 4,
      title: "Sure"
  ),
  cuz(
      typeId: 5,
      title: "Cüz"
  ),
  search(
      typeId: 6,
      title: "Arama"
  );


  const SavePointType({required this.typeId,required this.title});

  final int typeId;
  final String title;


  static SavePointType from(int typeId){
    switch(typeId){
      case 1:
        return SavePointType.list;
      case 2:
        return SavePointType.topic;
      case 3:
        return SavePointType.all;
      case 4:
        return SavePointType.surah;
      case 5:
        return SavePointType.cuz;
      case 6:
        return SavePointType.search;
    }
    return SavePointType.list;
  }

}

extension SavePointTypeBarExt on SavePointType{

  static List<SavePointType> getSavePointTypes(BookEnum bookEnum){
    final hadithResult = [SavePointType.all,SavePointType.list,SavePointType.topic,SavePointType.search];
    switch(bookEnum){
      case BookEnum.sitte:
        return hadithResult;
      case BookEnum.serlevha:
        return hadithResult;
      case BookEnum.diyanetMeal:
        return [SavePointType.list, SavePointType.topic,
          SavePointType.surah, SavePointType.cuz, SavePointType.search];
      case BookEnum.none:
        return [];
    }
  }

}

