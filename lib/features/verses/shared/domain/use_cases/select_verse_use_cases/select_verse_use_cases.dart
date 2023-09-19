

import 'package:hadith/features/verses/shared/domain/use_cases/select_verse_use_cases/select_cuz.dart';
import 'package:hadith/features/verses/shared/domain/use_cases/select_verse_use_cases/select_page.dart';
import 'package:hadith/features/verses/shared/domain/use_cases/select_verse_use_cases/select_surah.dart';
import 'package:hadith/features/verses/shared/domain/use_cases/select_verse_use_cases/select_verse_number.dart';

class SelectVerseUseCases{
  final SelectCuz selectCuz;
  final SelectSurah selectSurah;
  final SelectVerseNumber selectVerseNumber;
  final SelectPage selectPage;

  SelectVerseUseCases({
    required this.selectPage,
    required this.selectVerseNumber,
    required this.selectSurah,
    required this.selectCuz
  });
}