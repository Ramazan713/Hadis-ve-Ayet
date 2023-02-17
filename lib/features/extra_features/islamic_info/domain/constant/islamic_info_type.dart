

enum IslamicInfoType{
  none,adjectivesOfAllah,fards32,fards54,efaliMukellefin
}

extension IslamicInfoExt on IslamicInfoType{

  int get typeId{
    switch(this){
      case IslamicInfoType.none:
        return 0;
      case IslamicInfoType.adjectivesOfAllah:
        return 1;
      case IslamicInfoType.fards32:
        return 2;
      case IslamicInfoType.fards54:
        return 3;
      case IslamicInfoType.efaliMukellefin:
        return 4;
    }
  }

  String get title{
    switch(this){
      case IslamicInfoType.none:
        return "None";
      case IslamicInfoType.adjectivesOfAllah:
        return "Allah'ın Sıfatları";
      case IslamicInfoType.fards32:
        return "32 Farz";
      case IslamicInfoType.fards54:
        return  "54 Farz";
      case IslamicInfoType.efaliMukellefin:
        return "Ef’âl-i mükellefîn";
    }
  }

  static IslamicInfoType fromTypeId(int typeId){
    switch(typeId){
      case 1:
        return IslamicInfoType.adjectivesOfAllah;
      case 2:
        return IslamicInfoType.fards32;
      case 3:
        return IslamicInfoType.fards54;
      case 4:
        return IslamicInfoType.efaliMukellefin;
    }
    return IslamicInfoType.none;
  }
}
