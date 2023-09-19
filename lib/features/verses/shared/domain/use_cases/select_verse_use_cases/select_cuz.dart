

import 'package:hadith/features/verses/cuz/domain/models/cuz.dart';
import 'package:hadith/features/verses/shared/domain/models/select_page_validation_result/select_page_validation_result.dart';
import 'package:hadith/features/verses/shared/domain/models/verse_number.dart';
import 'package:hadith/features/verses/shared/domain/repo/select_verse_page_repo.dart';
import 'package:hadith/features/verses/surah/domain/models/surah.dart';

class SelectCuz{

  late final SelectVersePageRepo _selectPageRepo;

  SelectCuz({
    required SelectVersePageRepo selectVersePageRepo
  }){
    _selectPageRepo = selectVersePageRepo;
  }

  Future<SelectPageValidationResult> call({
    required Cuz cuz,
    required int currentPage,
    Surah? currentSurah,
    VerseNumber? currentVerseNumber
  })async{
    final selectedSurah = await _selectPageRepo.validateSurahByCuzNo(currentSurah, cuz.no);
    final selectedVerseNumber = await _selectPageRepo.validateVerseNumber(currentVerseNumber?.text ?? "", selectedSurah?.id ?? 0, cuz.no);
    final selectedPage = await _selectPageRepo.validatePageBySurah(currentPage, selectedSurah?.id ?? 0, selectedVerseNumber ?? "");

    final verseNumber = VerseNumber(text: selectedVerseNumber ?? "");
    return SelectPageValidationResult(
      cuz: cuz,
      surah: selectedSurah,
      verseNumber: verseNumber,
      page: selectedPage ?? 1
    );
  }


}