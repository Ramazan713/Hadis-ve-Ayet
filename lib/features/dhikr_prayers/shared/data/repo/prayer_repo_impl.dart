
import 'package:collection/collection.dart';
import 'package:hadith/core/data/local/entities/prayer_entity.dart';
import 'package:hadith/core/data/local/services/prayer_dao.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/mapper/prayer_and_verse_mapper.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/mapper/prayer_custom_mapper.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/mapper/prayer_entity_mapper.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/mapper/prayer_in_quran_mapper.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/mapper/prayer_verse_mapper.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/enums/prayer_type_enum.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse/prayer_and_verse.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr/prayer_dhikr.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran/prayer_in_quran.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_unit.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_repo.dart';

class PrayerRepoImpl extends PrayerRepo{

  late final PrayerDao _prayerDao;

  PrayerRepoImpl({
    required PrayerDao prayerDao,
  }){
    _prayerDao = prayerDao;
  }

  @override
  Future<List<PrayerAndVerse>> getPrayerAndVerses() async{
    return (await _prayerDao.getPrayersWithTypeIdOrderByAsc(PrayerTypeEnum.prayerAndVerses.typeId))
        .map((e) => e.tryToPrayerAndVerse()).whereNotNull().toList();
  }

  @override
  Stream<PrayerUnit<PrayerAndVerse>?> getStreamPrayerAndVerseUnitById(int id){
    return _prayerDao.getStreamPrayersWithId(id)
        .asyncMap((e) => _getPrayerUnit(entity: e,onTransform: (e)=>e.tryToPrayerAndVerse()));
  }



  @override
  Future<List<PrayerDhikr>> getPrayerDhikrs() async{
    return (await _prayerDao.getPrayersWithTypeIdOrderByAsc(PrayerTypeEnum.dhikr.typeId))
        .map((e) => e.tryToPrayerDhikr()).whereNotNull().toList();
  }

  @override
  Future<PrayerDhikr?> getPrayerDhikrById(int id) async{
    return (await _prayerDao.getPrayersWithId(id))?.tryToPrayerDhikr();
  }



  @override
  Stream<List<PrayerUnit<PrayerInQuran>>> getStreamPrayerInQuranUnits(){
    return (_prayerDao.getStreamPrayersWithTypeIdOrderByAsc(PrayerTypeEnum.prayerInQuran.typeId))
        .asyncMap((items) => _getPrayerUnits(prayerEntities: items, onTransform: (e) => e.tryToPrayInQuran()));
  }

  @override
  Stream<List<PrayerUnit<PrayerInQuran>>> getSearchedPrayerInQuranUnits(String query, SearchCriteriaEnum criteria){
    final queryExp = criteria.getQuery(query);
    final Stream<List<PrayerEntity>> streamEntities;
    if(criteria.isRegex){
      streamEntities = _prayerDao.getStreamPrayersSearchedRegExWithTypeId(PrayerTypeEnum.prayerInQuran.typeId, queryExp);
    }else{
      streamEntities = _prayerDao.getStreamPrayersSearchedLikeWithTypeId(PrayerTypeEnum.prayerInQuran.typeId, queryExp);
    }
    return streamEntities.asyncMap((items) => _getPrayerUnits(prayerEntities: items, onTransform: (e)=> e.tryToPrayInQuran()));
  }

  @override
  Future<void> insertCustomPrayerWithRelationForPrayerVerse(PrayerUnit<PrayerAndVerse> prayerUnit) async{
    final prayer = prayerUnit.item;
    final parentPrayer = prayer.toPrayerCustom().copyWith(id: null).toPrayerEntity();
    final childPrayer = prayer.toPrayerEntity();
    await _prayerDao.insertPrayerWithRelation(childPrayer, parentPrayer, prayerUnit.getVerseIds);
  }

  @override
  Future<void> insertCustomPrayerWithRelationForPrayerQuran(PrayerUnit<PrayerInQuran> prayerUnit) async{
    final prayer = prayerUnit.item;
    final parentPrayer = prayer.toPrayerCustom().copyWith(id: null).toPrayerEntity();
    final childPrayer = prayer.toPrayerEntity();
    await _prayerDao.insertPrayerWithRelation(childPrayer, parentPrayer,prayerUnit.getVerseIds);
  }

  Future<List<PrayerUnit<T>>> _getPrayerUnits<T>({
    required List<PrayerEntity> prayerEntities,
    required T? Function(PrayerEntity) onTransform
  })async{
    final items = <PrayerUnit<T>>[];

    for(final entity in prayerEntities){
      final item = await _getPrayerUnit(entity: entity, onTransform: onTransform);
      if(item == null) continue;
      items.add(item);
    }
    return items;
  }

  Future<PrayerUnit<T>?> _getPrayerUnit<T>({
    required PrayerEntity? entity,
    required T? Function(PrayerEntity) onTransform
  })async{
    if(entity == null) return null;
    final prayer = onTransform(entity);
    if(prayer == null) return null;
    final prayerVerseEntities = await _prayerDao.getPrayerVerseByPrayerId(entity.id ?? 0);
    final prayerVerses = prayerVerseEntities.map((e) => e.toPrayerVerseCrossRef()).toList();
    return PrayerUnit(item: prayer, prayerVerses: prayerVerses);
  }

}