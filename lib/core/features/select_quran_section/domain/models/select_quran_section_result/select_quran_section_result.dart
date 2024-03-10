

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/verse_number.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';
part 'select_quran_section_result.freezed.dart';

@freezed
class SelectQuranSectionResult with _$SelectQuranSectionResult{
  const factory SelectQuranSectionResult({
    required int pageNo,
    required int pagePos,
    required Cuz selectedCuz,
    required Surah selectedSurah,
    required VerseNumber firstSelectedVerseNumber,
    required VerseNumber lastSelectedVerseNumber,
    required String meaningContent,
    required String arabicContent,
    required String name,
    required List<Verse> selectedVerses,
    required String source
  }) = _SelectQuranSectionResult;
}