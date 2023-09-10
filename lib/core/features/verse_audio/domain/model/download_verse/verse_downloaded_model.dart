import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verse_downloaded_model.g.dart';

@JsonSerializable(explicitToJson: true)
class VerseDownloadedVoiceModel extends Equatable{
  final int verseId;
  final int mealId;
  final int verseNumberTr;
  final int surahId;
  final String surahName;
  final int cuzNo;
  final int pageNo;

  const VerseDownloadedVoiceModel({
    required this.verseId,
    required this.surahId,
    required this.surahName,
    required this.mealId,
    required this.verseNumberTr,
    required this.cuzNo,
    required this.pageNo
  });

  VerseDownloadedVoiceModel copyWith({
    int? surahId,
    int? verseId,
    int? cuzNo,
    String? surahName,
    int? mealId,
    int? verseNumberTr,
    int? pageNo
  }){
    return VerseDownloadedVoiceModel(
        surahId: surahId ?? this.surahId,
        verseId: verseId ?? this.verseId,
        cuzNo: cuzNo ?? this.cuzNo,
        surahName: surahName ?? this.surahName,
        mealId: mealId ?? this.mealId,
        verseNumberTr: verseNumberTr ?? this.verseNumberTr,
        pageNo: pageNo ?? this.pageNo
    );
  }


  factory VerseDownloadedVoiceModel.fromJson(Map<String, dynamic> json) => _$VerseDownloadedVoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerseDownloadedVoiceModelToJson(this);

  @override
  List<Object?> get props => [mealId, verseId, surahId, surahName, pageNo, cuzNo, verseNumberTr];
}