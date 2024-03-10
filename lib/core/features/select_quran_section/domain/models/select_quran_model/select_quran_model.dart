
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/verse_number.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';
part 'select_quran_model.freezed.dart';

@freezed
class SelectQuranModel with _$SelectQuranModel{
  const factory SelectQuranModel({
    required Cuz? cuz,
    required Surah? surah,
    required VerseNumber? firstVerseNumber,
    required VerseNumber? lastVerseNumber,
    required List<VerseNumber> validVerseNumbers,
    required int page
  }) = _SelectQuranModel;
}