



import 'package:hadith/features/verses/cuz/domain/models/cuz.dart';
import 'package:hadith/features/verses/shared/domain/models/select_page_validation_result/select_page_validation_result.dart';
import 'package:hadith/features/verses/shared/domain/models/verse_number.dart';
import 'package:hadith/features/verses/shared/domain/repo/select_verse_page_repo.dart';
import 'package:hadith/features/verses/surah/domain/models/surah.dart';

class SelectVerseNumber{

  late final SelectVersePageRepo _selectPageRepo;

  SelectVerseNumber({
    required SelectVersePageRepo selectVersePageRepo
  }){
    _selectPageRepo = selectVersePageRepo;
  }

  Future<SelectPageValidationResult> call({
    required VerseNumber currentVerseNumber,
    Surah? currentSurah,
    Cuz? currentCuz,
    required int currentPage,
  })async{
    final selectedCuz = await _selectPageRepo.validateCuzBySurah(currentCuz, currentSurah?.id ?? 0, currentVerseNumber.text);
    final selectedPage = await _selectPageRepo.validatePageBySurah(currentPage, currentSurah?.id ?? 0, currentVerseNumber.text);
    return SelectPageValidationResult(
      cuz: selectedCuz,
      surah: currentSurah,
      verseNumber: currentVerseNumber,
      page: selectedPage ?? 1
    );
  }


}