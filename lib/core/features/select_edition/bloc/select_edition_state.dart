import 'package:hadith/core/constants/k_pref.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hadith/core/features/select_edition/models/select_audio_edition.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/model/basic_audio_request/basic_audio_request.dart';
part 'select_edition_state.freezed.dart';

@freezed
class SelectEditionState with _$SelectEditionState{

  const SelectEditionState._();

  const factory SelectEditionState({
    required List<SelectAudioEdition> items,
    required bool isLoading,
    required BasicAudioRequest audioRequest,
    required String audioRequestSource,
    String? message,
    SelectAudioEdition? selectedEdition,
    SelectAudioEdition? lastSavedEdition,
  }) = _SelectEditionState;

  static SelectEditionState init(){
    return const SelectEditionState(
      isLoading: false,
      items: [],
      audioRequest: BasicAudioRequest(
          surahId: 1, startVerseId: "1"
      ),
      audioRequestSource: "Fatiha 1"
    );
  }

  bool get editionChanged => selectedEdition?.audioEdition?.identifier != lastSavedEdition?.audioEdition?.identifier;

  bool get anyChanged => editionChanged;

  bool get saveButtonEnabled => anyChanged && items.contains(selectedEdition);

  bool get resetButtonEnabled => anyChanged;

}

