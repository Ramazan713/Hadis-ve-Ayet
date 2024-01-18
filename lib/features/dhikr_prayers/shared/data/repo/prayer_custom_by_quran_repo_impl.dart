import 'package:collection/collection.dart';
import 'package:hadith/core/data/local/entities/prayer_verse_entity.dart';
import 'package:hadith/core/data/local/entities/verse_arabic_entity.dart';
import 'package:hadith/core/data/local/entities/verse_entity.dart';
import 'package:hadith/core/data/local/services/prayer_dao.dart';
import 'package:hadith/core/data/local/services/verse/verse_arabic_dao.dart';
import 'package:hadith/core/data/local/services/verse/verse_dao.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';
import 'package:hadith/core/features/verses/domain/model/verse_number.dart';
import 'package:hadith/core/utils/resource.dart';
import 'package:hadith/features/dhikr_prayers/shared/data/mapper/prayer_custom_mapper.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_custom/prayer_custom.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/model/prayer_quran_data/prayer_quran_data.dart';
import 'package:hadith/features/dhikr_prayers/shared/domain/repo/prayer_custom_by_quran_repo.dart';

class PrayerCustomByQuranRepoImpl extends PrayerCustomByQuranRepo{
  late final VerseDao _verseDao;
  late final VerseArabicDao _verseArabicDao;
  late final PrayerDao _prayerDao;

  PrayerCustomByQuranRepoImpl({
    required VerseDao verseDao,
    required VerseArabicDao verseArabicDao,
    required PrayerDao prayerDao
  }){
    _verseDao = verseDao;
    _verseArabicDao = verseArabicDao;
    _prayerDao = prayerDao;
  }


  @override
  Future<PrayerQuranData> getQuranData({
    required int surahId,
    required int firstItemIndex,
    required int lastItemIndex
  }) async{
    final data = await _getData(surahId: surahId, firstItemIndex: firstItemIndex, lastItemIndex: lastItemIndex);
    return PrayerQuranData(arabicContent: data.arabicContent, meaningContent: data.meaningContent);
  }

  @override
  Future<Resource<void>> insertCustomPrayer({
    required Surah surah,
    required List<VerseNumber> validVerseNumbers,
    required VerseNumber? firstVerseNumber,
    required VerseNumber? lastVerseNumber,
    required String name
  }) async {
    try{
      final indexData = _getIndexResult(
          validVerseNumbers: validVerseNumbers,
          firstVerseNumber: firstVerseNumber,
          lastVerseNumber: lastVerseNumber
      );
      final data = await _getData(
          surahId: surah.id,
          firstItemIndex: indexData.firstItemIndex,
          lastItemIndex: indexData.lastItemIndex
      );

      final prayerEntity = PrayerCustom(
          name: name,
          arabicContent: data.arabicContent,
          meaningContent: data.meaningContent,
          source: "${surah.name} ${firstVerseNumber?.text}-${lastVerseNumber?.text}"
      ).toPrayerEntity();

      final prayerId = await _prayerDao.insertPrayerWithOrder(prayerEntity);

      final prayerVerseEntities = data.verseEntities.map((e) => e.id!)
          .sorted((a, b) => a.compareTo(b))
          .mapIndexed((index,verseId) => PrayerVerseEntity(id: null, verseId: verseId, prayerId: prayerId, orderItem: index + 1))
          .toList();

      await _prayerDao.insertPrayerVerses(prayerVerseEntities);
      return Resource.success(null);
    }catch(e){
      return ResourceError(e.toString());
    }
  }

  Future<_QuranDataResponse> _getData({
    required int surahId,
    required int firstItemIndex,
    required int lastItemIndex
  }) async {
    final size = (lastItemIndex - firstItemIndex) + 1;

    final verseEntities = await _verseDao.getVersesByOffsetAndSurah(surahId, size, firstItemIndex);
    final arabicVerseEntities = await _verseArabicDao.getArabicVersesByMealIds(verseEntities.map((e) => e.id!).toList());

    final arabicContent = "${arabicVerseEntities.map((e) => e.verse).join(" ﴿﴾ ")} ﴿﴾ ";
    final meaningContent = verseEntities.map((e) => e.content).join(" ");

    return _QuranDataResponse(
        arabicContent: arabicContent,
        meaningContent: meaningContent,
        verseEntities: verseEntities
    );
  }


  _IndexResult _getIndexResult({
    required List<VerseNumber> validVerseNumbers,
    required VerseNumber? firstVerseNumber,
    required VerseNumber? lastVerseNumber
  }){
    if(firstVerseNumber == null || lastVerseNumber == null) {
      return _IndexResult(firstItemIndex: 0, lastItemIndex: 0);
    }
    final firstIndex = validVerseNumbers.indexWhere((element) => element.text == firstVerseNumber.text);
    final lastIndex = validVerseNumbers.indexWhere((element) => element.text == lastVerseNumber.text);

    if(firstIndex == -1 || lastIndex == -1){
      return _IndexResult(firstItemIndex: 0, lastItemIndex: 0);
    }
    return _IndexResult(firstItemIndex: firstIndex, lastItemIndex: lastIndex);
  }

}



class _IndexResult{
  final int firstItemIndex;
  final int lastItemIndex;
  _IndexResult({
    required this.firstItemIndex,
    required this.lastItemIndex
  });
}

class _QuranDataResponse{
  final String arabicContent;
  final String meaningContent;
  final List<VerseEntity> verseEntities;
  _QuranDataResponse({
    required this.arabicContent,
    required this.meaningContent,
    required this.verseEntities
  });
}




