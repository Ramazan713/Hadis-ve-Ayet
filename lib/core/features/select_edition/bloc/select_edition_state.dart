import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/audio_quality_enum.dart';
part 'select_edition_state.freezed.dart';

@freezed
class SelectEditionState with _$SelectEditionState{

  const SelectEditionState._();

  const factory SelectEditionState({
    required List<AudioEdition> items,
    required AudioQualityEnum selectedQuality,
    required AudioQualityEnum lastSavedQuality,
    required bool isLoading,
    String? message,
    AudioEdition? selectedEdition,
    AudioEdition? lastSavedEdition,
  }) = _SelectEditionState;

  static SelectEditionState init(){
    return SelectEditionState(
      isLoading: false,
      items: const[],
      selectedQuality: KPref.audioQualityEnum.defaultPrefEnum,
      lastSavedQuality: KPref.audioQualityEnum.defaultPrefEnum,
    );
  }

  bool get qualityChanged => selectedQuality != lastSavedQuality;

  bool get editionChanged => selectedEdition?.identifier != lastSavedEdition?.identifier;

  bool get anyChanged => qualityChanged || editionChanged;

  bool get saveButtonEnabled => anyChanged && items.contains(selectedEdition);

  bool get resetButtonEnabled => anyChanged;

}

