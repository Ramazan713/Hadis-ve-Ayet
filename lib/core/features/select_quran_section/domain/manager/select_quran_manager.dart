
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_content/select_quran_content.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_init_model/select_quran_init_model.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_model/select_quran_model.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_load_config/select_quran_section_load_config.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/verse_number.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';


abstract class SelectQuranManager{

  Future<SelectQuranInitModel> getInitModel();

  Future<SelectQuranModel?> loadInit({
    required SelectQuranSectionLoadConfig loadConfig,
    List<Surah> surahes = const []
  });

  Future<SelectQuranModel> selectCuz({
    required Cuz currentCuz,
    int? currentPage,
    Surah? currentSurah,
    VerseNumber? currentFirstVerseNumber,
    VerseNumber? currentLastVerseNumber
  });

  Future<SelectQuranModel> selectSurah({
    required Surah currentSurah,
    Cuz? currentCuz,
    int? currentPage,
    VerseNumber? currentFirstVerseNumber,
    VerseNumber? currentLastVerseNumber
  });

  Future<SelectQuranModel> selectVerse({
    required VerseNumber currentVerseNumber,
    Surah? currentSurah,
    Cuz? currentCuz,
    int? currentPage,
  });

  Future<SelectQuranModel> selectPage({
    required int currentPage,
    VerseNumber? currentFirstVerseNumber,
    VerseNumber? currentLastVerseNumber,
    Surah? currentSurah,
    Cuz? currentCuz,
  });

  Future<SelectQuranContent> getQuranData({
    required int surahId,
    required int firstItemIndex,
    required int lastItemIndex,
    bool includeSelectedVerses = false
  });

  Future<SelectQuranContent> getQuranData2({
    required int surahId,
    required VerseNumber firstVerseNumber,
    required VerseNumber lastVerseNumber,
    required List<VerseNumber> validVerseNumbers,
    bool includeSelectedVerses = false
  });
}