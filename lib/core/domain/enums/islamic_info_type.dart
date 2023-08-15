

enum IslamicInfoType{
  none(
    typeId: 0,
    title: "None"
  ),
  adjectivesOfAllah(
      typeId: 1,
      title: "Allah'ın Sıfatları"
  ),
  fards32(
      typeId: 2,
      title: "32 Farz"
  ),
  fards54(
      typeId: 3,
      title: "54 Farz"
  ),
  efaliMukellefin(
      typeId: 4,
      title: "Ef’âl-i mükellefîn"
  );

  const IslamicInfoType({required this.typeId, required this.title});

  final int typeId;

  final String title;

  static IslamicInfoType from(int typeId){

    if(typeId == IslamicInfoType.adjectivesOfAllah.typeId){
      return IslamicInfoType.adjectivesOfAllah;
    }
    else if(typeId == IslamicInfoType.fards32.typeId){
      return IslamicInfoType.fards32;
    }
    else if(typeId == IslamicInfoType.fards54.typeId){
      return IslamicInfoType.fards54;
    }
    else if(typeId == IslamicInfoType.efaliMukellefin.typeId){
      return IslamicInfoType.efaliMukellefin;
    }
    return IslamicInfoType.none;
  }
}
