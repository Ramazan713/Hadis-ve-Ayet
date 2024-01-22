import 'package:hadith/core/data/local/entities/prayer_entity.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/enums/prayer_type_enum.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse/prayer_and_verse.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr/prayer_dhikr.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran/prayer_in_quran.dart';

extension PrayerEntityExt on PrayerEntity{

  PrayerCustom? tryToPrayerCustom(){
    if(typeId != PrayerTypeEnum.custom.typeId) return null;
    if( name == null) return null;
    return PrayerCustom(
      id: id,
      source: source,
      orderItem: orderItem,
      meaningContent: meaningContent,
      arabicContent: arabicContent,
      name: name  ?? "",
      pronunciationContent: pronunciationContent,
      counterId: counterId,
      updateCounter: updateCounter,
      parentPrayerId: parentPrayerId
    );
  }

  PrayerInQuran? tryToPrayInQuran(){
    if(typeId != PrayerTypeEnum.prayerInQuran.typeId) return null;
    if(id == null || source == null || meaningContent == null || arabicContent == null) return null;
    return PrayerInQuran(
      id: id ?? 0,
      source: source ?? "",
      orderItem: orderItem,
      meaningContent: meaningContent ?? "",
      arabicContent: arabicContent ?? "",
      counterId: counterId,
      parentPrayerId: parentPrayerId
    );
  }

  PrayerAndVerse? tryToPrayerAndVerse(){
    if(typeId != PrayerTypeEnum.prayerAndVerses.typeId) return null;
    if(id == null || name == null || meaningContent == null || arabicContent == null) return null;
    return PrayerAndVerse(
        id: id ?? 0,
        orderItem: orderItem,
        meaningContent: meaningContent ?? "",
        arabicContent: arabicContent ?? "",
        name: name ?? "",
        pronunciationContent: pronunciationContent,
        counterId: counterId,
        parentPrayerId: parentPrayerId
    );
  }

  PrayerDhikr? tryToPrayerDhikr(){
    if(typeId != PrayerTypeEnum.dhikr.typeId) return null;
    if(id == null || name == null || meaningContent == null || arabicContent == null || pronunciationContent == null) return null;
    return PrayerDhikr(
        id: id ?? 0,
        name: name ?? "",
        pronunciationContent: pronunciationContent ?? "",
        orderItem: orderItem,
        meaningContent: meaningContent ?? "",
        arabicContent: arabicContent ?? "",
        counterId: counterId,
    );
  }
}

