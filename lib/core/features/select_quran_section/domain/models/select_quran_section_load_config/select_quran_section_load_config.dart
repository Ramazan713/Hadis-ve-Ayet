

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'select_quran_section_load_config.freezed.dart';

@freezed
class SelectQuranSectionLoadConfig with _$SelectQuranSectionLoadConfig{
  const factory SelectQuranSectionLoadConfig({
    int? page,
    int? surahId,
    String? firstVerseNumber,
    String? lastVerseNumber
  }) = _SelectQuranSectionLoadConfig;
}