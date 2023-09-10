import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hadith/core/domain/enums/audio_quality_enum.dart';
import 'package:hadith/core/features/verse_audio/domain/enums/quran_audio_option.dart';

part 'download_audio_param.g.dart';

@JsonSerializable(explicitToJson: true)
class DownloadAudioParam extends Equatable{
  final String identifier;
  final int itemIdForOption;
  final QuranAudioOption op;
  final int? startVerseId;
  final AudioQualityEnum audioQualityEnum;

  const DownloadAudioParam({
    required this.identifier,
    required this.itemIdForOption,
    required this.op,
    required this.audioQualityEnum,
    this.startVerseId
  });

  factory DownloadAudioParam.fromJson(Map<String, dynamic> json) => _$DownloadAudioParamFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadAudioParamToJson(this);

  @override
  List<Object?> get props => [identifier, itemIdForOption, op, startVerseId];
}