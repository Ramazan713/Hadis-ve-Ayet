

import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/select_verse_init_model/select_verse_init_model.dart';
import 'package:hadith/core/features/verses/domain/model/select_verse_model/select_verse_model.dart';
import 'package:hadith/core/features/verses/domain/model/verse_number.dart';
import 'package:hadith/core/features/verses/domain/repo/select_verse_page_repo.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';

import '../../domain/manager/select_verse_manager.dart';

class SelectVerseManagerImpl extends SelectVerseManager{
  late final SelectVersePageRepo _versePageRepo;

  SelectVerseManagerImpl({
    required SelectVersePageRepo selectVersePageRepo,
  }){
    _versePageRepo = selectVersePageRepo;
  }

  @override
  Future<SelectVerseInitModel> getInitModel() async{
    final cuzs = await _versePageRepo.getCuzs();
    final surahes = await _versePageRepo.getSurahes();
    final pageMaxPos = await _versePageRepo.getMaxPage();
    final validVerseNumbers = await _getVerseNumbers(surahes.firstOrNull);

    return SelectVerseInitModel(
        cuzs: cuzs,
        surahes: surahes,
        currentVerseNumbers: validVerseNumbers,
        pageMaxPos: pageMaxPos
    );
  }

  @override
  Future<SelectVerseModel> selectCuz({
    required Cuz currentCuz,
    int? currentPage,
    Surah? currentSurah,
    VerseNumber? currentVerseNumber
  }) async{
    final selectedSurah = await _versePageRepo.validateSurahByCuzNo(currentSurah, currentCuz.no);
    final selectedVerseNumber = await _versePageRepo.validateVerseNumber(currentVerseNumber?.text ?? "", selectedSurah?.id ?? 0, currentCuz.no);
    final selectedPage = await _currentPageOrExecute(currentPage, (page){
      return _versePageRepo.validatePageBySurah(page, selectedSurah?.id ?? 0, selectedVerseNumber ?? "");
    }) ?? 1;

    final selectedVerseNumberModel = VerseNumber(text: selectedVerseNumber ?? "");
    final validVerseNumbers = await _getVerseNumbers(selectedSurah);

    return SelectVerseModel(
        cuz: currentCuz,
        surah: selectedSurah,
        currentVerseNumber: selectedVerseNumberModel,
        validVerseNumbers: validVerseNumbers,
        page: selectedPage
    );
  }

  @override
  Future<SelectVerseModel> selectSurah({
    required Surah currentSurah,
    Cuz? currentCuz,
    int? currentPage,
    VerseNumber? currentVerseNumber
  }) async {
    final selectedCuz = await _versePageRepo.validateCuzBySurah(currentCuz, currentSurah.id, currentVerseNumber?.text ?? "");
    final selectedVerseNumber = await _versePageRepo.validateVerseNumber(currentVerseNumber?.text ?? "", currentSurah.id, selectedCuz?.no ?? 0);
    final selectedPage = await _currentPageOrExecute(currentPage, (page){
      return _versePageRepo.validatePageBySurah(page, currentSurah.id, selectedVerseNumber ?? "");
    }) ?? 1;
    final verseNumber = VerseNumber(text: selectedVerseNumber ?? "");
    final validVerseNumbers = await _getVerseNumbers(currentSurah);

    return SelectVerseModel(
        cuz: selectedCuz,
        surah: currentSurah,
        currentVerseNumber: verseNumber,
        validVerseNumbers: validVerseNumbers,
        page: selectedPage
    );
  }

  @override
  Future<SelectVerseModel> selectVerse({
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

    return SelectVerseModel(
        cuz: selectedCuz,
        surah: currentSurah,
        currentVerseNumber: currentVerseNumber,
        validVerseNumbers: validVerseNumbers,
        page: selectedPage
    );
  }

  @override
  Future<SelectVerseModel> selectPage({
    required int currentPage,
    VerseNumber? currentVerseNumber,
    Surah? currentSurah,
    Cuz? currentCuz,
  }) async {
    final selectedCuz = await _versePageRepo.validateCuzByPageNo(currentCuz, currentPage);
    final selectedSurah = await _versePageRepo.validateSurahByPageNo(currentSurah, currentPage);
    final selectedVerseNumber = await _versePageRepo.validateVerseNumberWithPage(currentVerseNumber?.text ?? "", selectedSurah?.id ?? 0, selectedCuz?.no ?? 0, currentPage);
    final verseNumber = VerseNumber(text: selectedVerseNumber ?? "");
    final validVerseNumbers = await _getVerseNumbers(currentSurah);

    return SelectVerseModel(
        cuz: selectedCuz,
        surah: selectedSurah,
        currentVerseNumber: verseNumber,
        validVerseNumbers: validVerseNumbers,
        page: currentPage
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

}