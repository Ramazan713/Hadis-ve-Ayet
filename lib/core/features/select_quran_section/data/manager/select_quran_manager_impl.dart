import 'package:collection/collection.dart';
import 'package:hadith/core/data/local/services/surah_dao.dart';
import 'package:hadith/core/data/local/services/verse/verse_arabic_dao.dart';
import 'package:hadith/core/data/local/services/verse/verse_dao.dart';
import 'package:hadith/core/data/mapper/verse/verse_mapper.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/core/features/select_quran_section/domain/manager/select_quran_manager.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_content/select_quran_content.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_init_model/select_quran_init_model.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_model/select_quran_model.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/select_quran_section_load_config/select_quran_section_load_config.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/verse_number.dart';
import 'package:hadith/core/features/select_quran_section/domain/repo/select_quran_page_repo.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';

class SelectQuranManagerImpl extends SelectQuranManager{
  late final SelectQuranPageRepo _versePageRepo;
  late final VerseDao _verseDao;
  late final VerseArabicDao _verseArabicDao;
  late final SurahDao _surahDao;

  SelectQuranManagerImpl({
    required SelectQuranPageRepo selectVersePageRepo,
    required VerseDao verseDao,
    required VerseArabicDao verseArabicDao,
    required SurahDao surahDao
  }){
    _versePageRepo = selectVersePageRepo;
    _verseDao = verseDao;
    _verseArabicDao = verseArabicDao;
    _surahDao = surahDao;
  }

  @override
  Future<SelectQuranInitModel> getInitModel() async{
    final cuzs = await _versePageRepo.getCuzs();
    final surahes = await _versePageRepo.getSurahes();
    final pageMaxPos = await _versePageRepo.getMaxPage();
    final validVerseNumbers = await _getVerseNumbers(surahes.firstOrNull);
    final quranData = await getQuranData(surahId: 1, firstItemIndex: 0, lastItemIndex: 0);

    return SelectQuranInitModel(
      cuzs: cuzs,
      surahes: surahes,
      currentVerseNumbers: validVerseNumbers,
      pageMaxPos: pageMaxPos,
      meaningContent: quranData.meaningContent,
      arabicContent: quranData.arabicContent
    );
  }

  @override
  Future<SelectQuranModel?> loadInit({
    required SelectQuranSectionLoadConfig loadConfig,
    List<Surah> surahes = const []
  }) async{
    final surahId = loadConfig.surahId;
    final page = loadConfig.page;
    final firstVerseNumber = loadConfig.firstVerseNumber;
    final lastVerseNumber = loadConfig.lastVerseNumber;

    if(surahId != null){
      if(surahes.isEmpty){
        surahes = await _versePageRepo.getSurahes();
      }

      final surah = surahes.firstWhereOrNull((e) => e.id == surahId);
      if(surah == null) return null;

      return selectSurah(
        currentSurah: surah,
        currentFirstVerseNumber: firstVerseNumber != null ? VerseNumber(text: firstVerseNumber) : null,
        currentLastVerseNumber: lastVerseNumber != null ? VerseNumber(text: lastVerseNumber) : null,
        currentPage: page ?? 1,
      );
    }

    if(page != null){
      return selectPage(
        currentPage: page,
        currentFirstVerseNumber: firstVerseNumber != null ? VerseNumber(text: firstVerseNumber) : null,
        currentLastVerseNumber: lastVerseNumber != null ? VerseNumber(text: lastVerseNumber) : null,
      );
    }

    return null;
  }

