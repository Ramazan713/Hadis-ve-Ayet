


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/models/verse/verse.dart';
part 'select_quran_content.freezed.dart';

@freezed
class SelectQuranContent with _$SelectQuranContent{
  const factory SelectQuranContent({
    required String arabicContent,
    required String meaningContent,
    required List<Verse> verses
  }) = _SelectQuranContent;
}