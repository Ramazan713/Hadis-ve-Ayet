
import 'package:hadith/core/data/local/entities/counter_entity.dart';
import 'package:hadith/core/data/local/entities/prayer_entity.dart';
import 'package:hadith/features/dhikr_prayers/counters/domain/enums/counter_type.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/enums/prayer_type_enum.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran.dart';

extension PrayerEntityExt on PrayerEntity{

  CounterEntity toCounterEntity({
    required int orderItem,
    int? id,
    int lastCounter = 0,
    int? typeId,
    int? goal
  }){
    return CounterEntity(
      id: id,
      name: name ?? "",
      orderItem: orderItem,
      lastCounter: lastCounter,
      typeId: typeId ?? CounterType.classic.typeId,
      meaning: meaningContent,
      content: pronunciationContent,
      arabicContent: arabicContent,
      description: source,
      goal: goal
    );
  }

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


extension PrayerCustomExt on PrayerCustom{

  PrayerEntity toPrayerEntity(){
    return PrayerEntity(
      id: id,
      name: name,
      arabicContent: arabicContent,
      meaningContent: meaningContent,
      pronunciationContent: pronunciationContent,
      orderItem: orderItem,
      source: source,
      isRemovable: true,
      typeId: PrayerTypeEnum.custom.typeId,
      counterId: counterId,
      updateCounter: updateCounter,
      parentPrayerId: parentPrayerId
    );
  }
}

extension PrayerAndVerseExt on PrayerAndVerse{

  PrayerCustom toPrayerCustom(){
    return PrayerCustom(
      id: id,
      name: name,
      arabicContent: arabicContent,
      meaningContent: meaningContent,
      pronunciationContent: pronunciationContent,
      orderItem: orderItem,
      counterId: counterId,
      updateCounter: false,
      parentPrayerId: parentPrayerId
    );
  }

  PrayerEntity toPrayerEntity(){
    return PrayerEntity(
        id: id,
        name: name,
        arabicContent: arabicContent,
        meaningContent: meaningContent,
        pronunciationContent: pronunciationContent,
        orderItem: orderItem,
        isRemovable: false,
        typeId: PrayerTypeEnum.prayerAndVerses.typeId,
        counterId: counterId,
        parentPrayerId: parentPrayerId,
        source: null,
        updateCounter: false
    );
  }
}


extension PrayerInQuranExt on PrayerInQuran{

  PrayerCustom toPrayerCustom(){
    return PrayerCustom(
      id: id,
      name: "$source - Kuran'da geçen dua ayetleri",
      arabicContent: arabicContent,
      meaningContent: meaningContent,
      orderItem: orderItem,
      counterId: counterId,
      updateCounter: false,
      parentPrayerId: parentPrayerId,
      source: source,
    );
  }

  PrayerEntity toPrayerEntity(){
    return PrayerEntity(
      id: id,
      name: null,
      arabicContent: arabicContent,
      meaningContent: meaningContent,
      pronunciationContent: null,
      orderItem: orderItem,
      isRemovable: false,
      typeId: PrayerTypeEnum.prayerInQuran.typeId,
      counterId: counterId,
      parentPrayerId: parentPrayerId,
      source: source,
      updateCounter: false
    );
  }
}


