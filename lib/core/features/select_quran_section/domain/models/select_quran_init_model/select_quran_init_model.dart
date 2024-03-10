
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/features/select_quran_section/domain/models/verse_number.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';
part 'select_quran_init_model.freezed.dart';

@freezed
class SelectQuranInitModel with _$SelectQuranInitModel{
  const factory SelectQuranInitModel({
    required List<Cuz> cuzs,
    required List<Surah> surahes,
    required List<VerseNumber> currentVerseNumbers,
    required int pageMaxPos,
    String? meaningContent,
    String? arabicContent,
  }) = _SelectQuranInitModel;
}