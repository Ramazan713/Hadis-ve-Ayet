import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hadith/core/features/verse_audio/domain/enums/quran_audio_option.dart';

part 'listen_audio_param.g.dart';

@JsonSerializable(explicitToJson: true)
class ListenAudioParam extends Equatable{
  final String identifier;
  final int itemId;
  final QuranAudioOption op;
  final int? startVerseId;

  const ListenAudioParam({required this.identifier, required this.itemId, required this.op, this.startVerseId});

  factory ListenAudioParam.fromJson(Map<String, dynamic> json) => _$ListenAudioParamFromJson(json);

  Map<String, dynamic> toJson() => _$ListenAudioParamToJson(this);

  @override
  List<Object?> get props => [identifier, itemId, op, startVerseId];
}