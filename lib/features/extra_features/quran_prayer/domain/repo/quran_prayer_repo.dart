

import 'package:hadith/features/extra_features/quran_prayer/domain/model/quran_prayer.dart';

abstract class QuranPrayerRepoOld{
  Future<List<QuranPrayer>> getQuranPrayers();
}