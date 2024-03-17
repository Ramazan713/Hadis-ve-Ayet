

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/audio_quality_enum.dart';
part 'select_audio_edition.freezed.dart';

@freezed
class SelectAudioEdition with _$SelectAudioEdition{
  const factory SelectAudioEdition({
    required AudioEdition audioEdition,
    required bool isSelected,
    required AudioQualityEnum qualityEnum
  }) = _SelectAudioEdition;
}