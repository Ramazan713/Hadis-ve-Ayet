
import 'package:hadith/constants/enums/book_enum.dart';
import 'package:hadith/core/domain/models/i_menu_item.dart';

enum SavePointType with IMenuItem{

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
  ),
  quranPage(
    typeId: 7,
    title: "Sayfa"
  )
  ;


  const SavePointType({required this.typeId,required this.title});

  final int typeId;

  @override
  final String title;

  @override
  get iconInfo => null;


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
      case 7:
        return SavePointType.quranPage;
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
          SavePointType.quranPage,
          SavePointType.surah, SavePointType.cuz, SavePointType.search];
    }
  }

}

