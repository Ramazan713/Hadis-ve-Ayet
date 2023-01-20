

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'download_voice_entity.g.dart';

@JsonSerializable(explicitToJson: true)
@Entity(tableName: "verseAudioDownloadTemp")
class DownloadVoiceEntity extends Equatable{
  @primaryKey
  final int verseId;
  final int surahId;
  final int mealId;
  final int cuzNo;
  final int verseNumber;
  final String surahName;

  const DownloadVoiceEntity({required this.surahId,required this.verseId,required this.verseNumber,
    required this.cuzNo,required this.surahName,required this.mealId});

  DownloadVoiceEntity copyWith({int? surahId,int? verseId,
    int? cuzNo,String? surahName,int? mealId,int? verseNumber}){
    return DownloadVoiceEntity(
        surahId: surahId??this.surahId, verseId: verseId??this.verseId, cuzNo: cuzNo??this.cuzNo,
        surahName: surahName??this.surahName, mealId: mealId??this.mealId,verseNumber: verseNumber??this.verseNumber);
  }

  factory DownloadVoiceEntity.fromJson(Map<String, dynamic> json) => _$DownloadVoiceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadVoiceEntityToJson(this);

  @override
  String toString() {
    return """DownloadVoiceModel(surahId=$surahId, verseId=$verseId, mealId=$mealId, cuzNo=$cuzNo, verseNumber=$verseNumber, surahName=$surahName)""";
  }

  @override
  List<Object?> get props => [surahId,verseId,surahName,cuzNo,verseNumber,mealId];
}