

import 'package:collection/collection.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';
import 'package:hadith/core/features/select_edition/models/select_audio_edition.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/audio_quality_enum.dart';

class EditionUtil{

  static final _editionBitrateMap = {
    "ar.hudhaify": AudioQualityEnum.q32,
    "ar.ibrahimakhbar": AudioQualityEnum.q32,
    "ar.parhizgar": AudioQualityEnum.q48,
    "ar.abdulbasitmurattal": AudioQualityEnum.q64,
    "ar.abdullahbasfar": AudioQualityEnum.q64,
    "ar.abdulsamad": AudioQualityEnum.q64,
    "ar.abdurrahmaansudais": AudioQualityEnum.q64,
    "ar.ahmedajamy": AudioQualityEnum.q64,
    "ar.alafasy": AudioQualityEnum.q64,
    "ar.aymanswoaid": AudioQualityEnum.q64,
    "ar.hanirifai": AudioQualityEnum.q64,
    "ar.husary": AudioQualityEnum.q64,
    "ar.husarymujawwad": AudioQualityEnum.q64,
    "ar.mahermuaiqly": AudioQualityEnum.q64,
    "ar.minshawimujawwad": AudioQualityEnum.q64,
    "ar.saoodshuraym": AudioQualityEnum.q64,
    "ar.shaatree": AudioQualityEnum.q64,
    "ur.khan": AudioQualityEnum.q64,
    "ar.minshawi": AudioQualityEnum.q128,
    "ar.muhammadayyoub": AudioQualityEnum.q128,
    "ar.muhammadjibreel": AudioQualityEnum.q128,
    "fr.leclerc": AudioQualityEnum.q128,
    "zh.chinese": AudioQualityEnum.q128,
    "en.walk": AudioQualityEnum.q192
  };

  static List<SelectAudioEdition> transformEditions(List<AudioEdition> editions, List<String> selectedIdentifiers){
    return editions.map((e){
      return transformEdition(e, selectedIdentifiers);
    }).whereNotNull().toList();
  }

  static SelectAudioEdition? transformEdition(AudioEdition? edition, List<String> selectedIdentifiers){
    if(edition == null) return null;
    final quality = _editionBitrateMap[edition.identifier];
    if(quality == null) return null;
    return SelectAudioEdition(
      audioEdition: edition,
      qualityEnum: quality,
      isSelected: selectedIdentifiers.contains(edition.identifier)
    );
  }

}