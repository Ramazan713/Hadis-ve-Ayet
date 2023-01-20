

enum AudioManageEnum{
  cuz,surah
}

extension AudioManageEnumEx on AudioManageEnum{
  String get description{
    switch(this){
      case AudioManageEnum.surah:
        return "Sure";
      case AudioManageEnum.cuz:
        return "Cuz";
    }
  }
}