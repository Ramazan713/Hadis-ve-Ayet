

import 'package:hadith/features/verses/cuz/domain/models/cuz.dart';
import 'package:hadith/features/verses/shared/domain/models/select_page_validation_result/select_page_validation_result.dart';
import 'package:hadith/features/verses/shared/domain/models/verse_number.dart';
import 'package:hadith/features/verses/shared/domain/repo/select_verse_page_repo.dart';
import 'package:hadith/features/verses/surah/domain/models/surah.dart';

class SelectSurah{

  late final SelectVersePageRepo _selectPageRepo;

  SelectSurah({
    required SelectVersePageRepo selectVersePageRepo
  }){
    _selectPageRepo = selectVersePageRepo;
  }

  Future<SelectPageValidationResult> call({
    required Surah surah,
    Cuz? currentCuz,
    required int currentPage,
    VerseNumber? currentVerseNumber
  })async{
    final selectedCuz = await _selectPageRepo.validateCuzBySurah(currentCuz, surah.id, currentVerseNumber?.text ?? "");
    final selectedVerseNumber = await _selectPageRepo.validateVerseNumber(currentVerseNumber?.text ?? "", surah.id, selectedCuz?.no ?? 0);
    final selectedPage = await _selectPageRepo.validatePageBySurah(currentPage, surah.id, selectedVerseNumber ?? "");

    final verseNumber = VerseNumber(text: selectedVerseNumber ?? "");

    return SelectPageValidationResult(
        cuz: selectedCuz,
        surah: surah,
        verseNumber: verseNumber,
        page: selectedPage ?? 1
    );
  }


}