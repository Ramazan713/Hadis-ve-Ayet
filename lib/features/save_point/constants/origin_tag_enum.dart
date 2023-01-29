


enum OriginTag{
  all,list,topic,surah,cuz,search
}

extension OriginTagExt on OriginTag{
  int get savePointId{
    switch(this){
      case OriginTag.list:
        return 1;
      case OriginTag.topic:
        return 2;
      case OriginTag.all:
        return 3;
      case OriginTag.surah:
        return 4;
      case OriginTag.cuz:
        return 5;
      case OriginTag.search:
        return 6;
    }
  }

  String get shortName{
    switch(this){
      case OriginTag.list:
        return "Liste";
      case OriginTag.topic:
        return "Konu";
      case OriginTag.all:
        return "Hepsi";
      case OriginTag.surah:
        return "Sure";
      case OriginTag.cuz:
        return "Cüz";
      case OriginTag.search:
        return "Arama";
    }
  }

  static OriginTag fromSavePointId(int savePointId){
    switch(savePointId){
      case 1:
        return OriginTag.list;
      case 2:
        return OriginTag.topic;
      case 3:
        return OriginTag.all;
      case 4:
        return OriginTag.surah;
      case 5:
        return OriginTag.cuz;
      case 6:
        return OriginTag.search;
      default:
        return OriginTag.all;
    }
  }

}