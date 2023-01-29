
enum TopicSavePointEnum{
  topic,surah,cuz
}

extension TopicSavePointExt on TopicSavePointEnum{
  int get type{
    switch(this){
      case TopicSavePointEnum.cuz:
        return 1;
      case TopicSavePointEnum.topic:
        return 2;
      case TopicSavePointEnum.surah:
        return 3;
    }
  }
  static TopicSavePointEnum fromType(int type){
    switch(type){
      case 1:
        return TopicSavePointEnum.cuz;
      case 2:
        return TopicSavePointEnum.topic;
      case 3:
        return TopicSavePointEnum.surah;
      default:
        return TopicSavePointEnum.topic;
    }
  }

  String get defaultParentKey{
    switch(this){
      case TopicSavePointEnum.cuz:
        return "cuz";
      case TopicSavePointEnum.topic:
        return "topic";
      case TopicSavePointEnum.surah:
        return "surah";
    }
  }

}