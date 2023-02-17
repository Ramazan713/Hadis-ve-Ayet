

import 'package:hadith/features/extra_features/quran_prayer/domain/model/quran_prayer.dart';

import '../../domain/repo/quran_prayer_repo.dart';
import '../quran_prayer_dao.dart';

class QuranPrayerRepoImpl extends QuranPrayerRepo{
  late final QuranPrayerDao _prayerDao;
  QuranPrayerRepoImpl({required QuranPrayerDao quranPrayerDao}){
    _prayerDao = quranPrayerDao;
  }

  @override
  Future<List<QuranPrayer>> getQuranPrayers() async{
    return (await _prayerDao.getQuranPrayers()).map((e) => e.toQuranPrayer()).toList();
  }
}