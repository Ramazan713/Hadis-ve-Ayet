

enum PrayerTypeEnum{
  prayerInQuran(
    typeId: 1
  ),
  prayerAndVerses(
      typeId: 2
  ),
  dhikr(
      typeId: 3
  ),
  custom(
      typeId: 4
  );

  const PrayerTypeEnum({required this.typeId});

  final int typeId;

  static PrayerTypeEnum fromTypeId(int typeId){

    if(typeId == PrayerTypeEnum.prayerInQuran.typeId){
      return PrayerTypeEnum.prayerInQuran;
    }
    else if(typeId == PrayerTypeEnum.prayerAndVerses.typeId){
      return PrayerTypeEnum.prayerAndVerses;
    }
    else if(typeId == PrayerTypeEnum.dhikr.typeId){
      return PrayerTypeEnum.dhikr;
    }
    return PrayerTypeEnum.custom;
  }
}