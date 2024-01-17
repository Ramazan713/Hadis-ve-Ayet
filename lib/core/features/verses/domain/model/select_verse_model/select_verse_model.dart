
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/features/verses/domain/model/cuz.dart';
import 'package:hadith/core/features/verses/domain/model/verse_number.dart';
import 'package:hadith/core/features/verses/domain/model/surah.dart';
part 'select_verse_model.freezed.dart';

@freezed
class SelectVerseModel with _$SelectVerseModel{
  const factory SelectVerseModel({
    required Cuz? cuz,
    required Surah? surah,
    required VerseNumber? currentVerseNumber,
    required List<VerseNumber> validVerseNumbers,
    required int page
  }) = _SelectVerseModel;
}