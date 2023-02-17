

import 'package:hadith/features/extra_features/prayer_surah/domain/model/prayer.dart';

abstract class PrayerRepo{

  Future<List<Prayer>> getPrayers();
  Future<Prayer?> getPrayerWithId(int id);

}