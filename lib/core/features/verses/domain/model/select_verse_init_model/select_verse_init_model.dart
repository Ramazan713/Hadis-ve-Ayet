
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';

import '../verse_number.dart';
part 'select_verse_init_model.freezed.dart';

@freezed
class SelectVerseInitModel with _$SelectVerseInitModel{
  const factory SelectVerseInitModel({
    required List<Cuz> cuzs,
    required List<Surah> surahes,
    required List<VerseNumber> currentVerseNumbers,
    required int pageMaxPos
  }) = _SelectVerseInitModel;
}