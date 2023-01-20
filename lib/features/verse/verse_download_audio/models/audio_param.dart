

import 'package:hadith/db/entities/verse.dart';
import 'package:hadith/features/verse/common_constants/quran_audio_option.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audio_param.g.dart';
@JsonSerializable(explicitToJson: true)
class AudioParam{
  final int mealId;
  final int cuzNo;
  final int pageNo;
  final int surahId;
  final QuranAudioOption option;

  AudioParam({required this.mealId, required this.cuzNo, required this.pageNo, required this.surahId, required this.option});

  factory AudioParam.fromVerse(Verse verse,QuranAudioOption option){
    return AudioParam(mealId: verse.id??0, cuzNo: verse.cuzNo, pageNo: verse.pageNo, surahId: verse.surahId, option: option);
  }


  factory AudioParam.fromJson(Map<String, dynamic> json) => _$AudioParamFromJson(json);

  Map<String, dynamic> toJson() => _$AudioParamToJson(this);

}