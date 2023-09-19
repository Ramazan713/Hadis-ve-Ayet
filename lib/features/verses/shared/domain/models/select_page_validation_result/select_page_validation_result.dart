

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/features/verses/cuz/domain/models/cuz.dart';
import 'package:hadith/features/verses/shared/domain/models/verse_number.dart';
import 'package:hadith/features/verses/surah/domain/models/surah.dart';
part 'select_page_validation_result.freezed.dart';

@freezed
class SelectPageValidationResult with _$SelectPageValidationResult{
  const factory SelectPageValidationResult({
    required Cuz? cuz,
    required Surah? surah,
    required VerseNumber? verseNumber,
    required int page
  }) = _SelectPageValidationResult;
}