  @override
  Future<SelectQuranModel> selectCuz({
    required Cuz currentCuz,
    int? currentPage,
    Surah? currentSurah,
    VerseNumber? currentFirstVerseNumber,
    VerseNumber? currentLastVerseNumber
  }) async{
    final selectedSurah = await _versePageRepo.validateSurahByCuzNo(currentSurah, currentCuz.no);
    final selectedFirstVerseNumber = await _versePageRepo.validateVerseNumber(currentFirstVerseNumber?.text ?? "", selectedSurah?.id ?? 0, currentCuz.no);
    final selectedLastVerseNumber = await _versePageRepo.validateLastVerseNumber(selectedFirstVerseNumber ?? "", currentLastVerseNumber?.text ?? "", selectedSurah?.id ?? 0);
    final selectedPage = await _currentPageOrExecute(currentPage, (page){
      return _versePageRepo.validatePageBySurah(page, selectedSurah?.id ?? 0, selectedFirstVerseNumber ?? "");
    }) ?? 1;

    final validVerseNumbers = await _getVerseNumbers(selectedSurah);

    return SelectQuranModel(
      cuz: currentCuz,
      surah: selectedSurah,
      firstVerseNumber: VerseNumber(text: selectedFirstVerseNumber ?? ""),
      lastVerseNumber: VerseNumber(text: selectedLastVerseNumber ?? ""),
      validVerseNumbers: validVerseNumbers,
      page: selectedPage
    );
  }

  @override
  Future<SelectQuranModel> selectSurah({
    required Surah currentSurah,
    Cuz? currentCuz,
    int? currentPage,
    VerseNumber? currentFirstVerseNumber,
    VerseNumber? currentLastVerseNumber
  }) async {
    final selectedCuz = await _versePageRepo.validateCuzBySurah(currentCuz, currentSurah.id, currentFirstVerseNumber?.text ?? "");
    final selectedFirstVerseNumber = await _versePageRepo.validateVerseNumber(currentFirstVerseNumber?.text ?? "", currentSurah.id, selectedCuz?.no ?? 0);
    final selectedLastVerseNumber = await _versePageRepo.validateLastVerseNumber(selectedFirstVerseNumber ?? "", currentLastVerseNumber?.text ?? "", currentSurah.id);

    final selectedPage = await _currentPageOrExecute(currentPage, (page){
      return _versePageRepo.validatePageBySurah(page, currentSurah.id, selectedFirstVerseNumber ?? "");
    }) ?? 1;
    final validVerseNumbers = await _getVerseNumbers(currentSurah);

    return SelectQuranModel(
      cuz: selectedCuz,
      surah: currentSurah,
      firstVerseNumber: VerseNumber(text: selectedFirstVerseNumber ?? ""),
      lastVerseNumber: VerseNumber(text: selectedLastVerseNumber ?? ""),
      validVerseNumbers: validVerseNumbers,
      page: selectedPage
    );
  }

  @override
  Future<SelectQuranModel> selectVerse({
    required VerseNumber currentVerseNumber,
    Surah? currentSurah,
    Cuz? currentCuz,
    int? currentPage,
  }) async {
    final selectedCuz = await _versePageRepo.validateCuzBySurah(currentCuz, currentSurah?.id ?? 0, currentVerseNumber.text);
    final selectedPage = await _currentPageOrExecute(currentPage, (page){
      return _versePageRepo.validatePageBySurah(page, currentSurah?.id ?? 0, currentVerseNumber.text);
    }) ?? 1;
    final validVerseNumbers = await _getVerseNumbers(currentSurah);

    return SelectQuranModel(
        cuz: selectedCuz,
        surah: currentSurah,
        firstVerseNumber: currentVerseNumber,
        lastVerseNumber: currentVerseNumber,
        validVerseNumbers: validVerseNumbers,
        page: selectedPage
    );
  }

