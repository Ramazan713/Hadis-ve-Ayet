
import 'package:collection/collection.dart';
import 'package:hadith/core/data/local/entities/prayer_entity.dart';
import 'package:hadith/core/data/local/services/prayer_dao.dart';
import 'package:hadith/core/domain/enums/search_criteria_enum.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/mapper/prayer_mapper.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/enums/prayer_type_enum.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_and_verse.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_dhikr.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_in_quran.dart';
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
  Stream<PrayerAndVerse?> getStreamPrayerAndVerseById(int id){
    return _prayerDao.getStreamPrayersWithId(id)
        .map((e) => e?.tryToPrayerAndVerse());
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
  Stream<List<PrayerInQuran>> getStreamPrayerInQurans(){
    return (_prayerDao.getStreamPrayersWithTypeIdOrderByAsc(PrayerTypeEnum.prayerInQuran.typeId))
        .map((items) => items.map((e) => e.tryToPrayInQuran()).whereNotNull().toList());
  }

  @override
  Stream<List<PrayerInQuran>> getSearchedPrayersInQuran(String query, SearchCriteriaEnum criteria){
    final queryExp = criteria.getQuery(query);
    final Stream<List<PrayerEntity>> streamEntities;
    if(criteria.isRegex){
      streamEntities = _prayerDao.getStreamPrayersSearchedRegExWithTypeId(PrayerTypeEnum.prayerInQuran.typeId, queryExp);
    }else{
      streamEntities = _prayerDao.getStreamPrayersSearchedLikeWithTypeId(PrayerTypeEnum.prayerInQuran.typeId, queryExp);
    }
    return streamEntities.map((items) => items.map((e) => e.tryToPrayInQuran()).whereNotNull().toList());
  }

  @override
  Future<void> insertCustomPrayerWithRelationForPrayerVerse(PrayerAndVerse prayer) async{
    final parentPrayer = prayer.toPrayerCustom().copyWith(id: null).toPrayerEntity();
    final childPrayer = prayer.toPrayerEntity();
    await _prayerDao.insertPrayerWithRelation(childPrayer, parentPrayer);
  }

  @override
  Future<void> insertCustomPrayerWithRelationForPrayerQuran(PrayerInQuran prayer) async{
    final parentPrayer = prayer.toPrayerCustom().copyWith(id: null).toPrayerEntity();
    final childPrayer = prayer.toPrayerEntity();
    await _prayerDao.insertPrayerWithRelation(childPrayer, parentPrayer);
  }
}