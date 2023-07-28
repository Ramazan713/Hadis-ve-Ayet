

import 'package:hadith/core/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/domain/models/audio_edition.dart';

class EditionUtil{

  static final _editionBitrates={
    AudioQualityEnum.q32.quality:["ar.abdullahbasfar","ar.hudhaify","ar.ibrahimakhbar"],

    AudioQualityEnum.q48.quality:["ar.parhizgar"],

    AudioQualityEnum.q64.quality:["ar.abdulbasitmurattal","ar.abdullahbasfar","ar.abdulsamad","ar.abdurrahmaansudais","ar.ahmedajamy",
      "ar.alafasy","ar.aymanswoaid","ar.hanirifai","ar.hudhaify","ar.husary","ar.husarymujawwad","ar.mahermuaiqly","ar.minshawimujawwad",
      "ar.saoodshuraym","ar.shaatree","ur.khan"],

    AudioQualityEnum.q128.quality:["ar.ahmedajamy","ar.alafasy","ar.hudhaify","ar.husary","ar.husarymujawwad","ar.mahermuaiqly",
      "ar.minshawi","ar.muhammadayyoub","ar.muhammadjibreel","ar.shaatree","fr.leclerc","zh.chinese"],

    AudioQualityEnum.q192.quality:["ar.abdulbasitmurattal","ar.abdullahbasfar","ar.abdurrahmaansudais","ar.hanirifai","en.walk"]
  };

  static List<AudioEdition>filterEditions(List<AudioEdition> editions, AudioQualityEnum qualityEnum){
    final bitrateList = _editionBitrates[qualityEnum.quality]??[];
    return editions.where((element) => bitrateList.contains(element.identifier)).toList();
  }

  static bool isEditionInQuality(AudioEdition edition,AudioQualityEnum audioQuality){
    return _editionBitrates[audioQuality.quality]!.contains(edition.identifier);
  }

}