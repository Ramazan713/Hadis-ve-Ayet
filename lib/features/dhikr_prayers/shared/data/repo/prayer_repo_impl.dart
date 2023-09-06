
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
    return (await _prayerDao.getPrayersWithTypeId(PrayerTypeEnum.prayerAndVerses.typeId))
        .map((e) => e.tryToPrayerAndVerse()).whereNotNull().toList();
  }

  @override
  Future<PrayerAndVerse?> getPrayerAndVerseById(int id) async{
    return (await _prayerDao.getPrayersWithId(id))?.tryToPrayerAndVerse();
  }



  @override
  Future<List<PrayerDhikr>> getPrayerDhikrs() async{
    return (await _prayerDao.getPrayersWithTypeId(PrayerTypeEnum.dhikr.typeId))
        .map((e) => e.tryToPrayerDhikr()).whereNotNull().toList();
  }

  @override
  Future<PrayerDhikr?> getPrayerDhikrById(int id) async{
    return (await _prayerDao.getPrayersWithId(id))?.tryToPrayerDhikr();
  }



  @override
  Future<List<PrayerInQuran>> getPrayerInQurans() async{
    return (await _prayerDao.getPrayersWithTypeId(PrayerTypeEnum.prayerInQuran.typeId))
        .map((e) => e.tryToPrayInQuran()).whereNotNull().toList();
  }

  @override
  Future<List<PrayerInQuran>> getSearchedPrayersInQuran(String query, SearchCriteriaEnum criteria) async{
    final queryExp = criteria.getQuery(query);
    final List<PrayerEntity> entities;
    if(criteria.isRegex){
      entities = await _prayerDao.getPrayersSearchedRegExWithTypeId(PrayerTypeEnum.prayerInQuran.typeId, queryExp);
    }else{
      entities = await _prayerDao.getPrayersSearchedLikeWithTypeId(PrayerTypeEnum.prayerInQuran.typeId, queryExp);
    }
    return entities.map((e) => e.tryToPrayInQuran()).whereNotNull().toList();
  }
}