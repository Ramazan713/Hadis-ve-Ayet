
import 'package:hadith/features/verses/cuz/domain/models/cuz.dart';
import 'package:hadith/features/verses/shared/domain/models/select_page_validation_result/select_page_validation_result.dart';
import 'package:hadith/features/verses/shared/domain/models/verse_number.dart';
import 'package:hadith/features/verses/shared/domain/repo/select_verse_page_repo.dart';
import 'package:hadith/features/verses/surah/domain/models/surah.dart';

class SelectPage{

  late final SelectVersePageRepo _selectPageRepo;

  SelectPage({
    required SelectVersePageRepo selectVersePageRepo
  }){
    _selectPageRepo = selectVersePageRepo;
  }

  Future<SelectPageValidationResult> call({
    required int currentPage,
    Surah? currentSurah,
    Cuz? currentCuz,
    VerseNumber? currentVerseNumber
  })async{
    final selectedCuz = await _selectPageRepo.validateCuzByPageNo(currentCuz, currentPage);
    final selectedSurah = await _selectPageRepo.validateSurahByPageNo(currentSurah, currentPage);
    final selectedVerseNumber = await _selectPageRepo.validateVerseNumberWithPage(currentVerseNumber?.text ?? "", selectedSurah?.id ?? 0, selectedCuz?.no ?? 0, currentPage);

    final verseNumber = VerseNumber(text: selectedVerseNumber ?? "");
    return SelectPageValidationResult(
        cuz: selectedCuz,
        surah: selectedSurah,
        verseNumber: verseNumber,
        page: currentPage
    );
  }


}