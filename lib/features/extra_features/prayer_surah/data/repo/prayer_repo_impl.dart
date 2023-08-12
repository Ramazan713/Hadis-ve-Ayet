

import 'package:hadith/features/extra_features/prayer_surah/data/prayer_dao.dart';
import 'package:hadith/features/extra_features/prayer_surah/domain/model/prayer.dart';
import 'package:hadith/features/extra_features/prayer_surah/domain/repo/prayer_repo.dart';

class PrayerRepoImpl extends PrayerRepo{
  late final PrayerDaoOld _prayerDao;

  PrayerRepoImpl({required PrayerDaoOld prayerDao}){
    _prayerDao = prayerDao;
  }

  @override
  Future<Prayer?> getPrayerWithId(int id) async{
    return (await _prayerDao.getPrayerWithId(id))?.toPrayer();
  }

  @override
  Future<List<Prayer>> getPrayers() async{
    return (await _prayerDao.getPrayers()).map((e) => e.toPrayer()).toList();
  }

}