  @override
  Future<SelectQuranModel> selectPage({
    required int currentPage,
    VerseNumber? currentFirstVerseNumber,
    VerseNumber? currentLastVerseNumber,
    Surah? currentSurah,
    Cuz? currentCuz,
  }) async {
    final selectedCuz = await _versePageRepo.validateCuzByPageNo(currentCuz, currentPage);
    final selectedSurah = await _versePageRepo.validateSurahByPageNo(currentSurah, currentPage);
    final selectedFirstVerseNumber = await _versePageRepo.validateVerseNumberWithPage(currentFirstVerseNumber?.text ?? "",selectedSurah?.id ?? 0, selectedCuz?.no ?? 0, currentPage);
    final selectedLastVerseNumber = await _versePageRepo.validateLastVerseNumber(selectedFirstVerseNumber ?? "", currentLastVerseNumber?.text ?? "", selectedSurah?.id ?? 0);

    final validVerseNumbers = await _getVerseNumbers(selectedSurah);

    return SelectQuranModel(
      cuz: selectedCuz,
      surah: selectedSurah,
      firstVerseNumber: VerseNumber(text: selectedFirstVerseNumber ?? ""),
      lastVerseNumber: VerseNumber(text: selectedLastVerseNumber ?? ""),
      validVerseNumbers: validVerseNumbers,
      page: currentPage
    );
  }


  @override
  Future<SelectQuranContent> getQuranData({
    required int surahId,
    required int firstItemIndex,
    required int lastItemIndex,
    bool includeSelectedVerses = false
  }) async{
    final data = await _getData(
      surahId: surahId,
      firstItemIndex: firstItemIndex,
      lastItemIndex: lastItemIndex,
      includeSelectedVerses: includeSelectedVerses
    );
    return SelectQuranContent(
      arabicContent: data.arabicContent,
      meaningContent: data.meaningContent,
      verses: data.verses
    );
  }

  @override
  Future<SelectQuranContent> getQuranData2({
    required int surahId,
    required VerseNumber firstVerseNumber,
    required VerseNumber lastVerseNumber,
    required List<VerseNumber> validVerseNumbers,
    bool includeSelectedVerses = false
  }) async{
    final indexData = _getIndexResult(
        validVerseNumbers: validVerseNumbers,
        firstVerseNumber: firstVerseNumber,
        lastVerseNumber: lastVerseNumber
    );

    final data = await _getData(
      surahId: surahId,
      firstItemIndex: indexData.firstItemIndex,
      lastItemIndex: indexData.lastItemIndex,
      includeSelectedVerses: includeSelectedVerses
    );
    return SelectQuranContent(
      arabicContent: data.arabicContent,
      meaningContent: data.meaningContent,
      verses: data.verses
    );
  }



  Future<List<VerseNumber>> _getVerseNumbers(Surah? surah)async{
    final verseNumbersStr = await _versePageRepo.getVerseNumbers(surah?.id ?? 1);
    final verseNumbers = VerseNumber.from(verseNumbersStr);
    return verseNumbers;
  }

  Future<int?> _currentPageOrExecute(int? currentPage, Future<int?> Function(int) onExecute) async{
    if(currentPage == null) return null;
    return onExecute(currentPage);
  }

  Future<_QuranDataResponse> _getData({
    required int surahId,
    required int firstItemIndex,
    required int lastItemIndex,
    bool includeSelectedVerses = false
  }) async {
    final size = (lastItemIndex - firstItemIndex) + 1;

    final verseEntities = await _verseDao.getVersesByOffsetAndSurah(surahId, size, firstItemIndex);
    final arabicVerseEntities = await _verseArabicDao.getArabicVersesByMealIds(verseEntities.map((e) => e.id!).toList());

    final arabicContent = "${arabicVerseEntities.map((e) => e.verse).join(" ﴿﴾ ")} ﴿﴾ ";
    final meaningContent = verseEntities.map((e) => e.content).join(" ");

    final List<Verse> verses;

    if(includeSelectedVerses){
      final surahName = await _surahDao.getSurahNameById(surahId);
      verses = verseEntities.map((e) => e.toVerse(surahName: surahName ?? '')).toList();
    }else{
      verses = [];
    }


    return _QuranDataResponse(
      arabicContent: arabicContent,
      meaningContent: meaningContent,
      verses: verses
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
  final List<Verse> verses;
  _QuranDataResponse({
    required this.arabicContent,
    required this.meaningContent,
    required this.verses
  });
}

