
import 'package:hadith/core/features/verses/domain/model/surah.dart';
import 'package:hadith/core/features/verses/domain/model/verse_number.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_quran_data/prayer_quran_data.dart';

abstract class PrayerCustomByQuranRepo{

  Future<PrayerQuranData> getQuranData({
    required int surahId,
    required int firstItemIndex,
    required int lastItemIndex
  });

  Future<Resource<void>> insertCustomPrayer({
    required Surah surah,
    required List<VerseNumber> validVerseNumbers,
    required VerseNumber? firstVerseNumber,
    required VerseNumber? lastVerseNumber,
    required String name
  });
}