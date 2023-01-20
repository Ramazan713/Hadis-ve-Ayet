

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part './verse_audio_entity.g.dart';

@JsonSerializable(explicitToJson: true)
@Entity(tableName: "verseAudioTemp")
class VerseAudioEntity extends Equatable{
  @primaryKey
  final int mealId;

  final String surahName;
  final int surahId;
  final String identifier;
  final String editionName;
  final String? fileName;
  final int cuzNo;
  final int pageNo;
  final String verseNumber;


  const VerseAudioEntity({required this.surahName, required this.surahId, required this.identifier,
    required this.fileName, required this.cuzNo, required this.pageNo, required this.verseNumber,
    required this.mealId,required this.editionName});


  factory VerseAudioEntity.fromJson(Map<String, dynamic> json) => _$VerseAudioEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VerseAudioEntityToJson(this);

  @override
  List<Object?> get props => [surahName, surahId, identifier, fileName,
    cuzNo, pageNo, verseNumber, mealId,editionName];
}